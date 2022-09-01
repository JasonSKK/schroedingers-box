"Loading SynthDefs (common) ... ".post;


// YIELD SOUND
SynthDef(\yield,{

	arg
	busnum = 0,
	gate = 1.0,
	vel = 0.0,
	bufnum = 0,
	rate = 1.0,
	level = 0.0;


	var sig;

	sig = PlayBuf.ar(numChannels: 1, bufnum: bufnum, rate: rate, trigger: gate, doneAction: 2); // play sample
	sig = vel * sig * level; // apply velocity and master level
	Out.ar(busnum, sig); // play to bus

}).send(s);


// SECONDARY SOUND
SynthDef(\secondary, {

	arg
	busnum = 0,
	bufnum = 0,
	rate = 1.0,
	// upperCutoff = 500,
	level = 0.0;


	var sig;

	sig = PlayBuf.ar(numChannels: 1, bufnum: bufnum, rate: rate, trigger: 1.0, doneAction: 2); // play sample
	// sig = LPF.ar(sig, upperCutoff); // low-pass filter to simulate damping through box
	sig = sig * level; // apply amplitude
	Out.ar(busnum, sig);

}).send(s);



// MASTER BUS
SynthDef(\master, {

	arg
	primaryBus = 0,
	secondaryBus = 0,
	yieldBus = 0,
	primaryLevel = 0.0,
	secondaryLevel = 0.0,
	yieldLevel = 0.0,
	lpf = 20000.0,
	hpf = 80.0,
	// irbufnum = 0,
	// partConvFFTSize = 128,
	// eq = 1,
	masterLevel = 0.0,
	hpfPrimary = 20;

	var primary, secondary, yield, out;
	// var master;

	primary = Hip48.ar(In.ar(primaryBus, numChannels: 1), hpfPrimary) * primaryLevel; // read primary bus and apply level
	secondary = In.ar(secondaryBus, numChannels: 1) * secondaryLevel; // read secondary bus and apply level
	yield = In.ar(yieldBus, numChannels: 1) * yieldLevel; // read yield bus and apply level

	// master = primary + secondary + yield; // just sum all sounds together

	// Equalization with inverse filter
	// out = (eq * PartConv.ar(master, fftsize: partConvFFTSize, irbufnum: irbufnum)) + ((1.0-eq) * master); // Partitioned convolution with impulse response of equalization filter, with bypass switch

	out = primary + secondary + yield; // just sum all sounds together

	// mute first few ms of creation
	//out = out * EnvGen.kr(Env([0,0,1], [0.2, 0.05]), doneAction: 0);

	out = Lop48.ar(HPF.ar(out*masterLevel, hpf), lpf).tanh; // output filtering and protection
	Out.ar(0, out!4); // write same signal to all output channels

}).send(s);




// TEST TONE GENERATOR
SynthDef(\tt, {

	arg
	noiseMasterDB = -80.0,
	sineMasterDB = -80.0,
	testFreq = 400.0,
	toggleSine = 0.0,
	toggleNoise = 0.0,
	toggleMaster = 1.0,
	toggle1 = 0.0,
	toggle2 = 0.0,
	toggle3 = 0.0,
	toggle4 = 0.0,
	flip1 = 0.0,
	flip2 = 0.0,
	flip3 = 0.0,
	flip4 = 0.0,
	bufnum = 0,
	playChirp = 0.0;

	var noise = WhiteNoise.ar(noiseMasterDB.dbamp*toggleNoise); // white noise generator
	var sine = SinOsc.ar(testFreq, mul: sineMasterDB.dbamp*toggleSine); // sine tone generator
	var chirp = PlayBuf.ar(1, bufnum: bufnum, trigger: playChirp, doneAction: 0) * sineMasterDB.dbamp;
	var sig = (sine + noise + chirp) * toggleMaster; // monophonic test signal
	var flipToggles = [flip1, flip2, flip3, flip4].madd(2.0.neg,1.0); // flip phase switches
	var toggles = [toggle1, toggle2, toggle3, toggle4]; // channel state switches
	var sigArray = toggles*flipToggles*sig; // 4ch test signal

	Out.ar(0, (sigArray!2).flat); // play same signal to 1-4 and 5-8

}).send(s);




// Recorder
SynthDef(\recorder, {|buf=0,primaryBus=0|
	DiskOut.ar(buf, SoundIn.ar([0,1,2,3])++In.ar(primaryBus));
}).send(s);


// Big red button control
SynthDef(\bigRedButton, {

	arg
	inPin = 0;

	var button;

	button = DigitalIn.kr(inPin);

	//button = LFPulse.kr(0.1); // for debug

	SendTrig.kr(button, id: 63); // send trigger with ID 63

}).send(s);


"done.".postln;