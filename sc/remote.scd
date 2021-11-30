/*
Schroedinger's Box
Remote Control
SuperCollider Patch
2021 Jason Svoronos-Kanavas, Marian Weger
*/
// Ⓢⓒⓗⓡⓞⓔⓓⓘⓝⓖⓔⓡⓢ Ⓑⓞⓧ

(
Platform.case(
    \osx,       { "OSX".postln;
		~localMode = "ping -c 1 bela.local; echo $?".unixCmdGetStdOut.asInteger==68;
	},
    \linux,     { "Linux".postln;
		~localMode = "ping -c 1 bela.local; echo $?".unixCmdGetStdOut.asInteger==2; // Check if Bela is reachable (false=Bela, true=local)
	},
);

if(~localMode, {
	"Oh no! Bela is unreachable. GUI starts in local mode.".postln;
	o = NetAddr("localhost", 57120); // set local address
}, {
	"Hooray! Bela responded. Connecting to Bela...".postln;
	o = NetAddr("bela.local", 57120); // set bela remote address
});


Window.closeAll;


// OSC receiver to get messages from Bela
OSCFunc({|msg, time|
	var key = msg[1];
	var val = msg[2];
	("Remote: OSC incoming:"+msg).postln;
	if(key==\booted, {
		{~gui.resend()}.defer; // let GUI resend all parameters
	}, {
		e[key] = val; // 1. update parameter in dictionary
		{~gui.upd.()}.defer; // 2. then update GUI
	});
},'/bela');


// parameter default values
e = (); // create empty dictionary

// TBOD
e.tbThreshDB = 110.0.neg; // TBOD threshold in dB
e.tbRefPeriod = 0.05;// specifies a minimum gap (in seconds) between subsequent onset detections
e.tbLpf1Freq = 25.0; // frequency of 1st low-pass filter in Hz (TBOD)
e.tbLpf2Freq = 25.0; // frequency of 2nd low-pass filter in Hz (TBOD)
e.tbHpfFreq = 4000.0; // frequency of high-pass filter in Hz  (TBOD)
e.cancelDel = 1.0; // Delay between TBOD trigger and cancel message, in FFT frames.

// FBOD
e.fbThreshDB = -20.0; // FBOD threshold in dB
e.fbRelaxtime = 1.0; // specifies the time (in seconds) for the normalisation to "forget" about a recent onset. If you find too much re-triggering (e.g. as a note dies away unevenly) then you might wish to increase this value.
e.fbFloorDB = 20.0.neg; // is a lower limit, connected to the idea of how quiet the sound is expected to get without becoming indistinguishable from noise. For some cleanly-recorded classical music with wide dynamic variations, I found it helpful to go down as far as 0.000001.
e.fbMingap = 40; // specifies a minimum gap (in FFT frames) between onset detections, a brute-force way to prevent too many doubled detections.
e.fbMedianspan = 11; // specifies the size (in FFT frames) of the median window used for smoothing the detection function before triggering.

// Velocity detection
e.velDelay = 0.006; // delay between FBOD trigger and reporting of velocity. Velocity will be the maximum in this time period.
e.defaultVel = 0.05; // default velocity
e.velUpdateLag = 0.001; // lag time for velocity update smoothing
e.velMapInMin = 0.005; // mapping between amplitude and velocity: inMin
e.velMapInMax = 0.35; // mapping between amplitude and velocity: inMax
e.velMapOutMin = 0.005; // mapping between amplitude and velocity: outMin
e.velMapOutMax = 0.7; // mapping between amplitude and velocity: outMax
e.velMapCurve = 1; // mapping between amplitude and velocity: curve

// Preset Settings
e.primaryDB = inf.neg; // primary level in dB
e.secondaryDB = inf.neg; // secondary level in dB
e.outcomeDB = inf.neg; // outcome level in dB
e.secondaryCutoff = 4000.0; // Cutoff frequency of LPF for secondary sound, in Hz
e.combFiltDryWet = 0.0; // dry/wet for comb filter


// Master
e.primaryMasterDB = 0.0; // primary level in dB
e.secondaryMasterDB = 0.0; // secondary level in dB
e.outcomeMasterDB = 0.0; // outcome level in dB
e.masterHPF = 100.0; // master HPF cutoff in Hz
e.masterLPF = 16000.0; // master LPF cutoff in Hz
e.eq = 1; // output equalization
e.masterLevel = inf.neg; // Master level in dB

// Experiment
e.participantID = 0; // participant ID
e.preset = 0; // sound preset

// Test Tone Generator
e.sineMasterDB = 80.0.neg; // level of sine generator in dB
e.noiseMasterDB = 80.0.neg; // level of noise generator in dB
e.testFreq = 400.0; // sine frequency in Hz
e.toggleMaster = 0; // start/stop the test tone synth
e.toggle1 = 0; // output channel 1 on/off
e.toggle2 = 0; // output channel 2 on/off
e.toggle3 = 0; // output channel 3 on/off
e.toggle4 = 0; // output channel 4 on/off
e.flip1 = 0; // output channel 1 flip phase
e.flip2 = 0; // output channel 2 flip phase
e.flip3 = 0; // output channel 3 flip phase
e.flip4 = 0; // output channel 4 flip phase

// Primary Sound
e.combFiltMinFreq = 20.0; // minimum combfilter frequency in Hz
e.combFiltMaxFreq = 20000.0; // maximum combfilter frequency in Hz
e.slMaxPlaybackRate = 1.1; // max playback rate, as controlled by source localization


// Source Localization
e.slMaxRatio = 5.0; // maximum amplitude ratio for source localization
e.slLpfFreq = 25.0; // lowpass filter freq for envelope detection for source localization

// Global Sound Parameters
e.playbackRand = 0.01; // percent rate randomization

// Outcome sound
e.breakingThreshold = 0.2; // threshold velocity for breaking

// Secondary Sound
e.secondaryMinDel = 0.5; // minimum start delay
e.secondaryMaxDel = 1.0; // maximum start delay
e.secondaryMinCount = 1; // min onset count for secondary trigger
e.secondaryMaxCount = 7; // max onset count for secondary trigger
e.secondaryCountCurve = 3; // curve


// GUI function definition
~schroedingersGUI = {|n, e|

	// settings of all the sliders in the GUI
	// They will appear in this order in the GUI
	// min max warp step units label factor name
	// 0   1   2    3    4     5     6      7

	// TBOD
	var sliderListTBOD = [
		[-180, 0.0, \lin, 1.0, "dB", "TBOD threshold", 1.0, \tbThreshDB],
		[80.0, 8000.0, \exp, 1.0, "Hz", "HPF cutoff", 1.0, \tbHpfFreq],
		[1.0, 120.0, \exp, 1.0, "Hz", "LPF 1 cutoff", 1.0, \tbLpf1Freq],
		[1.0, 120.0, \exp, 1.0, "Hz", "LPF 2 cutoff", 1.0, \tbLpf2Freq],
		[0.1, 500.0, \exp, 1.0, "ms", "TBOD refractory period", 1.0e-3, \tbRefPeriod],
		[0.0, 32.0, \lin, 1.0, "FFT frames", "False Alarm Cancellation delay", 1.0, \cancelDel],
	];

	// FBOD
	var sliderListFBOD = [
		[-40, 40.0, \lin, 1.0, "dB", "FBOD threshold", 1.0, \fbThreshDB],
		[0.1, 10.0, \exp, 0.1, "s", "Relax Time", 1.0, \fbRelaxtime],
		[140.0.neg, 0.0, \lin, 1.0, "dB", "Floor", 1.0, \fbFloorDB],
		[0.0, 100.0, \lin, 1.0, "FFT frames", "MinGap", 1.0, \fbMingap],
		[0.0, 30.0, \lin, 1.0, "FFT frames", "MedianSpan", 1.0, \fbMedianspan],
	];

	// Velocity Detection
	var sliderListVelocity = [
		[0.1, 50.0, \exp, 0.1, "ms", "Velocity Delay", 1.0e-3, \velDelay],
		[0.1, 50.0, \exp, 0.1, "ms", "Velocity Update Lag", 1.0e-3, \velUpdateLag],
		[0.0001, 1.0, \exp, 0.0, "", "Default Velocity", 1.0, \defaultVel],
		[0.0001, 1.0, \exp, 0.0, "", "Velocity Map: inMin", 1.0, \velMapInMin],
		[0.0001, 1.0, \exp, 0.0, "", "Velocity Map: inMax", 1.0, \velMapInMax],
		[0.0001, 1.0, \exp, 0.0, "", "Velocity Map: outMin", 1.0, \velMapOutMin],
		[0.0001, 1.0, \exp, 0.0, "", "Velocity Map: outMax", 1.0, \velMapOutMax],
		[-10, 10, \lin, 0.1, "", "Velocity Map: curve", 1.0, \velMapCurve],
	];

	// Preset
	var sliderListPresetParams = [
		[-60.0, 30.0, \lin, 0.1, "dB", "Primary sound level", 1.0, \primaryDB],
		[-60.0, 30.0, \lin, 0.1, "dB", "Secondary sound level", 1.0, \secondaryDB],
		[-60.0, 30.0, \lin, 0.1, "dB", "Outcome sound level", 1.0, \outcomeDB],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Secondary Sound Upper Cutoff", 1.0, \secondaryCutoff],
		[-1.0, 1.0, \lin, 0.0, "", "Comb Filter Dry/Wet", 1.0, \combFiltDryWet],
	];

	// Master
	var sliderListMaster = [
		[-60.0, 30.0, \lin, 0.0, "dB", "Global primary sound level", 1.0, \primaryMasterDB],
		[-60.0, 30.0, \lin, 0.0, "dB", "Global secondary sound level", 1.0, \secondaryMasterDB],
		[-60.0, 30.0, \lin, 0.0, "dB", "Global outcome sound level", 1.0, \outcomeMasterDB],
		[20.0, 20000.0, \exp, 0.1, "Hz", "Master HPF Cutoff", 1.0, \masterHPF],
		[20.0, 20000.0, \exp, 0.1, "Hz", "Master LPF Cutoff", 1.0, \masterLPF],
		[-60.0, 30.0, \lin, 0.0, "dB", "Global Master Level", 1.0, \masterLevel],
	];

	// Test Tone Generator
	var sliderListTest = [
		[-80.0, 0.0, \lin, 0.1, "dB", "Noise Volume", 1.0, \noiseMasterDB],
		[-80.0, 0.0, \lin, 0.1, "dB", "Sine Volume", 1.0, \sineMasterDB],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Sine Frequency", 1.0, \testFreq],
	];

	// Sound
	var sliderListSound = [
		[20.0, 20000.0, \exp, 1.0, "Hz", "Comb-filter Min Frequency", 1.0, \combFiltMinFreq],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Comb-filter Max Frequency", 1.0, \combFiltMaxFreq],
		[0.0, 10.0, \lin, 0.1, "%", "Playback Rate Randomization", 1.0e-2, \playbackRand],
		[0.001, 1.0, \exp, 0.0, "", "Breaking Threshold", 1.0, \breakingThreshold],
		[0.0, 5.0, \lin, 0.1, "s", "Min Delay for Secondary Sound", 1.0, \secondaryMinDel],
		[0.0, 5.0, \lin, 0.1, "s", "Max Delay for Secondary Sound", 1.0, \secondaryMaxDel],
		[0, 10, \lin, 1, "", "Secondary Min Count", 1.0, \secondaryMinCount],
		[1, 50, \lin, 1, "", "Secondary Max Count", 1.0, \secondaryMaxCount],
		[-10, 10, \lin, 0.1, "", "Secondary Count Curve", 1.0, \secondaryCountCurve],
		[1.0, 2.0, \exp, 0.0, "", "Source Position: Max Playback Rate", 1.0, \slMaxPlaybackRate],
		[1.0, 10.0, \exp, 0.0, "", "Source Localization: Max Ratio", 1.0, \slMaxRatio],
		[1.0, 120.0, \exp, 1.0, "Hz", "Source Localization: LPF cutoff", 1.0, \slLpfFreq],
	];

	// convert to dictionary, to address them by name
	var sliderDictTBOD = ().putPairs([sliderListTBOD.flop.last,sliderListTBOD].flop.flatten);
	var sliderDictFBOD = ().putPairs([sliderListFBOD.flop.last,sliderListFBOD].flop.flatten);
	var sliderDictVelocity = ().putPairs([sliderListVelocity.flop.last,sliderListVelocity].flop.flatten);
	var sliderDictPresetParams = ().putPairs([sliderListPresetParams.flop.last,sliderListPresetParams].flop.flatten);
	var sliderDictMaster = ().putPairs([sliderListMaster.flop.last,sliderListMaster].flop.flatten);
	var sliderDictTest = ().putPairs([sliderListTest.flop.last,sliderListTest].flop.flatten);
	var sliderDictSound = ().putPairs([sliderListSound.flop.last,sliderListSound].flop.flatten);


	// slider creation function
	var makeSlider = { |item|
		EZSlider(elements[\w].view, 878@22, "  "++item[5]++"  ",
			ControlSpec(minval: item[0], maxval: item[1], warp: item[2], step: item[3], default: e[item[7]]/item[6], units: item[4]),
			labelWidth: 250, unitWidth: 100, initVal: e[item[7]]/item[6], numberWidth: 60, layout: \horz, initAction: true)
		.setColors(Color.grey, Color.white)
		.font_(Font("Helvetica", 14))
		.action_({ |ez|
			e[item[7]] = ez.value*item[6]; // update value in settings dictionary
			o.sendMsg('/'++item[7], e[item[7]]); // send updated value via OSC
			(item[7]++":"+e[item[7]]).postln; // print message
		});
	};

	// toggle creation function
	var makeToggle = { |key, text|
		Button(elements[\w], Rect(0,0,80,22))
		.states_([[text, Color.white, Color.gray], [text, Color.gray, Color.green]])
		.font_(Font("Helvetica", 14))
		.action_({|obj|
			var val = obj.value.asInteger;
			e[key] = val; // update value in settings dictionary
			o.sendMsg(key, e[key]); // send updated value via OSC
			(key.asString++":"+e[key]).postln; // print message
		})
		.valueAction_(e[key]);
	};

	// function that creates sliders called by their name
	var makeSliders = {|target, dict, keys|
		keys.asArray.do{|key|
			target[key] = makeSlider.(dict[key]);
		};
	};

	// function to create a heading
	var heading = { |text|
		StaticText(elements[\w].view, 878@24)
		.string_(text++":")
		.font_(Font("Helvetica", 14))
		.stringColor_(Color.white)
		;
	};

	// dictionary that is returned by the GUI function
	var elements = ();

	// function to create a newline
	var newline = { elements[\v].nextLine };

	// dictionary to access individual sliders from outside
	elements[\tbod] = ();
	elements[\fbod] = ();
	elements[\velocity] = ();
	elements[\presetParams] = ();
	elements[\master] = ();
	elements[\test] = ();
	elements[\sound] = ();

	// Window
	elements[\w] = Window("Schrödinger's GUI", Rect(400,400,900,900), scroll: true)
	.alwaysOnTop_(true)
	.visible_(true)
	.front;

	// View
	elements[\v] = elements[\w].view
	.decorator_(FlowLayout(elements[\w].view.bounds))
	.background_(Color(0.1, 0.1, 0.1))
	.decorator.gap_(2@2);


	// GUI SETUP

	// Headline
	StaticText(elements[\w].view, 878@24)
	.align_(\center)
	.string_("Remote for Schrödinger's Box")
	.font_(Font("Helvetica", 14, bold: true))
	.stringColor_(Color.white);


	heading.("TBOD");
	newline.();
	makeSliders.(elements[\tbod], sliderDictTBOD, sliderListTBOD.flop.last);
	newline.();

	heading.("FBOD");
	newline.();
	makeSliders.(elements[\fbod], sliderDictFBOD, sliderListFBOD.flop.last);
	newline.();

	heading.("Velocity detection");
	newline.();
	makeSliders.(elements[\velocity], sliderDictVelocity, sliderListVelocity.flop.last);
	newline.();

	heading.("Preset Settings");
	newline.();
	makeSliders.(elements[\presetParams], sliderDictPresetParams, sliderListPresetParams.flop.last);
	newline.();

	heading.("Master");
	newline.();
	makeSliders.(elements[\master], sliderDictMaster, sliderListMaster.flop.last);
	elements.master.masterLevel.setColors(knobColor: Color.red);
	newline.();

	heading.("Sound");
	newline.();
	makeSliders.(elements[\sound], sliderDictSound, sliderListSound.flop.last);
	newline.();

	heading.("Test Signal Generator");
	newline.();
	makeSliders.(elements[\test], sliderDictTest, sliderListTest.flop.last);
	newline.();

	elements[\toggleMaster] = Button(elements[\w], Rect(0,0,80,22))
	.states_([["On/Off", Color.white, Color.gray], ["On/Off", Color.gray, Color.green]])
	.action_({|obj|
		var val = obj.value;
		e[\toggleMaster] = val.asInteger; // update value in settings dictionary
		o.sendMsg('/toggleMaster', e[\toggleMaster]); // send updated value via OSC
		("toggleMaster:"+e[\toggleMaster]).postln; // print message
	});

	elements[\playChirp] = Button(elements[\w], Rect(0,0,80,22))
	.states_([["Play Chirp", Color.white, Color.gray]])
	.action_({|obj|
		o.sendMsg('/playChirp', \play); // send updated value via OSC
		"playChirp: play".postln; // print message
	});

	elements[\toggles] = ();


	[[\toggleSine, "Sine"], [\toggleNoise, "Noise"]].do{ |item|
		elements[\toggles][item[0].asSymbol] = makeToggle.(item[0].asSymbol, item[1]);
	};

	newline.();

	( 4.collect{|i| i=i+1; [\toggle++i, "Ch."+i]} ++ 4.collect{|i| i=i+1; [\flip++i, "Flip Ch."+i]} ).do{ |item|
		elements[\toggles][item[0].asSymbol] = makeToggle.(item[0].asSymbol, item[1]);
	};

	newline.();

	heading.("Participant and Sound Selection");
	newline.();
	elements[\preset] = EZNumber(elements[\w].view, 180@22, "  Preset  ",
		ControlSpec(minval: -1, maxval: 99, step: 1, default: e[\preset]),
		labelWidth: 120, unitWidth: 0, initVal: e[\preset], numberWidth: 60, layout: \horz, initAction: true)
	.setColors(Color.grey, Color.white)
	.font_(Font("Helvetica", 14))
	.action_({ |ez|
		e[\preset] = ez.value.asInteger; // update value in settings dictionary
		o.sendMsg('/preset', e[\preset]); // send updated value via OSC
		("Preset:"+e[\preset]).postln; // print message
	});

	elements[\participantID] = EZNumber(elements[\w].view, 180@22, "  Participant ID  ",
		ControlSpec(minval: 0, maxval: 99, step: 1, default: e[\participantID]),
		labelWidth: 120, unitWidth: 0, initVal: e[\preset], numberWidth: 60, layout: \horz, initAction: true)
	.setColors(Color.grey, Color.white)
	.font_(Font("Helvetica", 14))
	.action_({ |ez|
		e[\participantID] = ez.value.asInteger; // update value in settings dictionary
		o.sendMsg('/participantID', e[\participantID]); // send updated value via OSC
		elements[\preset].valueAction_(1.neg); // init sample number
		("Participant ID:"+e[\participantID]).postln; // print message
	});

	newline.();
	heading.("Tools");
	newline.();

	elements[\triggerOnset] = Button(elements[\w], Rect(0,0,120,22))
	.states_([["trigger onset", Color.white, Color.gray]])
	.font_(Font("Helvetica", 14))
	.action_({|obj|
		o.sendMsg('/triggerOnset', \onset); // send updated value via OSC
		"trigger: onset".postln; // print message
	});

	elements[\panic] = Button(elements[\w], Rect(0,0,120,22))
	.states_([["PANIC", Color.white, Color.red]])
	.font_(Font("Helvetica", 14))
	.action_({|obj|
		o.sendMsg('/panic', \panic); // send updated value via OSC
		"panic: panic".postln; // print message
	});

	elements[\toggles][\eq] = makeToggle.(\eq, "EQ");

	newline.();

	// just write something in the end to have some space below buttons
	StaticText(elements[\w].view, 878@24)
	.align_(\right)
	.string_("2021 | IEM | Marian Weger, Jason Svoronos-Kanavas")
	.font_(Font("Helvetica", 14))
	.stringColor_(Color.white);


	// update function (call from outside to update GUI to current parameter values)
	elements[\upd] = {
		elements.tbod.keysValuesDo{|key,item|
			elements.tbod[key].value = e[key]/sliderDictTBOD[key][6];
		};
		elements.fbod.keysValuesDo{|key,item|
			elements.fbod[key].value = e[key]/sliderDictFBOD[key][6];
		};
		elements.velocity.keysValuesDo{|key,item|
			elements.velocity[key].value = e[key]/sliderDictVelocity[key][6];
		};
		elements.presetParams.keysValuesDo{|key,item|
			elements.presetParams[key].value = e[key]/sliderDictPresetParams[key][6];
		};
		elements.master.keysValuesDo{|key,item|
			elements.master[key].value = e[key]/sliderDictMaster[key][6];
		};
		elements.sound.keysValuesDo{|key,item|
			elements.sound[key].value = e[key]/sliderDictSound[key][6];
		};
		elements.test.keysValuesDo{|key,item|
			elements.test[key].value = e[key]/sliderDictTest[key][6];
		};
		elements[\toggles].keysValuesDo{|key,item|
			elements.toggles[key].value = e[key];
		};
		elements[\preset].value = e[\preset];
		elements[\participantID].value = e[\participantID];
		elements[\toggleMaster].value = e[\toggleMaster];
		"GUI updated"; // return message
	};

	// resend function (call from outside to resend all values)
	elements[\resend] = {
		elements.tbod.keysValuesDo{|key,item|
			elements.tbod[key].doAction;
		};
		elements.fbod.keysValuesDo{|key,item|
			elements.fbod[key].doAction;
		};
		elements.velocity.keysValuesDo{|key,item|
			elements.velocity[key].doAction;
		};
		elements.presetParams.keysValuesDo{|key,item|
			elements.presetParams[key].doAction;
		};
		elements.master.keysValuesDo{|key,item|
			elements.master[key].doAction;
		};
		elements.sound.keysValuesDo{|key,item|
			elements.sound[key].doAction;
		};
		elements.test.keysValuesDo{|key,item|
			elements.test[key].doAction;
		};
		elements[\toggles].keysValuesDo{|key,item|
			elements.toggles[key].doAction;
		};
		elements[\preset].doAction;
		elements[\participantID].doAction;
		elements[\toggleMaster].doAction;
		"Settings sent on request."; // return message
	};

	// return gui dictionary
	elements;

};


// START GUI
~gui = ~schroedingersGUI.(n, e);

~gui.resend.();

"Remote Patch READY".postln;

// if parameters are updated within the settings dictionary e, then call ~gui.upd.() to update the gui
// to resend the current gui state, call ~gui.resend.()


//=============================================================
//load big red button config
(Document.current.dir +/+ "/big-red-button.scd").asString.standardizePath.load;
//=============================================================

)