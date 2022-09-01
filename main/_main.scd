/*
	Schroedinger's Box
	Main SuperCollider Patch
	2021 Marian Weger, Iason Svoronos-Kanavas
*/

/*===================== BELA SETUP =====================*/

s = Server.local;
~hostname = "hostname".unixCmdGetStdOut.replace("\n","").asSymbol; // get system hostname
~path = PathName(thisProcess.nowExecutingPath).pathOnly; // current path
~wavpath = ~path+/+"sounds_preprocessed"; // path to wav files. Change "preprocessed" to "raw" for using raw wavs.


// Settings
~serverLogic = true; // server-logic (fast) or sclang-logic (slow)
~measurement = false; // toggle for measurement mode
~debugOnsets = false; // debug printing for onset detection
~debugSourcePos = false; // debug printing for sound localization
~debugSound = false; // debug printing for sound triggering
~maxVoices = 3; // maximum number of allocated voices
~minVoices = 2; // minimum number of allocated voices (2 is basically one voice, but with smooth fadeout)
~sendToRemote = false; // send OSC update/sync messages to remote
~receiveOSC = false; // receive OSC messages



// Set up options
if(~hostname==\bela, { // If running on Bela
	s.options.sampleRate = 48000;
	s.options.numAnalogInChannels = 4;
	s.options.numAnalogOutChannels = 4;
	s.options.numDigitalChannels = 2;
	s.options.headphoneLevel = 0;
	s.options.pgaGainLeft = 0;
	s.options.pgaGainRight = 0;
	s.options.speakerMuted = 1;
	s.options.dacLevel = 0; // sets the gain of the dac to 0 dB
	s.options.adcLevel = 0; // sets the gain of the adc to 0 dB
	s.options.numMultiplexChannels = 0; // do not enable multiplexer channels
	s.options.maxLogins = 4;
	s.options.blockSize = 32;
	s.options.hardwareBufferSize = 32;
	s.options.numInputBusChannels = 4;
	s.options.numOutputBusChannels = 4;
	n = [ NetAddr("192.168.0.101", 57120), NetAddr("192.168.0.102", 57120), NetAddr("192.168.0.103", 57120) ]; // set GUI addresses
	"Bela recognized itself as Bela.".postln;
}, { // If running elsewhere (debug)
	s.options.numInputBusChannels = 4;
	s.options.numOutputBusChannels = 4;
	n = [ NetAddr("localhost", 57120) ];
	"No Bela detected. --> Debug mode.".postln;
});


/*===================== VARIABLE INITIALIZATIONS =====================*/

// Dictionaries
x = (); // synth dictionary
p = (); // parameter dictionary
p.tt = (); // test tone parameters
p.voicer = ();
p.primary = (); // primary sound parameters
p.secondary = (); // secondary sound parameters
p[\yield] = (); // yield sound parameters
p.od = (); // onset detection parameters
p.master = (); // master parameters
q = (); // other parameters

// Variable Init
//~tbodTriggered = false; // flag to store if TBOD has triggered
//~fbodAgrees = false; // flag to store if FBOD agreed with TBOD
~secondaryPossible = true; // flag used in secondary sound logic
~presetIsReady = true; // flag to say if a preset can be loaded

// Init variables that are unique to server or sclang logic
if(~serverLogic, {
	// server logic variables
}, {
	// sclang logic variables
	~globalvels = 0.0!4; // init global velocities
	~globalvel = 0.0; // init velocity
	~sourcePos = 0.0!2; // init source position
});


// SETTINGS MAPPING INIT

(~path+/+"settings.scd").standardizePath.load; // load settings file

p[\od].tbThresh = e.tbThreshDB.dbamp;
p[\od].tbThreshLo = e.tbThreshLoDB.dbamp;
p[\od].velDelay = e.velDelay;
p[\od].tbRefPeriod = e.tbRefPeriod;
p[\od].tbLpf1Freq = e.tbLpf1Freq;
p[\od].tbLpf2Freq = e.tbLpf2Freq;
p[\od].tbHpfFreq = e.tbHpfFreq;
p[\od].inGain1 = e.inGain1.dbamp;
p[\od].inGain1 = e.inGain2.dbamp;
p[\od].inGain1 = e.inGain3.dbamp;
p[\od].inGain1 = e.inGain4.dbamp;

