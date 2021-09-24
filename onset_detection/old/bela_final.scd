/*
Schroedinger's Box
SuperCollider Patch for Bela
2021 Jason Svoronos-Kanavas, Marian Weger 
*/

s = Server.default;

// Set up options for the Bela
s.options.numAnalogInChannels = 4;
s.options.numAnalogOutChannels = 4;
s.options.numDigitalChannels = 0;
s.options.maxLogins = 4;

s.options.blockSize = 64;
s.options.numInputBusChannels = 4;
s.options.numOutputBusChannels = 8;


s.waitForBoot{
	// Your code goes here.

	//buffer_read
	//sound1
	~sound1var1 = Buffer.read(s, "./sounds/atakes_vasi_ixeion_me_kleidi_var01.wav");
	~sound1var2 = Buffer.read(s, "./sounds/atakes_vasi_ixeion_me_kleidi_var02.wav");
	~sound1var3 = Buffer.read(s, "./sounds/atakes_vasi_ixeion_me_kleidi_var03.wav");
	~sound1var4 = Buffer.read(s, "./sounds/atakes_vasi_ixeion_me_kleidi_var04.wav");
	~sound1var5 = Buffer.read(s, "./sounds/atakes_vasi_ixeion_me_kleidi_var05.wav");
	
	//sound2
	~sound2var1 = Buffer.read(s, "./sounds/kagelo01.wav");
	~sound2var2 = Buffer.read(s, "./sounds/kagelo02.wav");

	//sound3
	~sound3var1 = Buffer.read(s, "./sounds/metaliko_kouti_diafores _attakes_var1.wav");
	~sound3var2 = Buffer.read(s, "./sounds/metaliko_kouti_diafores _attakes_var2.wav");
	~sound3var3 = Buffer.read(s, "./sounds/metaliko_kouti_diafores _attakes_var3.wav");
	//play{Out.ar(7, PlayBuf.ar(2, bufnum: ~sound1var1.bufnum))!2}
	"Server Booted".postln;
	// ===OSC_msg sender===
	~n = NetAddr("192.168.0.100", 57120);
	~n.sendMsg('/soundpick/2',  1, 2); //ARGS, 1: for next sound 2: for sound selection (2..5)

	//: Works but there are duplicates
	f = { arg b = 0, l = 0; b.scramble.keep(l); b.choose};

	// ===SAMPLE PLAYER===
	// sample player configured for sample picking
	SynthDef(\sample_player,{
		| gate = 1, amp = 0.9, bufnum = 0 |
		var sig, env, out;
		sig = PlayBuf.ar(numChannels:2, bufnum:bufnum, rate:Rand(0.95, 1.05), trigger: gate);
		sig = Mix(sig);
		sig = LPF.ar(sig, Rand(3333, 20000));
		sig = sig * EnvGen.ar(Env.adsr(0.0, 0.0, 0.666, 1.0), gate: gate);
		//no sound must exceed 9 sec
		sig = sig * amp * Env.perc(attackTime:0.0,releaseTime:9).kr(doneAction:2);
		Out.ar(7, Pan2.ar(sig))
	}).add;

	// ===NEXT SOUND OSC===
	//initialisation
	//button count
	~button = 0;
	m = OSCdef(\next_sound, { | msg, time, button = 0 |
		[time, msg].postln;
		msg[1].postln;
		//counter_via_button_hits
		if(msg[1] == 1.0){
			~button = ~button + 1;
		};
		if(~button == 0){"press the button to start".postln};
		if(~button == 1){"press the button to start".postln};
		//sound1
		if(~button == 2){~sound = [~sound1var1, ~sound1var2, ~sound1var3, ~sound1var4, ~sound1var5]};
		//sound2
		if(~button == 3){~sound = [~sound2var1, ~sound2var2]};
		//sound3
		if(~button == 4){~sound = [~sound3var1, ~sound3var2, ~sound3var3]};
		//finish
		if(~button == 5){s.freeAll; ~sound = nil};


		//for testing
		if(msg[2] == 2){~sound = [~sound1var1, ~sound1var2, ~sound1var3, ~sound1var4, ~sound1var5]};
		if(msg[2] == 3){~sound = [~sound2var1, ~sound2var2]};
		if(msg[2] == 4){~sound = [~sound3var1, ~sound3var2, ~sound3var3]};
		
	},'/soundpick/2');
	
	// ===onset detection===
	SynthDef(\tba_fba, {	
		var sig, sighpf, sigsquared, lpf1, lpf2, derivative, ttrig, tthres, tsub, tsend, vel, temp;
		var chain, onsets, pips, ftrig, fthres;
		sig = SoundIn.ar([0]);
		//===TBA===
		sighpf = HPF.ar(sig, 4000);
		sigsquared = sighpf.squared;
		lpf1 = LPF.ar(sigsquared, 25);
		derivative = Slope.ar(lpf1);
		lpf2 = LPF.ar(derivative, 100);
		tsub = 0.01 * lpf1 - lpf2;
		tsub = tsub.max(0);
		//2.04264e-06 a good value for low signal detection
		tthres = 1e-3;//MouseX.kr(0.0, 1e-3);
		//thres = 1000;
		ttrig = Schmidt.ar(tsub, tthres, tthres);
		tsend = SendTrig.kr(A2K.kr(ttrig),0);
		//===FBA===
		chain = FFT(LocalBuf(256), sig);
		fthres = 1; //MouseX.kr(0.05,1);
		onsets = Onsets.kr(chain, fthres, \rcomplex);
		//vel track test
		vel = RunningMax.ar(sig, [onsets, ttrig]);
		ftrig = SendTrig.kr(onsets, 1, value:vel);
	}).add;
	// ===onset detection combination===
	a = OSCFunc({ arg msg, time;
		var val, tb_trigval, fb_trigval, sp, vel;
		[time, msg].postln;
		tb_trigval = 0;
		fb_trigval = 0;
		vel = 0;
		vel = msg[3];
		fork{
			sp = Synth("sample_player", [\bufnum, f.value(~sound, ~sound.size), \amp, vel]);
			0.006.wait;
			msg[2].postln;
			fb_trigval = 0;
			if(msg[2] == 1){
				fb_trigval = 1;
				"FBA_agrees".postln;
			};
			if(fb_trigval == 0){sp.set(\gate,0); "FBA_disagrees".postln;}		
		};
	},'/tr', s.addr);
	1.wait;
	~n.sendMsg('/soundpick/2',  1, 2); //ARGS, 1: for next sound 2: for sound selection (2..5)
	Synth(\tba_fba);
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed