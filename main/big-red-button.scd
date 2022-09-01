/*
Big Red Button
Midi connection to button controller
and preset selection routine
*/


fork{

	// initialize the midi client
	MIDIClient.init;

	// connect all the possible inputs
	MIDIIn.connectAll;

	1.wait;

	"MIDI initialised".postln;


	// initialisation
	// has to be -1 => array (0..55)
	// first press is 0 - first sound
	~sample = -1;


	// presets selected for the presentation
	~experimentOrder =
	// -------- start -----------
	[
		[
			46, // aluminum can overtones
			// 2, //metallic
			10, // breaking glass
			6, // cat
			5, // squeaky toy
			33, // chaotic drop
			34, // water
			82, // ouch!
			83, // litter bin bouncing
		],
	];

	// post the order FYI
	("experimentOrder:"+~experimentOrder).postln;


	// NOTES:

	// metal: 1, 46
	// funny: 5, 82
	// outcome demonstration: 10, 83
	// secondary demonstration: 6
	// cool: 33, 34, 26

	// selection of simple metallic sounds:
	// 1, 2, 3, 26, 36, 42, 47, 61, 62, 63


	// MIDI RECEIVER
	MIDIdef.cc(\bigredbutton, {
		| ...args|
		var next, val; // 0-127
		val = args[0];

		//evaluate: when pressed
		if (val == 0){
			if (~sample > (~experimentOrder[e.participantID].size -1)){
				"all samples were completed -- invite next participant".postln;
			}{
				// participant_id at which sample
				next = ~experimentOrder[e.participantID].at(~sample.max(0)); // get current preset number (clip at 0)
				("preset number:"+next).postln; // post current preset number
				o.sendMsg('/preset', next); // send preset number to the synth (Bela) via OSC

				e[\preset] = next; // set local variable, too
				{~gui.upd;}.defer; // update GUI
				~sample = ~sample + 1; // increment to next preset (will be loaded next time)
				~sample = ~sample.wrap(0, 7); // wrap presets around
			};
		};

	}, 16);

	"Big red button initialised".postln;

};