q.rateRand = e.rateRand + 1.0;
q.yieldThreshold = e.yieldThreshold;
q.secondaryMinDel = e.secondaryMinDel;
q.secondaryMaxDel = e.secondaryMaxDel;
q.secondaryMinCount = e.secondaryMinCount;
q.secondaryMaxCount = e.secondaryMaxCount;
q.secondaryCountCurve = e.secondaryCountCurve;
q.testOnsetVel = e.testOnsetVel;
q.testOnsetFreq = e.testOnsetFreq;
q.testOnsetPosX = e.testOnsetPosX;
q.testOnsetPosY = e.testOnsetPosY;


if(~serverLogic, {
	// Server Logic
	p.od.velMapInMax = e.velMapInMax;
	p.od.velMapOutMin = e.velMapOutMin;
	p.od.velMapOutMax = e.velMapOutMax;
	p.primary.velPeakLevel = e.velPeakLevel;
	p.primary.velPeakMapZeroDB = e.velPeakMapZeroDB;
	p.voicer.eqMinFreq = e.eqMinFreq;
	p.voicer.eqMaxFreq = e.eqMaxFreq;
	p.voicer.slMaxPlaybackRate = e.slMaxPlaybackRate;
	q.slMaxRatio = e.slMaxRatio;
	p.od.slMaxRatioDB = q.slMaxRatio.ampdb;

}, {
	// SCLang Logic
	q.velMapInMin = e.velMapInMin;
	q.velMapInMax = e.velMapInMax;
	q.velMapOutMin = e.velMapOutMin;
	q.velMapOutMax = e.velMapOutMax;
	q.velMapCurve = e.velMapCurve;
	q.velPeakLevel = e.velPeakLevel;
	q.velPeakMapZeroDB = e.velPeakMapZeroDB;
	q.eqMinFreq = e.eqMinFreq;
	q.eqMaxFreq = e.eqMaxFreq;
	q.velMapInMin = e.velMapInMin;
	q.slMaxPlaybackRate = e.slMaxPlaybackRate;
	q.slMinPlaybackRate = q.slMaxPlaybackRate.reciprocal;
	q.slMaxRatio = e.slMaxRatio;
	q.slMinRatio = q.slMaxRatio.reciprocal;
});

// Primary Sound
p.primary.eqGain = e.eqGain;
p.primary.eqRQ = e.eqRQ;
p.primary.level = e.primaryDB.dbamp;
p.primary.velEnvDur = e.velEnvDur;
p.master.hpfPrimary = e.hpfPrimary;

// Secondary Sound
p.secondary.upperCutoff = e.secondaryCutoff;
p.secondary.level = e.secondaryDB.dbamp;

// Yield Sound
p[\yield].level = e.yieldDB.dbamp;

// Master
p.master.primaryLevel = e.primaryMasterDB.dbamp;
p.master.secondaryLevel = e.secondaryMasterDB.dbamp;
p.master.yieldLevel = e.yieldMasterDB.dbamp;
p.master.lpf = e.masterLPF;
p.master.hpf = e.masterHPF;
p.master.eq = e.eq;
p.master.masterLevel = e.masterLevel.dbamp;

// Test Tone Generator
p.tt.testFreq = e.testFreq;
p.tt.noiseMasterDB = e.noiseMasterDB;
p.tt.sineMasterDB = e.sineMasterDB;
p.tt.toggleSine = e.toggleSine;
p.tt.toggleNoise = e.toggleNoise;
p.tt.toggle1 = e.toggle1;
p.tt.toggle2 = e.toggle2;
p.tt.toggle3 = e.toggle3;
p.tt.toggle4 = e.toggle4;
p.tt.flip1 = e.flip1;
p.tt.flip2 = e.flip2;
p.tt.flip3 = e.flip3;
p.tt.flip4 = e.flip4;


/*===================== SOUND SELECTION =====================*/


// function to read wav files into buffers
~fillSamples = {|filenames,channels=0|
	// note: "filenames" needs to be an array of basenames without ".wav" extension.
	filenames.collect{|item,i|
		Buffer.readChannel(s, ~wavpath+/+item++".wav", channels: channels)
	};
};
~fillNSamples = {|filename,nSamples,digits=2,startIndex=1,channels=0|
	// note: "filename" needs to be a basenames without ".wav" extension and without numbering.
	nSamples.collect{|i|
		Buffer.readChannel(s, ~wavpath+/+filename++(i+startIndex).asPaddedString(digits)++".wav", channels: channels)
	};
};


