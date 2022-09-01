"Loading SynthDefs (sclang-logic) ... ".post;

// PRIMARY SOUND
SynthDef(\primary,{

	arg
	busnum = 0,
	gate = 1.0,
	vel = 0.1,
	bufnum = 0,
	level = 0.0,
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
	sig = vel * sig * level; // apply velocity and master level
	Out.ar(busnum, sig); // play to bus

}).send(s);




// ONSET DETECTION
SynthDef(\od, {
	arg
	tbThresh = 1.0,
	tbThreshLo = 0.0,
	fbThresh = 1.0,
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

	var sigRaw, sig, sighpf, energies, lpf1, derivative, lpf2, tsub, tbTrig, chain, fbTrigKR, fbTrigAR, velTrig, energy, sigRawSum, tbVel, tbVels, sigRawAbs;
	var sampleDur = 1.1/SampleRate.ir; // duration of one audio sample, plus 10 percent safety
	var nfft = 256; // FFT size in samples
	var frameDur = (nfft/SampleRate.ir)*1.1; // duration of one fft frame in seconds, plus safety of 10 percent. 5.4ms at 48kHz and 256samp fft size.

	sigRaw = SoundIn.ar([0,1,2,3]) * [inGain1, inGain2, inGain3, inGain4]; // input channels, high-pass filtered
	sigRawSum = sigRaw.sum; // mono mix version

	sigRawAbs = HPF.ar(sigRaw, 1500.0).abs; // smoothed signal energy


	//=== TBOD ===
	sighpf = Hip.ar(sigRaw, tbHpfFreq); // Highpass Filter. Turchet2018: 4000 for conga, 7500 for bongo/djembe/cajon
	energies = sighpf.squared; // Squaring (get signal energy)
	energy = energies.sum; // add up all energies
	lpf1 = Lop.ar(energy, tbLpf1Freq); // Smoothing 1. Turchet2018: 25
	derivative = Slope.ar(lpf1); // 1st derivative = slope
	lpf2 = Lop.ar(energy, tbLpf2Freq); // Smoothing 2. Turchet2018: 25
	// tsub = (0.01 * lpf1 - lpf2).max(0); // trend subtraction (inspired from Coyote)
	tsub = lpf2 - Median.ar(64, lpf2); // trend subtraction (inspired from Turchet2018: length 65 samples)
	tbTrig = Trig.ar(Schmidt.ar(tsub, tbThreshLo, tbThresh), tbRefPeriod); // thresholding with high and low threshold
	//tbTrig = Trig.ar((tsub-tbThresh).sign.max(0), tbRefPeriod); // simple thresholding, including a refractory period to prevent re-triggering within the given time
	//SendTrig.ar(tbTrig, id: 1, value: 0.0); // send TBOD trigger to language. ID 1 means TBOD. Value is first guess for velocity.

	//=== FAC: false alarm cancellation ===
	/*
	SendTrig.ar(DelayN.ar(tbTrig, 0.1, cancelDel*frameDur), id: 0, value: 0.0); // send FBOD cancel trigger to language. ID 0 means FBOD cancel (TBOD false alarm, FBOD correct rejection)
	*/

	//=== VD: velocity detection ===
	tbVels = RunningMax.ar(sigRawAbs, tbTrig); // running max of input. reset at TBOD trigger.
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
	fbTrigKR = Onsets.kr(chain, threshold: fbThresh, odftype: \rcomplex, relaxtime: fbRelaxtime, floor: fbFloorDB.dbamp, mingap: fbMingap, medianspan: fbMedianspan); // rcomplex is best. if it takes up too much cpu, then use power.
	fbTrigAR = T2A.ar(fbTrigKR, offset: 0);
	SendTrig.ar(fbTrigAR, id: 2, value: 0.0); // send FBOD trigger to language. ID 2 means FBOD.
	*/

}).send(s);



"done.".postln;