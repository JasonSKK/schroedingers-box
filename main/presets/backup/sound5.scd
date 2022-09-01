~sound5var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/35dogtoy_var1.wav", channels: 0);
~sound5var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/35dogtoy_var2.wav", channels: 0);

~sound = [~sound5var1, ~sound5var2];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 5.neg;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 1.0.neg;
~presetName = "squeeky toy";