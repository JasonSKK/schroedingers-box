/*
Big Red Button
connected to DigitalIn on Bela
for preset increment
*/



~participantID = 0;


// initialisation
// has to be -1 => array (0..55)
// first press is 0 - first sound
~presetNr = -1;


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

~bigRedButtonFunc = {
	~presetNr = ~presetNr + 1; // increment to next preset (will be loaded next time)
	~presetNr = ~presetNr.wrap(0, 7); // wrap presets around

	// participant_id at which sample
	~preset = ~experimentOrder[~participantID].at(~presetNr.max(0)); // get current preset number (clip at 0)
	("preset:"+~preset).postln; // post current preset
	// o.sendMsg('/preset', next); // send preset to the synth (Bela) via OSC

	// e[\preset] = next; // set local variable, too
	// {~gui.upd;}.defer; // update GUI


};