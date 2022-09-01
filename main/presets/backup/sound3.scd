~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metaliko_kouti_diafores _attakes_var1.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metaliko_kouti_diafores _attakes_var2.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metaliko_kouti_diafores _attakes_var3.wav", channels: 0);

~sound = [~sound1, ~sound2, ~sound3];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 1.5.neg;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 0.0;
