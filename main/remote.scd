/*
Schroedinger's Box
Remote Control
SuperCollider Patch
2022 Marian Weger, Jason Svoronos-Kanavas
*/


// Check which operating system we are, and then check if Bela is reachable.
// If Bela unreachable, set to local mode and use local SC server instead of Bela.
(
Platform.case(
    \osx, {
		"Running on OSX.".postln;
		~localMode = "ping -c 1 bela.local; echo $?".unixCmdGetStdOut.asInteger==68;
	},
    \linux, {
		"Running on Linux.".postln;
		~localMode = "ping -c 1 bela.local; echo $?".unixCmdGetStdOut.asInteger==2; // Check if Bela is reachable (false=Bela, true=local)
	};
);

if(~localMode, {
	"Oh no! Bela is unreachable. GUI starts in local mode.".postln;
	o = NetAddr("localhost", 57120); // set local address
}, {
	"Hooray! Bela responded. Connecting to Bela...".postln;
	o = NetAddr("bela.local", 57120); // set bela remote address
});


Window.closeAll; // close all open GUI windows


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


~remotePath = PathName(thisProcess.nowExecutingPath).pathOnly; // current path

(~remotePath+/+"settings.scd").standardizePath.load; // load parameter settings


// GUI function definition
~schroedingersGUI = {|n, e|

	// settings of all the sliders in the GUI
	// They will appear in this order in the GUI
	// min max warp step units label factor name
	// 0   1   2    3    4     5     6      7

	// TBOD
	var sliderListTBOD = [
		[-180, 0.0, \lin, 1.0, "dB", "TBOD threshold", 1.0, \tbThreshDB],
		[-180, 0.0, \lin, 1.0, "dB", "TBOD lower threshold", 1.0, \tbThreshLoDB],
		[80.0, 8000.0, \exp, 1.0, "Hz", "HPF Cutoff", 1.0, \tbHpfFreq],
		[1.0, 10000.0, \exp, 1.0, "Hz", "LPF 1 Cutoff", 1.0, \tbLpf1Freq],
		[1.0, 10000.0, \exp, 1.0, "Hz", "LPF 2 Cutoff", 1.0, \tbLpf2Freq],
		[0.1, 500.0, \exp, 1.0, "ms", "TBOD Refractory Period", 1.0e-3, \tbRefPeriod],
		// [0.0, 32.0, \lin, 1.0, "FFT frames", "False Alarm Cancellation delay", 1.0, \cancelDel],
	];

	// FBOD
	/*
	var sliderListFBOD = [
		[-40, 40.0, \lin, 1.0, "dB", "FBOD threshold", 1.0, \fbThreshDB],
		[0.1, 10.0, \exp, 0.1, "s", "Relax Time", 1.0, \fbRelaxtime],
		[140.0.neg, 0.0, \lin, 1.0, "dB", "Floor", 1.0, \fbFloorDB],
		[0.0, 100.0, \lin, 1.0, "FFT frames", "MinGap", 1.0, \fbMingap],
		[0.0, 30.0, \lin, 1.0, "FFT frames", "MedianSpan", 1.0, \fbMedianspan],
	];
	*/

	// Velocity Detection and Sound Localization
	var sliderListVelocity = [
		[-20, 20.0, \lin, 0.1, "dB", "Input Gain Ch. 1", 1.0, \inGain1],
		[-20, 20.0, \lin, 0.1, "dB", "Input Gain Ch. 2", 1.0, \inGain2],
		[-20, 20.0, \lin, 0.1, "dB", "Input Gain Ch. 3", 1.0, \inGain3],
		[-20, 20.0, \lin, 0.1, "dB", "Input Gain Ch. 4", 1.0, \inGain4],
		[0.1, 50.0, \exp, 0.1, "ms", "Velocity Waiting Time", 1.0e-3, \velDelay],
		// [0.1, 50.0, \exp, 0.1, "ms", "Velocity Update Lag", 1.0e-3, \velUpdateLag],
		// [0.0001, 1.0, \exp, 0.0, "", "Default Velocity", 1.0, \defaultVel],
		[0.001, 1000.0, \exp, 0.001, "1e-3", "Velocity Map: inMin", 1.0e-3, \velMapInMin],
		[0.001, 1000.0, \exp, 0.001, "1e-3", "Velocity Map: inMax", 1.0e-3, \velMapInMax],
		[0.0001, 1.0, \exp, 0.0001, "", "Velocity Map: outMin", 1.0, \velMapOutMin],
		[0.0001, 1.0, \exp, 0.0001, "", "Velocity Map: outMax", 1.0, \velMapOutMax],
		//[-10, 10, \lin, 0.1, "", "Velocity Map: curve", 1.0, \velMapCurve],
	];

	// Preset
	var sliderListPresetParams = [
		[-60.0, 30.0, \lin, 0.1, "dB", "Primary sound level", 1.0, \primaryDB],
		[-60.0, 30.0, \lin, 0.1, "dB", "Secondary sound level", 1.0, \secondaryDB],
		[-60.0, 30.0, \lin, 0.1, "dB", "Yield sound level", 1.0, \yieldDB],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Secondary Sound Upper Cutoff", 1.0, \secondaryCutoff],
		[1e-3, 300.0, \lin, 1.0, "Hz", "HPF cutoff primary", 1.0, \hpfPrimary],
		[1, 50, \lin, 1, "", "Secondary Max Count", 1.0, \secondaryMaxCount],
	];

	// Master
	var sliderListMaster = [
		[-60.0, 30.0, \lin, 1.0, "dB", "Global primary sound level", 1.0, \primaryMasterDB],
		[-60.0, 30.0, \lin, 1.0, "dB", "Global secondary sound level", 1.0, \secondaryMasterDB],
		[-60.0, 30.0, \lin, 1.0, "dB", "Global yield sound level", 1.0, \yieldMasterDB],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Master HPF Cutoff", 1.0, \masterHPF],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Master LPF Cutoff", 1.0, \masterLPF],
		[-60.0, 30.0, \lin, 1.0, "dB", "GLOBAL MASTER LEVEL", 1.0, \masterLevel],
	];

	// Test Tone Generator
	var sliderListTest = [
		[-80.0, 0.0, \lin, 1.0, "dB", "Noise Volume", 1.0, \noiseMasterDB],
		[-80.0, 0.0, \lin, 1.0, "dB", "Sine Volume", 1.0, \sineMasterDB],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Sine Frequency", 1.0, \testFreq],
		[0.001, 1.0, \exp, 0.0, "", "Test Onset Velocity", 1.0, \testOnsetVel],
		[1.0, 10.0, \lin, 0.1, "", "Test Onset Hit Freq", 1.0, \testOnsetFreq],
		[-1.0, 1.0, \lin, 0.01, "", "Test Onset Pos X", 1.0, \testOnsetPosX],
		[-1.0, 1.0, \lin, 0.01, "", "Test Onset Pos Y", 1.0, \testOnsetPosY],
	];

	// Sound
	var sliderListSound = [
		[0.0, 1000, \lin, 0.1, "ms", "HF Boost Envelope Duration", 1.0e-3, \velEnvDur],
		[0.0, 60, \lin, 0.1, "dB", "HF Boost Peak Level", 1.0, \velPeakLevel],
		// [-10, 10, \lin, 0.1, "", "HF Boost Mapping Curve", 1.0, \velPeakMapCurve],
		[-20.0, 0.0, \lin, 0.1, "dB", "HF Boost Neutral Velocity", 1.0, \velPeakMapZeroDB],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Source Pos: Peaking EQ Min Freq", 1.0, \eqMinFreq],
		[20.0, 20000.0, \exp, 1.0, "Hz", "Source Pos: Peaking EQ Max Freq", 1.0, \eqMaxFreq],
		[0.0, 10.0, \lin, 0.1, "%", "Secondary/Yield rate randomization", 1.0e-2, \rateRand],
		[0.001, 1.0, \exp, 0.001, "", "Yield Threshold", 1.0, \yieldThreshold],
		[0.0, 5.0, \lin, 0.1, "s", "Secondary: Min Delay", 1.0, \secondaryMinDel],
		[0.0, 5.0, \lin, 0.1, "s", "Secondary: Max Delay", 1.0, \secondaryMaxDel],
		[0, 10, \lin, 1, "", "Secondary: Min Count", 1.0, \secondaryMinCount],
		[-10, 10, \lin, 0.1, "", "Secondary: Probability Curve", 1.0, \secondaryCountCurve],
		[1.0, 2.0, \exp, 0.001, "", "Source Pos: Max Playback Rate", 1.0, \slMaxPlaybackRate],
		[1.0, 10.0, \exp, 0.001, "", "Source Pos: Max Amplitude Ratio", 1.0, \slMaxRatio],
		[0.0, 20.0, \lin, 1.0, "dB", "Peaking EQ Level", 1.0, \eqGain],
		[0.001, 1.0, \exp, 0.001, "", "1/Q for Peaking EQ level", 1.0, \eqRQ],
	];

	// convert to dictionary, to address them by name
	var sliderDictTBOD = ().putPairs([sliderListTBOD.flop.last,sliderListTBOD].flop.flatten);
	//var sliderDictFBOD = ().putPairs([sliderListFBOD.flop.last,sliderListFBOD].flop.flatten); // FBOD currently deactivated
	var sliderDictVelocity = ().putPairs([sliderListVelocity.flop.last,sliderListVelocity].flop.flatten);
	var sliderDictPresetParams = ().putPairs([sliderListPresetParams.flop.last,sliderListPresetParams].flop.flatten);
	var sliderDictMaster = ().putPairs([sliderListMaster.flop.last,sliderListMaster].flop.flatten);
	var sliderDictTest = ().putPairs([sliderListTest.flop.last,sliderListTest].flop.flatten);
	var sliderDictSound = ().putPairs([sliderListSound.flop.last,sliderListSound].flop.flatten);


	// slider creation function
	var makeSlider = { |item, sliderBackground=0|
		EZSlider(elements[\w].view, 878@22, "  "++item[5]++"  ",
			ControlSpec(minval: item[0], maxval: item[1], warp: item[2], step: item[3], default: e[item[7]]/item[6], units: item[4]),
			labelWidth: 250, unitWidth: 50, initVal: e[item[7]]/item[6], numberWidth: 70, layout: \horz, initAction: true)
		.setColors(Color.grey, Color.white, sliderBackground)
		.font_(Font("Helvetica", 14))
		.round_(0.001)
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
	var makeSliders = {|target, dict, keys, sliderBackground=0|
		keys.asArray.do{|key|
			target[key] = makeSlider.(dict[key], sliderBackground);
		};
	};

	// function to create a heading
	var heading = { |text|
		StaticText(elements[\w].view, 878@24)
		.string_(text++":")
		.font_(Font("Helvetica", 18))
		.stringColor_(Color.white)
		;
	};

	var presetSpace = " Preset name:  ";

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
	elements[\toggles] = ();

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
	.font_(Font("Helvetica", 18, bold: true))
	.stringColor_(Color.white);


	heading.("Participant and Sound Selection");
	newline.();

	elements[\preset] = EZNumber(elements[\w].view, 180@22, "  Preset  ",
		ControlSpec(minval: -1, maxval: 666, step: 1, default: e[\preset]),
		labelWidth: 60, unitWidth: 0, initVal: e[\preset], numberWidth: 70, layout: \horz, initAction: true)
	.setColors(Color.grey, Color.white)
	.font_(Font("Helvetica", 14))
	.action_({ |ez|
		e[\preset] = ez.value.asInteger; // update value in settings dictionary
		o.sendMsg('/preset', e[\preset]); // send updated value via OSC
		("Preset:"+e[\preset]).postln; // print message
	});

	elements[\prevPreset] = Button(elements[\w], Rect(0,0,22,22))
	.states_([["⇦", Color.white, Color.gray]])
	.font_(Font("Helvetica", 16))
	.action_({|obj|
		elements[\preset].valueAction = (e[\preset] - 1).max(-1).min(666);
	});

	elements[\nextPreset] = Button(elements[\w], Rect(0,0,22,22))
	.states_([["⇨", Color.white, Color.gray]])
	.font_(Font("Helvetica", 16))
	.action_({|obj|
		elements[\preset].valueAction = (e[\preset] + 1).max(-1).min(666);
	});

	elements[\participantID] = EZNumber(elements[\w].view, 180@22, "  Participant ID  ",
		ControlSpec(minval: 0, maxval: 666, step: 1, default: e[\participantID]),
		labelWidth: 120, unitWidth: 0, initVal: e[\preset], numberWidth: 70, layout: \horz, initAction: true)
	.setColors(Color.grey, Color.white)
	.font_(Font("Helvetica", 14))
	.action_({ |ez|
		e[\participantID] = ez.value.asInteger; // update value in settings dictionary
		o.sendMsg('/participantID', e[\participantID]); // send updated value via OSC
		// elements[\preset].valueAction_(1.neg); // init sample number
		("Participant ID:"+e[\participantID]).postln; // print message
	});

	elements[\prevParticipantID] = Button(elements[\w], Rect(0,0,22,22))
	.states_([["⇦", Color.white, Color.gray]])
	.font_(Font("Helvetica", 16))
	.action_({|obj|
		elements[\participantID].valueAction = (e[\participantID] - 1).max(0).min(666);
	});

	elements[\nextParticipantID] = Button(elements[\w], Rect(0,0,22,22))
	.states_([["⇨", Color.white, Color.gray]])
	.font_(Font("Helvetica", 16))
	.action_({|obj|
		elements[\participantID].valueAction = (e[\participantID] + 1).max(0).min(666);
	});

	elements[\toggles][\secondary] = makeToggle.(\secondary, "secondary");
	elements[\toggles][\yield] = makeToggle.(\yield, "yield");

	newline.();

	elements[\presetName] = StaticText(elements[\w].view, 800@24)
	.string_(presetSpace++e[\presetName])
	.font_(Font("Helvetica", 16))
	.stringColor_(Color.white)
	;

	newline.();
	heading.("Tools");
	newline.();

	elements[\toggles][\toggleOnsets] = makeToggle.(\toggleOnsets, "Onsets");

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

	// elements[\toggles][\eq] = makeToggle.(\eq, "EQ");
	//elements[\toggles][\od] = makeToggle.(\od, "OD");
	//elements[\toggles][\output] = makeToggle.(\output, "Output");

	newline.();

	heading.("Master");
	newline.();
	makeSliders.(elements[\master], sliderDictMaster, sliderListMaster.flop.last, Color.red);
	elements.master.masterLevel.setColors(knobColor: Color.red);
	newline.();


	heading.("TBOD");
	newline.();
	makeSliders.(elements[\tbod], sliderDictTBOD, sliderListTBOD.flop.last, Color.yellow);
	newline.();

	heading.("Sound");
	newline.();
	makeSliders.(elements[\sound], sliderDictSound, sliderListSound.flop.last, Color.blue);
	newline.();

	/*
	heading.("FBOD");
	newline.();
	makeSliders.(elements[\fbod], sliderDictFBOD, sliderListFBOD.flop.last);
	newline.();
	*/

	heading.("Velocity detection");
	newline.();
	makeSliders.(elements[\velocity], sliderDictVelocity, sliderListVelocity.flop.last, Color.green);
	newline.();

	heading.("Preset Settings");
	newline.();
	makeSliders.(elements[\presetParams], sliderDictPresetParams, sliderListPresetParams.flop.last, Color.magenta);
	newline.();


	heading.("Test Signal Generator");
	newline.();
	makeSliders.(elements[\test], sliderDictTest, sliderListTest.flop.last, Color.cyan);
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


	[[\toggleSine, "Sine"], [\toggleNoise, "Noise"], [\record, "Record"]].do{ |item|
		elements[\toggles][item[0].asSymbol] = makeToggle.(item[0].asSymbol, item[1]);
	};

	newline.();

	( 4.collect{|i| i=i+1; [\toggle++i, "Ch."+i]} ++ 4.collect{|i| i=i+1; [\flip++i, "Flip Ch."+i]} ).do{ |item|
		elements[\toggles][item[0].asSymbol] = makeToggle.(item[0].asSymbol, item[1]);
	};

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
		/*
		elements.fbod.keysValuesDo{|key,item|
			elements.fbod[key].value = e[key]/sliderDictFBOD[key][6];
		};
		*/
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

		elements[\presetName].string = presetSpace++e[\presetName];

		"GUI updated"; // return message
	};

	// resend function (call from outside to resend all values)
	elements[\resend] = {
		elements.tbod.keysValuesDo{|key,item|
			elements.tbod[key].doAction;
		};
		/*
		elements.fbod.keysValuesDo{|key,item|
			elements.fbod[key].doAction;
		};
		*/
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