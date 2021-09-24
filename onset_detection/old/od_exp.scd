// =====================================================================
// SuperCollider Workspace
// =====================================================================



//:

//https://doc.sccode.org/Classes/Onsets.html
//: FFT detection
~odi = {
    var sig, chain, onsets, pips;
	
    // Input signal
    //sig = SoundIn.ar(0, 1.0)!2;
	//sig = PlayBuf.ar(2, ~sample, loop:1);
	sig = PlayBuf.ar(1, ~sample, BufRateScale.kr(~sample), loop: 0);
    chain = FFT(LocalBuf(512), sig);
	
	//MouseX is actually the threshold
    onsets = Onsets.kr(chain, MouseX.kr(0,1), \rcomplex);
	
    // output sound
    pips = SinOsc.ar(2222, mul:EnvGen.kr(Env.perc(0.001, 0.1, 0.2), onsets)) * 5;


	Out.ar(0, Pan2.ar(pips));
	//Out.ar(1, Pan2.ar(sig));
	
}.play;
//:
~odi.free; // Free the synth
//:

//: Detection via the Amplitude class,
// there has to be a threshold, where if the sig has reached smth is triggered
// it also has to .set the amplitude value during hiting (if goes higher it sets the amp value to the according level)


~sample = Buffer.readChannel(s,"/Users/jsk/Desktop/schroedingers_box/Mallet_impacts/hardest.wav", 40000, -1900, channels:[0]);


play{Out.ar(0, PlayBuf.ar(1, ~sample))}
s.record("~/Desktop/HWR2.wav")
//: =====================================================================

// Right speaker is the source and at left is a burst of noise when an onset is detected
(
SynthDef("coyote", {
	var sig = Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(2);
	var sigsquared = sig.squared;
	//var detect = Coyote.kr(Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(2), fastMul: 0.6, thresh: 0.001);
	var detect =  Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(Decay.kr(Coyote.kr(sig,
                                                                   fastMul: 0.6,
                                                                   thresh: 0.001), 0.2));

	Out.ar(0, [detect, sigsquared]); } ).send(s);
);
​
x = Synth.new("coyote");
x.free;


//:

play{
	| cutoff = 4000, rt = 0.1 |
	var out, thres, sigsquared, env;
	//var sig = SoundIn.ar();
	var sig = Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(2);
	sig = HPF.ar(sig, cutoff);
	sig = sig.squared;
	sigsquared = sig;
	sig = Amplitude.ar(sig, attackTime:0.0, releaseTime:rt);
	env = sig;
	//sig = DetectSilence.ar(sig, MouseX.kr(0.0, 1.0), 0.0);

	//sig = sig.isStrictlyPositive;
	//cannot be applied to a ugen
	//sig.scope;

	//thres = MouseX.kr(0.0);
	//sig = Schmidt.ar(sig, thres, thres);
	//thres.poll;
	//sig.poll;
	//postln{thres, "Schmidt_trig:" sig.poll};
	//out = EnvGen.kr(Env.perc(0.0, 0.001), sig, doneAction:0) * SinOsc.ar(2222);
	//out;

	[sigsquared, env]
}
//:
~g1 = Buffer.read(s, "/Users/jsk/Desktop/HWR2.wav");
~g1.plot;











//:
//Simplest onset detector
play{
	| cutoff = 4000, rt = 0.1 |
	var out, thres, env, initsig, squaredsig;
	//var sig = PlayBuf.ar(1, ~sample.bufnum, loop: 1);
	var sig = Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(2);
	initsig = sig;
	//sig = HPF.ar(sig, cutoff);
	sig = sig.squared;
	squaredsig = sig;
	//sig = Amplitude.ar(sig, attackTime:0.0001, releaseTime: 0.2);
	sig = Amplitude.ar(squaredsig, 0.001, 0.01);

	env = sig;
	//sig = DetectSilence.ar(sig, MouseX.kr(0.0, 1.0), 0.0);

	//sig = sig.isStrictlyPositive;
	//cannot be applied to a ugen
	//sig.scope;

	//thres = MouseX.kr(0.0, 1.0);
	//thres = 0.001;
	//sig = Schmidt.ar(sig, thres, thres);
	//thres.poll;
	//sig.poll;
	//postln{thres, "Schmidt_trig:" sig.poll};
	//out = EnvGen.kr(Env.perc(0.0, 0.1), gate:sig, doneAction:0) * SinOsc.ar(2222);
	//out;
	//Out.ar(0, Pan2.ar(~initsig));
	//Out.ar(1, Pan2.ar(out*2));
	//Out.ar(1, env);
	//Out.ar(0, [env, squaredsig]);
	[env, squaredsig]
	
}
//:

//Amplitude tracking onset detection
//:=======================================================================

//~g0 = Buffer.read(s, "/Users/jsk/Desktop/gammaton.wav");
//~g0.plot





~sample = Buffer.read(s,"/Users/jsk/Desktop/sample.wav", 40000, -1900);
~g1 = Buffer.read(s, "/Users/jsk/Desktop/HWR2.wav");
~g1.plot;

//:
fork{
| flagtime = 0.01, slagtime = 0.2, fastmul = 0.9 |
	var sig, flsig, slsig, out, envelope, sigsquared;
	s.record("~/Desktop/HWR2.wav");
	1.wait;
play{
	//====SOUNDIN====
	//sig = SoundIn.ar();

	//====BUFFER=====
	sig = PlayBuf.ar(1, ~sample, loop:1);
	
	//sig = Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(2);

	//~siginit = sig;


	///////////////////////////
	//CAREFULL HERE! SUPER - AMPLIFIED!!!
	sig = HPF.ar(sig, 4000, 1.0);
	//:=======================
	//////////////////////////

	

	
	sig = sig.squared;
	sigsquared = sig;
	//out = sig;
	//sig = sig.abs;

	//-60.dbamp = 0.001
	out = Amplitude.ar(sig, 0.0, 0.01);
	envelope = out;
	



	//for testing
	//flagtime = MouseX.kr(0.0, 0.1).poll;
	

	//convienient value
	flagtime = 0.0075;

	
	//SMOOTHING & TREND SUBTRACTION
	//flag-time ==>> 0.0076
	flsig = Lag.ar(out, flagtime);

	//This was followed by the calculation of the first derivative and again the application of a lowpass filter (Turchet2018), Slope.ar(out)
	slsig = Lag.ar(out, slagtime);
	out = fastmul * flsig - slsig;

	
	//half wave rectification
	out = out.max(0);
	out = (1 * out) - 0.05;
	//out = out.madd(0.0, -0.05);


	//threshold detection
	//out = InRange.ar(out, 0.0, 2.0);// -- alternative
	//threshold detection with hysterisis
	//around 0.34 works ok

	

	//For visible in s.scope do around ~0.035

	//was lo, 0.0, hi, 0.1
	out = Schmidt.ar(out, 0.1, 0.1);// MouseX.kr(0.0, 0.1), MouseX.kr(0.0, 1.0).poll);
	//out.poll;





	//latency is ok till here


	
	out = SinOsc.ar(2222, mul:EnvGen.kr(Env.perc(0.000, 0.2, 0.4), gate:out));
	
	//out;

	//Out.ar(0, Pan2.ar(~siginit, -0.99));
	//Out.ar(1, Pan2.ar(out * 1, 0.99));
	//Out.ar(1, envelope);
	[sigsquared, envelope];
	
};
};
//:
Server.default.options.inDevice_("MobilePre");




//:==============================================================================

//last example at the bugfile.scd
//then worked --->> these were written before the final example

