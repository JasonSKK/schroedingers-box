/*
	Schroedinger's Box
	Install patch (run this first to install Quarks on Bela
	2022 Marian Weger
*/

// NOTE: THIS IS NOT NECESSARY ANYMORE!

"Starting install ... ".postln;

~quarkpath = PathName(thisProcess.nowExecutingPath).pathOnly +/+ "quarks"; // current path

// check if all required quarks are installed, if not install them
if(Quarks.isInstalled("ddwVoicer").not, {
	"Installing Quarks ... ".postln;
	// Quarks.addFolder(~path+/+"quarks");
	Quarks.install(~path+/+"quarks"); // list of quarks

	// quarks needed for Voicer
	Quarks.install(~path+/+"crucial-library"); // dependency of ddwCommon
	Quarks.install(~path+/+"ddwCommon"); // dependency of ddwVoicer
	Quarks.install(~path+/+"ddwGUIEnhancements"); // dependency of ddwVoicer
	Quarks.install(~path+/+"ddwVoicer"); // needed for sclang-logic
	"Installing Quarks ... done.".postln;
});

"DONE install.".postln;
