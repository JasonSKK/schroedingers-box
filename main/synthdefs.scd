"Loading SynthDefs (sclang logic) ... ".post;

// PRIMARY SOUND
SynthDef(\primary,{

	arg
	busnum = 0,
	gate = 1.0,
	vel = 0.1,
	bufnum = 0,
	level = inf.neg,
	rate = 1.0,
	eqGain = 4.0,
	//combFiltFreq1 = 1000.0,
	//combFiltFreq2 = 4100.0,
	eqFreq1 = 1000.0,
	eqFreq2 = 4100.0,
	//velUpdateLag = 0.001,
	velEnvDur = 0.005,
	velPeakLevel = 20.0,
	eqRQ = 0.1;

	var sig, velEnv;

	sig = PlayBuf.ar(numChannels: 1, bufnum: bufnum, rate: rate*BufRateScale.kr(bufnum), trigger: gate, doneAction: 2); // play sample

	/*
	comb = sig - DelayN.ar(sig, maxdelaytime: 0.1, delaytime: combFiltFreq1.reciprocal, mul: combFiltDryWet); // comb filter
	comb2 = comb - DelayN.ar(comb, maxdelaytime: 0.1, delaytime: combFiltFreq2.reciprocal, mul: combFiltDryWet); // comb filter 2
	*/

	sig = BPeakEQ.ar(sig, freq: eqFreq1, rq: eqRQ, db: eqGain);
	sig = BPeakEQ.ar(sig, freq: eqFreq2, rq: eqRQ, db: eqGain.neg);

	velEnv = Line.kr(start: velPeakLevel, end: 0.0, dur: velEnvDur);
	// velEnv = EnvGen.kr(Env(levels: [velPeakLevel, 0.0], times: [velEnvDur], curve: 'lin'), gate: gate);
	// sig2 = BPeakEQ.ar(sig, freq: 10000.0, rq: 10.0, db: 10.0);
	sig = BHiShelf.ar(sig, freq: 7500.0, rs: 10.0, db: velEnv);

	sig = sig * EnvGen.kr(Env.cutoff(releaseTime: 0.005, level: 1.0, curve: -4.0), gate: gate, doneAction: 2); // apply release envelope
	// sig = sig * EnvGen.kr(Env.asr(0.0, 1.0, 0.005), gate: gate, doneAction: 2); // apply release envelope
	sig = vel * sig * level.dbamp; // apply velocity and master level
	Out.ar(busnum, sig); // play to bus

}).add;


// OUTCOME SOUND
SynthDef(\outcome,{

	arg
	busnum = 0,
	gate = 1.0,
	vel = 0.0,
	bufnum = 0,
	level = inf.neg,
	rate = 1.0;

	var sig, comb;

	sig = PlayBuf.ar(numChannels: 1, bufnum: bufnum, rate: 1, trigger: gate, doneAction: 2); // play sample
	sig = vel * sig * level.dbamp; // apply velocity and master level
	Out.ar(busnum, sig); // play to bus

}).add;


// SECONDARY SOUND
SynthDef(\secondary, {

	arg
	busnum = 0,
	bufnum = 0,
	level = inf.neg,
	rate = 1.0,
	upperCutoff = 500;

	var sig;

	sig = PlayBuf.ar(1, bufnum, rate: 1, trigger: 1.0, doneAction: 2); // play sample
	sig = LPF.ar(sig, upperCutoff); // low-pass filter to simulate damping through box
	sig = sig * level.dbamp; // apply amplitude
	Out.ar(busnum, sig);

}).add;


// MASTER BUS
SynthDef(\master, {

	arg
	primaryBus = 0,
	secondaryBus = 0,
	outcomeBus = 0,
	primaryLevel = 0.0,
	secondaryLevel = 0.0,
	outcomeLevel = 0.0,
	lpf = 20000.0,
	hpf = 80.0,
	irbufnum = 0,
	partConvFFTSize = 128,
	eq = 1,
	masterLevel = inf.neg,
	hpfPrimary = 20;

	var primary, secondary, outcome, master, out;

	primary = Hip.ar(In.ar(primaryBus, numChannels: 1), hpfPrimary) * primaryLevel.dbamp; // read primary bus and apply level
	secondary = In.ar(secondaryBus, numChannels: 1) * secondaryLevel.dbamp; // read secondary bus and apply level
	outcome = In.ar(outcomeBus, numChannels: 1) * outcomeLevel.dbamp; // read outcome bus and apply level

	master = primary + secondary + outcome; // just sum all sounds together

	// Equalization with inverse filter
	out = (eq * PartConv.ar(master, fftsize: partConvFFTSize, irbufnum: irbufnum)) + ((1.0-eq) * master); // Partitioned convolution with impulse response of equalization filter, with bypass switch

	out = LPF.ar(HPF.ar(out*masterLevel.dbamp, hpf), lpf).tanh; // output filtering and protection
	Out.ar(0, out!4); // write same signal to all output channels

}).add;