/*
//: when plotted amplitude envelope has same amp as signal

plot{ | rt = 0.1 |
	var sig, sigsquared, env;
	sig = Env.perc(0.000, 0.03, curve:'sin').kr(doneAction:0) * PinkNoise.ar(2);
	sigsquared = sig.squared;
	env = Amplitude.ar(sigsquared, 0.000, rt);
	[sigsquared, env];
}

//: exactly the same code but instead of plot => play

s.record("~/Desktop/HWR2.wav");
//:
play{ | rt = 0.05 |
	var sig, sigsquared, env, envtrue;
	envtrue = Env.perc(0.000, 0.03, curve:'sin').ar(doneAction:0);
	sig = envtrue * PinkNoise.ar(1);
	sigsquared = sig.abs;
	//env = Lag.ar(sigsquared, 0.01).max(sigsquared).sqrt;//Amplitude.ar(sigsquared, 0.000, rt);
	//env = Integrator.ar(sig).sqrt;
	//env = EnvFollow.ar(sigsquared, 0.99);
	env = Amplitude.ar(sigsquared, 0.0, 0.05);
	[env, sigsquared];
	//[sigsquared, env];
}

//: then plot it => different amp values
s.record("~/Desktop/HWR2.wav");
g = Buffer.read(s, "/Users/jsk/Desktop/HWR2.wav");
g.plot(discrete:true);

*/









//:
s.scope;

~b6 = Buffer.read(s,"/Users/jsk/Desktop/HWR2.wav");
~b6.plot;

~sample = Buffer.read(s,"/Users/jsk/Desktop/sample.wav", 40000, -1900);

~sample.plot;

//:
//initial sig
76804, 
85603

//final 
77066,
78197
//:
play{EnvGen.kr(Env.perc(0.0, 0.01, curve: \sine), doneAction:0) * LPF.ar(PinkNoise.ar(), 7000);}
//:

{Env.perc(0.001, 0.02, curve:'sin').kr(doneAction:0)}.plot
//:

~b1 = Buffer.read(s, "/Users/jsk/Desktop/recs_sB/initial_sig.wav");
~b2 = Buffer.read(s, "/Users/jsk/Desktop/recs_sB/env_track.wav");
~b3 = Buffer.read(s, "/Users/jsk/Desktop/recs_sB/smoothing_subtraction.wav");
~b4 = Buffer.read(s, "/Users/jsk/Desktop/recs_sB/testersmooth.wav");
~b5 = Buffer.read(s, "/Users/jsk/Desktop/first.wav");
~b6 = Buffer.read(s,"/Users/jsk/Desktop/HWR2.wav");
~b7 = Buffer.read(s,"/Users/jsk/Desktop/HWR2.wav");
~b7.plot
//:
~b1.plot;
~b2.plot;
~b3.plot;
~b4.plot;
//:




// Gammatone
//: ======================================
// bandpass filterbank
// normalize to 70db level ==> filterbank (gammatone) ==> 4 each band ...
// ==> Amplitude envelope ==> Onset component detection ==> compute onset time and intensity
// after this procedure takes place on each band ==> combine results to yield onsets (+)
// then full wave rectification SC: ([1sig, 2sig].abs.sum / 2.sqrt).