// scan for presets
q[\presetIDs] = Array.new(1000); // Warning: hard-coded fixed size 1000, should be enough for all time!
PathName.new((~path+/+"presets").standardizePath).files.do{ |item|
	var path = item;
	var filename = item.fileNameWithoutExtension;
	if(filename.contains("sound"), {
		q[\presetIDs].add(PathName.new(filename).endNumber);
	});
};
q[\presetIDs] = q[\presetIDs].sort; // Get list of found presets in ascending order


// PRESET CHANGE FUNCTION
~presetChangeFunc = { |preset|
	if(~presetIsReady, { {
		~presetIsReady = false;

		~preset = preset; // set preset
		("New sound selected:"+~preset).postln; // notify

		// free everything that is playing
		// x[\tt].free;
		// x[\secondary].free;
		// x[\yield].free;
		~dspGroup.freeAll; // free everything in dsp group
		Buffer.freeAll(s); // free all buffers on the server
		s.sync;

		// load default settings (these may be defined in the preset)
		~secondary = false; // secondary sound on/off
		~yield = false; // yield sound on/off
		~voices = 3; // number of simultaneous voices (polyphony)
		~ampfactor = 0.0; // primary sound level
		~ampfactorSecondary = inf.neg; // secondary sound level
		~ampfactorYield = inf.neg; // yield sound level
		~yieldPossible = true; // yield didn't happen yet?
		~secondaryCutoff = 20000.0; // cutoff for secondary sound
		~onsetCounter = 0; // onset counter (for triggering secondary sound)
		// ~primaryBuffers.do{|item| item.free }; // free buffers of primary sounds
		// ~secondaryBuffers.do{|item| item.free }; // free buffers of secondary sounds
		// ~yieldBuffers.do{|item| item.free }; // free buffers of yield sounds
		// ~dummybuffer.free;
		~dummybuffer = Buffer.alloc(s, 32, bufnum: 0);
		~secondaryMaxCount = 6; // secondary max count
		~hpfPrimary = 20.0; // default value for highpass filter of primary sound
		~primaryBuffers = [~dummybuffer, ~dummybuffer];
		~secondaryBuffers = [~dummybuffer, ~dummybuffer];
		~yieldBuffers = [~dummybuffer, ~dummybuffer];
		~presetName = "---";
		~combFilterDryWet = 1.0.neg;



		// Load preset
		if(q[\presetIDs].includes(~preset)){
			(~path+/+"presets/sound"++~preset.asInteger ++".scd").standardizePath.load; // load preset file
		}{
			// Notify if no preset was selected
			"No valid preset selected. Press the button to start!";
			~presetName = "invalid";
		};

		// clip number of voices
		~voices = ~voices.max(~minVoices).min(~maxVoices); // clip number of voices

		// init primary sound
		p.primary[\level] = ~ampfactor.dbamp; // map preset variable to synth variable
		// p.primary[\combFiltDryWet] = ~combFilterDryWet; // map preset variable to synth variable
		// p.primary[\eqGain] = ~eqGain;
		~soundSize = ~primaryBuffers.size; // number of primary sounds in this preset
		~soundIndArray = (0..(~soundSize-1)); // array of primary sound indices
		~soundBufnums = ~primaryBuffers.collect{|item| item.bufnum}; // array of bufnums for sound samples of this preset
		~lastSoundID = ~soundIndArray.choose; // choose a random start index

		// measurement mode
		if(~measurement, {
			p.od[\inchannels] = [0,0,2,3]; // 2nd channel (ch. 1) is used for measurement and thus deactivated for onset detection
		},{
			p.od[\inchannels] = [0,1,2,3]; // normal
		});


		// START SIGNAL PROCESSING (either server-side or sclang logic)
		if(~serverLogic, { // server logic

			// start onset detection
			x[\od] = Synth.new(\od, p.od.asKeyValuePairs, target: ~dspGroup, addAction: \addToHead).register; // start onset detection synth
			s.sync;

			// re-load voicer SynthDef (found no other way to set number of voices dynamically)
			(~path+/+"voicer.scd").standardizePath.load;
			s.sync;

			// create new voicer and voices
			x[\voicer] = Synth.after(x[\od], \voicer, p[\voicer].asKeyValuePairs).register;
			s.sync;

			// start primary voices
			x[\primary] = ~voices.collect{|i|
				s.sync;
				Synth.after(x[\voicer], \primaryVoice, [\voiceID, i]++p[\primary].asKeyValuePairs).register;
			};
			s.sync;

			// start master
			x[\master] = Synth.new(\master, p.master.asKeyValuePairs, target: ~dspGroup, addAction: \addToTail).register; // start master synth
			s.sync;

		}, { // SCLang logic

			x[\od] = Synth.new(\od, p.od.asKeyValuePairs, target: ~dspGroup, addAction: \addToHead).register; // start onset detection synth
			x[\master] = Synth.new(\master, p.master.asKeyValuePairs, target: ~dspGroup, addAction: \addToTail).register; // start master synth

			// free old voicer instance
			v.free;

			// new voicer setup
			v = Voicer.new(voices: ~voices, things: \primary, bus: p.primary[\busnum], target: ~dspGroup, addAction: \addToHead); // start new voicer
			v.latency = nil; // set latency of the voicer. nil means as soon as possible.
			v.stealer = \preferLate; // set voice stealing algorithm

		});

		// init master
		p.master[\hpfPrimary] = ~hpfPrimary; // map preset variable to synth variable
		x[\master].set([\hpfPrimary, p.master[\hpfPrimary]]); // set hpf cutoff of primary sound in master synth

		// init secondary sound
		p.secondary[\level] = ~ampfactorSecondary.dbamp;
		p.secondary[\upperCutoff] = ~secondaryCutoff;
		p.secondary[\secondaryMaxCount] = ~secondaryMaxCount;
		if(~secondary, {
			~secondarySize = ~secondaryBuffers.size; // number of secondary sounds in this preset
			~secondaryIndArray = (0..(~secondarySize-1)); // array of secondary sound indices
			~lastSecondaryID = ~secondaryIndArray.choose; // choose a random start index
		});

		// init yield sound
		p[\yield][\level] = ~ampfactorYield.dbamp;
		if(~yield, {
			~yieldSize = ~yieldBuffers.size; // number of yield sounds in this preset
			~yieldIndArray = (0..(~yieldSize-1)); // array of yield sound indices
			~lastYieldID = ~yieldIndArray.choose; // choose a random start index
		});

		// update remote GUI
		if(~sendToRemote, {
			n.do{|item| item.sendMsg(\bela, \primaryDB, p.primary[\level].ampdb) };
			n.do{|item| item.sendMsg(\bela, \secondaryDB, p.secondary[\level].ampdb) };
			n.do{|item| item.sendMsg(\bela, \yieldDB, p[\yield][\level].ampdb) };
			// n.do{|item| item.sendMsg(\bela, \secondaryCutoff, p.secondary[\upperCutoff]) };
			// n.do{|item| item.sendMsg(\bela, \combFiltDryWet, p.primary[\combFilterDryWet]) };
			// n.do{|item| item.sendMsg(\bela, \eqDryWet, p.primary[\eqDryWet]) };
			n.do{|item| item.sendMsg(\bela, \hpfPrimary, p.master[\hpfPrimary]) };
			n.do{|item| item.sendMsg(\bela, \secondaryMaxCount, p.secondary[\secondaryMaxCount]) };
			n.do{|item| item.sendMsg(\bela, \presetName, ~presetName) };
			n.do{|item| item.sendMsg(\bela, \secondary, ~secondary) };
			n.do{|item| item.sendMsg(\bela, \yield, ~yield) };
		});

		s.sync;

		~presetIsReady = true;
	}.fork})
};



/*===================== GUI Control / OSC Receivers =====================*/

// OSC DEF for PRESETS
if(~receiveOSC, {

	OSCdef(\preset, { | msg, time |
		var preset = msg[1].asInteger;
		~presetChangeFunc.(preset);
	},'/preset');

	(~path+/+"oscReceivers.scd").standardizePath.load; // load OSC receivers

});


/*===================== Red Button on DigitalIn =====================*/

(~path+/+"bigRedButtonBela.scd").standardizePath.load; // load OSC receivers



/*===================== SOUND TRIGGERING =====================*/


// Same for both versions


/*--------------- Same for both versions: Randomization, mapping functions, yield and secondary sound ----------------*/

~chooseSecondary = {
	// set new sample ID (random from array, but not same as previous)
	if(~secondaryIndArray.size>1, {
		~lastSecondaryID = ~secondaryIndArray[~secondaryIndArray.rejectIndices({|i| i==~lastSecondaryID})].choose;
	}, {
		~lastSecondaryID;
	});
};

~chooseYield = {
	// set new sample ID (random from array, but not same as previous)
	if(~yieldIndArray.size>1, {
		~lastYieldID = ~yieldIndArray[~yieldIndArray.rejectIndices({|i| i==~lastYieldID})].choose;
	}, {
		~lastYieldID;
	});
};


