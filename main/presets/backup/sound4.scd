
~sound = Array.newClear(6);

~sound[0] = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/timpani_bends1_var1.wav", channels: 0);
~sound[1] = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/timpani_bends1_var2.wav", channels: 0);
~sound[2] = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/timpani_bends1_var3.wav", channels: 0);
~sound[3] = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/timpani_bends1_var4.wav", channels: 0);
~sound[4] = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/timpani_bends1_var5.wav", channels: 0);
~sound[5] = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/timpani_bends1_var6.wav", channels: 0);


~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 2;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 0.0.neg;
