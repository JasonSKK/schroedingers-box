~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/exp2__variant_1__metallicity_1__rigidity_2__tenuity_3__decay_2.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/exp2__variant_2__metallicity_1__rigidity_2__tenuity_3__decay_2.wav", channels: 0);

~sound = [~sound1, ~sound2];

~addsound = false;
~outcome = false;
~voices = 5;

//amplitude configuration
~ampfactor = 8.0;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 1.0;

~presetName = "synthetic wood bar";