// ONSET DETECTION
SynthDef(\od, {
	arg
	tbThreshDB = 0.0,
	tbThreshLoDB = 0.0,
	fbThreshDB = 0.0,
	fbRelaxtime = 1.0,
	fbFloorDB = -20.0,
	fbMingap = 22,
	fbMedianspan = 22,
	velDelay = 0.006,
	tbRefPeriod = 0.03,
	tbLpf1Freq = 25.0,
	tbLpf2Freq = 25.0,
	tbHpfFreq = 4000.0,
	cancelDel = 1.0,
	inGain1 = 0.0,
	inGain2 = 0.0,
	inGain3 = 0.0,
	inGain4 = 0.0;

	var sigRaw, sig, sighpf, energies, lpf1, derivative, lpf2, tsub, tbTrig, chain, fbTrigKR, fbTrigAR, velTrig, energy, sigRawSum, tbVel, tbVels, sigRawAbss;
	var sampleDur = 1.1/SampleRate.ir; // duration of one audio sample, plus 10 percent safety
	var nfft = 256; // FFT size in samples
	var frameDur = (nfft/SampleRate.ir)*1.1; // duration of one fft frame in seconds, plus safety of 10 percent. 5.4ms at 48kHz and 256samp fft size.

	sigRaw = SoundIn.ar([0,1,2,3]) * [inGain1, inGain2, inGain3, inGain4].dbamp; // input channels, high-pass filtered
	sigRawSum = sigRaw.sum; // mono mix version

	sigRawAbss = HPF.ar(sigRaw, 1500.0).abs; // smoothed signal energy


	//=== TBOD ===
	sighpf = Hip.ar(sigRaw, tbHpfFreq); // Highpass Filter. Turchet2018: 4000 for conga, 7500 for bongo/djembe/cajon
	energies = sighpf.squared; // Squaring (get signal energy)
	energy = energies.sum; // add up all energies
	lpf1 = Lop.ar(energy, tbLpf1Freq); // Smoothing 1. Turchet2018: 25
	derivative = Slope.ar(lpf1); // 1st derivative = slope
	lpf2 = Lop.ar(energy, tbLpf2Freq); // Smoothing 2. Turchet2018: 25
	// tsub = (0.01 * lpf1 - lpf2).max(0); // trend subtraction (inspired from Coyote)
	tsub = lpf2 - Median.ar(64, lpf2); // trend subtraction (inspired from Turchet2018: length 65 samples)
	tbTrig = Trig.ar(Schmidt.ar(tsub, tbThreshDB.dbamp, tbThreshLoDB.dbamp), tbRefPeriod); // thresholding with high and low threshold
	//tbTrig = Trig.ar((tsub-tbThreshDB.dbamp).sign.max(0), tbRefPeriod); // simple thresholding, including a refractory period to prevent re-triggering within the given time
	//SendTrig.ar(tbTrig, id: 1, value: 0.0); // send TBOD trigger to language. ID 1 means TBOD. Value is first guess for velocity.

	//=== FAC: false alarm cancellation ===
	/*
	SendTrig.ar(DelayN.ar(tbTrig, 0.1, cancelDel*frameDur), id: 0, value: 0.0); // send FBOD cancel trigger to language. ID 0 means FBOD cancel (TBOD false alarm, FBOD correct rejection)
	*/

	//=== VD: velocity detection ===
	tbVels = RunningMax.ar(sigRawAbss, tbTrig); // running max of input. reset at TBOD trigger.
	tbVel = tbVels.mean; // average all channels
	velTrig = DelayN.ar(tbTrig, 0.05, velDelay); // after TBOD trigger, wait for specified delay time, then trigger velocity
	//SendTrig.ar(velTrig, id: 3, value: tbVel); // send velocity value to language
	SendTrig.ar(velTrig, id: 1, value: tbVel); // send velocity value to language.



	//=== SL: source localization ===
	// send the 4 individual velocity values to the language:
	SendTrig.ar(velTrig, 4, value: tbVels[0]); // velocity of channel 0
	SendTrig.ar(velTrig, 5, value: tbVels[1]); // velocity of channel 1
	SendTrig.ar(velTrig, 6, value: tbVels[2]); // velocity of channel 2
	SendTrig.ar(velTrig, 7, value: tbVels[3]); // velocity of channel 3


	//=== FBOD ===
	/*
	chain = FFT(LocalBuf(nfft), sigRawSum, hop: 0.25, wintype: 1); // Turchet2018: winsize 256, hopsize 64. Wintype 1 is Hann window.
	fbTrigKR = Onsets.kr(chain, threshold: fbThreshDB.dbamp, odftype: \rcomplex, relaxtime: fbRelaxtime, floor: fbFloorDB.dbamp, mingap: fbMingap, medianspan: fbMedianspan); // rcomplex is best. if it takes up too much cpu, then use power.
	fbTrigAR = T2A.ar(fbTrigKR, offset: 0);
	SendTrig.ar(fbTrigAR, id: 2, value: 0.0); // send FBOD trigger to language. ID 2 means FBOD.
	*/

}).add;


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

}).add;


// Recorder
SynthDef(\recorder, {|buf=0,primaryBus=0|
	DiskOut.ar(buf, SoundIn.ar([0,1,2,3])++In.ar(primaryBus));
}).add;


"done.".postln;