// random playback rate for yield and secondary
~randRate = {
	exprand(q[\rateRand], q[\rateRand].reciprocal); // random playback rate on exponential scale
	// if rateRand is 2.0, then rate will be random between 0.5 and 2.0.
};

/*
// random comb filtering
~randCombFreq = {
	exprand(q[\combFiltMaxFreq], q[\combFiltMinFreq]); // random frequency on exponential scale between min and max
};
*/


// random delay for starting secondary sound
~randSecondaryDelay = {
	rrand(q[\secondaryMinDel], q[\secondaryMaxDel]);
};


// Secondary sound
~maybeNewSecondarySound = {
	if(x[\secondary].isPlaying.not && ~secondary && ~secondaryPossible){
		~onsetCounter = ~onsetCounter + 1; // increment onset counter

		// Random decision (tune inMin and inMax to set minimum and maximum number of hits for 0% and 100% chance, respectively)
		if( ~onsetCounter.lincurve(inMin: q[\secondaryMinCount], inMax: q[\secondaryMaxCount], outMin: 0.0, outMax: 1.0, curve: q[\secondaryCountCurve], clip: \minmax).coin ) {
			// Trigger new secondary sound
			p.secondary[\bufnum] = ~secondaryBuffers[~chooseSecondary.()];
			p.secondary[\rate] = ~randRate.();
			~secondaryPossible = false; // block secondary sound triggers until the synth has started
			fork{
				~randSecondaryDelay.().wait;
				x[\secondary] = Synth.new(\secondary, p.secondary.asKeyValuePairs, target: ~dspGroup, addAction: \addToHead).register;
				if(~debugSound, {
					"Secondary sound started.".postln;
				});
				~secondaryPossible = true; // don't block anymore. Synth is already playing.
			};
			~onsetCounter = 1; // reset onset counter to 1 (so that there is already some small chance to directly trigger secondary sound again next time
		};

	};
};



// Yield sound
~maybeTriggerYield = {
	if(~yield&&~yieldPossible){
		if(p.primary[\vel]>q[\yieldThreshold]){
			// 1. Release all primary sounds (only necessary for sclang logic, but does no harm for server logic
			//v.set([\gate, 0], lat: nil); // deactivated: primary will continue during yield
			// 2. Trigger new yield sound
			p[\yield][\vel] = p.primary[\vel]; // set yield velocity equal to primary velocity
			p[\yield][\bufnum] = ~yieldBuffers[~chooseYield.()]; // choose random sample
			p[\yield][\rate] = ~randRate.(); // choose random playback rate
			x[\yield] = Synth.new(\yield, p[\yield].asKeyValuePairs, target: ~dspGroup, addAction: \addToHead); // create synth
			// ~yieldPossible = false; // yield not possible anymore // WARNING: yield is always possible!
		};
	};
};



/*--------------- Load either server or sclang logic ----------------*/

if(~serverLogic, {
	(~path+/+"triggerLogic_server-logic.scd").standardizePath.load; // load server-side trigger logic
}, {
	(~path+/+"triggerLogic_sclang-logic.scd").standardizePath.load; // load language-side trigger logic
});


/*===================== WAIT FOR SERVER =====================*/

