~sound8var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/10meatknife_var1.wav", channels: 0);
~sound8var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/10meatknife_var2.wav", channels: 0);

~sound = [~sound8var1, ~sound8var2];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 5.neg;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 1.0;
