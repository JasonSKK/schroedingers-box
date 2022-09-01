
s = Server.local;

~path = PathName(thisProcess.nowExecutingPath).pathOnly; // current path

~voices = 3;

~preset = 80;
(~path+/+"presets/sound"++~preset.asInteger ++".scd").standardizePath.load; // load preset file


~soundSize = ~sound.size; // number of primary sounds in this preset
~soundIndArray = (0..(~soundSize-1)); // array of primary sound indices
~soundBufnums = ~sound.collect{|item| item.bufnum}; // array of bufnums for sound samples of this preset

~onsetBus = Bus.audio(s, numChannels: 3); // init audio busses for onset busses [gate, posx, posy]
~primaryBus = Bus.audio(s, numChannels: 4); // init audio busses for primary sound parameters [bufnum, rate, filt1, filt2]

~maxVoices = 3; // maximum number of allocated voices
~voiceGateBus = Bus.audio(s, numChannels: ~maxVoices); // init audio busses for voice gates


// TODO: localization


// Voice Allocation Synth. Needs to be re-defined on preset load.
SynthDef(\primaryVoiceAllocation, {
	arg
	onsetBus = ~onsetBus.busnum,
	primaryBus = ~primaryBus.busnum,
	gateBus = ~voiceGateBus.busnum,
	velocityFactor = 100.0,
	velMapOutMin = 0.0,
	velMapOutMax = 1.0,
	eqMinFreq = 1000.0,
	eqMaxFreq = 5000.0,
	slMaxPlaybackRate = 1.1;

	var
	bufnums = ~soundBufnums,
	voices = ~voices,
	slMaxPlaybackRateR = slMaxPlaybackRate.reciprocal,
	onset, gate, vel, pos, bufnum, nextVoice, eqFreqs, rate;

	onset = In.ar(onsetBus, numChannels: 3);

	// pos = onset[1..2]; // position [x,y] (between -1 and 1)
	pos = DC.ar(0.0)!2;

	// gate = onset[0]; // gate signal
	gate = LFPulse.ar(freq: 0.5, width: 0.5, mul: 0.01); // trigger simulator

	vel = Clip.ar(gate * velocityFactor, lo: velMapOutMin, hi: velMapOutMax); // map and clip velocity

	eqFreqs = Clip.ar(LinExp.ar(pos, srclo: -1.0, srchi: 1.0, dstlo: eqMinFreq, dsthi: eqMaxFreq), lo: eqMinFreq, hi: eqMaxFreq); // map position to filter frequency

	rate = Clip.ar(LinExp.ar(pos.sum, srclo: -2.0, srchi: 2.0, dstlo: slMaxPlaybackRateR, dsthi: slMaxPlaybackRate), lo: slMaxPlaybackRateR, hi: slMaxPlaybackRate); // map position to playback speed

	bufnum = Demand.ar(gate, 0, Dxrand(list: bufnums, repeats: inf)); // get random buffer number (no repetition)

	Out.ar(primaryBus, [bufnum, rate, eqFreqs[0], eqFreqs[1]]); // write parameters

	nextVoice = Stepper.ar(gate, 0, min: gateBus, max: gateBus+voices-1); // next voice index

	Out.ar(gateBus, Latch.ar(vel, gate)!voices); // set all gates to the velocity
	ReplaceOut.ar(nextVoice, DC.ar(0.0)); // set gate of next voice to 0 (trigger release)


}).add;


SynthDef(\primaryVoice,{

	arg
	voiceID = 0,
	primaryBus = ~primaryBus.busnum,
	gateBus = ~voiceGateBus.busnum,
	busnum = 0,
	level = inf.neg,
	eqGain = 4.0,
	velEnvDur = 0.005,
	velPeakLevel = 20.0,
	eqRQ = 0.1;

	var ctl, gate, amplitude, sig, velEnv, env, out;

	// inputs: voice parameters and voice gate
	ctl = In.ar(primaryBus, 4); // receive voice parameters [bufnum, rate, eqFreq1, eqFreq2]
	gate = In.ar(gateBus+voiceID, 1); // receive voice gate of this ID

	// sample the voice parameters
	amplitude = Latch.ar(gate, gate); // sample&hold for velocity amplitude
	bufnum = Latch.ar(ctl[0], gate); // sample&hold for bufnum
	rate = Latch.ar(ctl[1], gate); // sample&hold for rate

	// sample playback
	sig = PlayBuf.ar(numChannels: 1, bufnum: ctl[0], rate: ctl[1]*BufRateScale.kr(ctl[0]), trigger: gate, doneAction: 0); // play sample

	// position-dependent filtering
	sig = BPeakEQ.ar(sig, freq: ctl[2], rq: eqRQ, db: eqGain);
	sig = BPeakEQ.ar(sig, freq: ctl[3], rq: eqRQ, db: eqGain.neg);

	// velocity-dependent filtering
	velEnv = EnvGen.kr(Env.new(levels: [0.0, velPeakLevel, 0.0], times: [0.0, velEnvDur], curve: \lin), gate: gate, doneAction: 0);
	sig = BHiShelf.ar(sig, freq: 7500.0, rs: 10.0, db: velEnv);

	// release envelope, velocity, and level
	env = Amplitude.ar(gate, attackTime: 0.0, releaseTime: 0.010); // envelope with instant attack and smooth release
	out = sig * amplitude * env * level.dbamp; // apply velocity amplitude, envelope, and master level

	// output
	Out.ar(busnum, out); // play to bus

}).add;


(
y = Synth.new(\primaryVoiceAllocation, [\onsetBus, ~onsetBus, \primaryBus, ~primaryBus, \gateBus, ~voiceGateBus], addAction: \addToHead);
x = ~voices.collect{|i| Synth.new(\primaryVoice, [\voiceID, i, \primaryBus, ~primaryBus, \gateBus, ~voiceGateBus, \outBus, 0], addAction: \addToTail)};
)

//e