s.waitForBoot{{

	/*===================== BUS AND BUFFER ALLOCATIONS =====================*/

	// create server groups
	~dspGroup = Group.new(s); // in this group are all synths for onset detection and sound processing
	~ctlGroup = Group.new(s); // in this group is only ctl stuff (sensors)

	// allocate busses
	p.primary[\busnum] = Bus.audio(s, numChannels: 1);
	p.secondary[\busnum] = Bus.audio(s, numChannels: 1);
	p[\yield][\busnum] = Bus.audio(s, numChannels: 1);

	if(~serverLogic, {
		// allocate busses
		~onsetBus = Bus.audio(s, numChannels: 4); // init audio busses for onset busses [gate, vel, posx, posy]

		~primaryCtlBus = Bus.audio(s, numChannels: 3); // init audio busses for primary sound parameters [bufnum, rate, vel]
		~gateBus = Bus.audio(s, numChannels: ~maxVoices); // init audio busses for voice gates
		~updateBus = Bus.audio(s, numChannels: ~maxVoices); // init audio busses for voice update logic
		~velTrigBus = Bus.audio(s, numChannels: 1); // velTrig bus

		// map busses
		p.od[\onsetBus] = ~onsetBus.index;
		p.od[\velTrigBus] = ~velTrigBus.index;
		p.voicer[\onsetBus] = p.od[\onsetBus];
		p.voicer[\primaryCtlBus] = ~primaryCtlBus.index;
		p.voicer[\gateBus] = ~gateBus.index;
		p.voicer[\updateBus] = ~updateBus.index;
		p.primary[\primaryCtlBus] = p.voicer[\primaryCtlBus];
		p.primary[\gateBus] = p.voicer[\gateBus];
		p.primary[\velTrigBus] = p.od[\velTrigBus];
		p.primary[\updateBus] = p.voicer[\updateBus];
	});

	// map also to master busses
	p.master[\primaryBus] = p.primary[\busnum].index;
	p.master[\secondaryBus] = p.secondary[\busnum].index;
	p.master[\yieldBus] = p[\yield][\busnum].index;

	// allocate dummy buffer that will be used by default
	~dummybuffer = Buffer.alloc(s, 32, bufnum: 0);

	// load chirp into buffer
	// p.tt[\bufnum] = Buffer.read(s, (~path+/+"chirp/chirp_"++switch(s.sampleRate.round.asInteger, 44100, "7.2s_44.1kHz", 48000, "6.6s_48kHz")++"_14_octaves_1_fadein_0_fadeout_24bit.wav").standardizePath);

	// Load Impulse Response for Equalization, to be used with PartConv
	/*
	p.master[\partConvFFTSize] = 4 * s.options.blockSize; // FFT size for the partitioned convolution. At least 4x blocksize.
	~irBuf = Buffer.read(s, (~path+/+"ir/2021-12-12_20-10-41-751_ex_ir_out_01_in_01.wav").standardizePath);
	s.sync;
	~irBufSize = PartConv.calcBufSize(p.master[\partConvFFTSize], ~irBuf);
	~irNumPartitions = PartConv.calcNumPartitions(p.master[\partConvFFTSize], ~irBuf); // for debugging only
	~irSpectrum = Buffer.alloc(s, ~irBufSize, 1);
	~irSpectrum.preparePartConv(~irBuf, p.master[\partConvFFTSize]);
	s.sync;
	~irBuf.free; // don't need time domain data anymore, just needed spectral version
	p.master[\irbufnum] = ~irSpectrum.bufnum;
	*/


	/*===================== SYNTHDEFS =====================*/

	(~path+/+"synthdefs_common.scd").standardizePath.load; // load common synth defs

	if(~serverLogic, {
		(~path+/+"synthdefs_server-logic.scd").standardizePath.load; // load synth defs
	}, {
		(~path+/+"synthdefs_sclang-logic.scd").standardizePath.load; // load synth defs
	});

	/*===================== CTL =====================*/

	s.sync;

	// start ctl synth for big red button
	x[\bigRedButton] = Synth.new(\bigRedButton, [\inPin, 0], target: ~ctlGroup);


	/*===================== MAIN =====================*/

	s.sync;

	// request parameters from GUI
	if(~sendToRemote, {
		n.do{|item| item.sendMsg(\bela, \booted) }; // send request via OSC to all addresses
	});

	"Main Patch READY.".postln;
}.fork};


/*===================== QUIT =====================*/

if(~hostname==\bela, { // If running on Bela
	ServerQuit.add({ 0.exit }); // quit if the button is pressed
});
