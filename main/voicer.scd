"Loading Voicer (server-logic) ... ".post;


// Voice Allocation Synth. Needs to be re-defined on preset load.
SynthDef(\voicer, {
	arg
	onsetBus = 0,
	updateBus = 0,
	primaryCtlBus = 0,
	gateBus = 0,
	//eqMinFreq = 1000.0,
	//eqMaxFreq = 5000.0,
	slMaxPlaybackRate = 1.1;

	var
	bufnums = ~soundBufnums,
	//maxVoice = ~voices-1.0,
	//slMaxPlaybackRateR = slMaxPlaybackRate.reciprocal,
	onset, gate, pos, bufnum, nextVoice, rate, currentVoice, vel;
	//var eqFreqs;

	// get onset trigger and position [gate, vel, posx, posy]
	onset = In.ar(onsetBus, numChannels: 4);

	// shortcuts for gate and pos
	pos = onset[2..3]; // position [x,y] (between -1 and 1)
	gate = onset[0]; // gate and velocity signal
	vel = onset[1];
	// pos = DC.ar(0.0)!2; // pos simulator
	// gate = LFPulse.ar(freq: 0.5, width: 0.5, mul: 0.01); // trigger simulator

	// Parameter mapping: eqFreqs, rate
	//eqFreqs = pow(eqMaxFreq/eqMinFreq, (pos+1.0)/2.0) * eqMinFreq; // linexp mapping
	// eqFreqs = LinExp.ar(pos, srclo: -1.0, srchi: 1.0, dstlo: eqMinFreq, dsthi: eqMaxFreq); // map position to filter frequency
	rate = pow(slMaxPlaybackRate, ((pos.sum-2.0)/2.0) + 1.0); // linexp mapping
	// rate = Clip.ar(LinExp.ar(pos.sum, srclo: -2.0, srchi: 2.0, dstlo: slMaxPlaybackRateR, dsthi: slMaxPlaybackRate), lo: slMaxPlaybackRateR, hi: slMaxPlaybackRate); // map position to playback speed

	// Random sample selection
	bufnum = Demand.ar(gate, 0, Dxrand(list: bufnums, repeats: inf)); // get random buffer number (no repetition)

	// Write voice parameters: [bufnum, rate, eqFreq1, eqFreq2]
	//Out.ar(primaryCtlBus, [bufnum, rate, eqFreqs[0], eqFreqs[1]]); // write parameters
	Out.ar(primaryCtlBus, [bufnum, rate, vel]); // write parameters

	// Voice-allocation Logic / Gate logic
	currentVoice = Stepper.ar(gate, 0, min: 0, max: ~voices-1); // current voice index
	nextVoice = (currentVoice+1).mod(~voices); // next voice index (to be released)
	// nextVoice = Wrap.ar(currentVoice, min: 0.0, max: maxVoice);//Wrap.ar((currentVoice), lo: 0, hi: maxVoice);

	Out.ar(gateBus, DC.ar(1.0)!~voices); // All gates are 1 by default
	ReplaceOut.ar(gateBus+nextVoice, DC.ar(0.0)); // set gate of next voice to 0 (trigger release)

	// Out.ar(updateBus, DC.ar(0.0)!~voices); // set all update busses to zero
	// ReplaceOut.ar(updateBus+currentVoice, DC.ar(1.0)); // set current update bus
	Out.ar(updateBus, DC.ar(0.0)!~voices); // All gates are 1 by default
	ReplaceOut.ar(updateBus+currentVoice, DC.ar(1.0)); // update bus: only current voice is set to 1

}).send(s);

"done.".postln;