~sample = Buffer.read(s,"/Users/jsk/Desktop/sample.wav", 40000, -1900);
//0.2.wait;
play{
	| flagtime = 0.00, slagtime = 0.2, fastmul = 0.9 |
var freqs, bandwidths, filterbank, sig, output, gate, flsig, slsig; 
	gate = 0;
	//artificial impact
	//sig = Env.perc(0.000, 0.05, curve:'sin').kr(doneAction:0) * PinkNoise.ar(1);

	//recorded
	sig = PlayBuf.ar(1, ~sample, loop:1);

	//sig = SoundIn.ar();

	//cuttoff freqs 
	freqs = Array.geom(9, 80, 2);

	//bandwidth
	bandwidths= 400;

	filterbank = Gammatone.ar(sig, freqs, bandwidths);

	//amp envelope
	/*
	~f0 = Amplitude.ar(filterbank[0]);
	~f1 = Amplitude.ar(filterbank[1]);
	~f2 = Amplitude.ar(filterbank[2]);
	~f3 = Amplitude.ar(filterbank[3]);
	~f4 = Amplitude.ar(filterbank[4]);
	~f5 = Amplitude.ar(filterbank[5]);
	~f6 = Amplitude.ar(filterbank[6]);
	~f7 = Amplitude.ar(filterbank[7]);
	~f8 = Amplitude.ar(filterbank[8]);

	//threshold detection
	~f0 = InRange.ar(~f0, MouseX.kr(0.0, 1.0), 1.0);
	~f1 = InRange.ar(~f1, MouseX.kr(0.0, 1.0), 1.0);
	~f2 = InRange.ar(~f2, MouseX.kr(0.0, 1.0), 1.0);
	~f3 = InRange.ar(~f3, MouseX.kr(0.0, 1.0), 1.0);
	~f4 = InRange.ar(~f4, MouseX.kr(0.0, 1.0), 1.0);
	~f5 = InRange.ar(~f5, MouseX.kr(0.0, 1.0), 1.0);
	~f6 = InRange.ar(~f6, MouseX.kr(0.0, 1.0), 1.0);
	~f7 = InRange.ar(~f7, MouseX.kr(0.0, 1.0), 1.0);
	~f8 = InRange.ar(~f8, MouseX.kr(0.0, 1.0), 1.0);
	
	//sum up the result
	~fsum = ~f0 + ~f1 + ~f2 + ~f3 + ~f4 + ~f5 +~f6 + ~f7 + ~f8;
	*/
	

	
	filterbank = filterbank.squared;
	
	filterbank = Amplitude.ar(filterbank, 0.000, 0.000);

	//for testing
	//flagtime = MouseX.kr(0.0, 0.1).poll;
	
	//convienient value
	flagtime = 0.00;
	slagtime = 0.20;

	
	//SMOOTHING & TREND SUBTRACTION
	//flag-time ==>> 0.0076
	flsig = Lag.ar(filterbank, flagtime);

	//This was followed by the calculation of the first derivative and again the application of a lowpass filter (Turchet2018)
	slsig = Lag.ar(Slope.ar(filterbank), slagtime);
	filterbank = fastmul * flsig - slsig;

	//half wave rectification
	filterbank = filterbank.max(0);
	filterbank = (1 * filterbank) - 0.05;

	//filterbank[0].poll;

	//~fsum = Select.ar(filterbank > 0.0, filterbank);
	
	~fsum = InRange.ar(filterbank, 0.0001, 1);
	//~fsum.poll;
	
	
	//if 5 BPF 
	//~fsum = InRange.ar(~fsum, 0.0, 4.0);
	//~fsum.poll;


	//~fsum = Schmidt.ar(filterbank, 0.0, 0.0);
	
	

	//Out.ar(0, Pan2.ar(sig * 0.2, -0.99));
	//Out.ar(0, Pan2.ar(output, 0.99));

	Out.ar(0, Pan2.ar(sig * 0.2, -0.99));
	//Out.ar(0, Pan2.ar(filterbank, 0.99));
	Out.ar(0, Pan2.ar(output * 10, 0.99));

}


//:
s.record("~/Desktop/gammaton.wav")
//:
~g0 = Buffer.read(s, "/Users/jsk/Desktop/gammaton.wav");
~g0.plot
//:
FreqScope.new
//:
~gate = 0
//:

82653-82326



//:

//tests
b = Buffer.read(s, "/Users/jsk/Desktop/schroedingers_box/onset_detection/impact.wav"); 
play{PlayBuf.ar(2,b)}
//:
plot{[Lag.ar(Pulse.ar, 0.001), Pulse.ar]};
//plot{Pulse.ar}
//:

plot{[Lag.ar(SinOsc.ar().squared, 0.01), Lag.ar(SinOsc.ar().squared, 0.2)]}

{[Impulse.ar(2).squared, Lag.ar(Impulse.ar(2).squared, 0.01)]}.plot(0.001)


plot{[ Lag.ar(SinOsc.ar().abs, 0.01) - Lag.ar(SinOsc.ar().abs, 0.2)]}
plot{[ Lag.ar(SinOsc.ar().squared, 0.01) - Lag.ar(SinOsc.ar().squared, 0.2)]}


//:

