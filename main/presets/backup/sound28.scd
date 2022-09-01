~sound28var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var01.wav", channels: 0);
~sound28var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var02.wav", channels: 0);
~sound28var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var03.wav", channels: 0);
~sound28var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var04.wav", channels: 0);
~sound28var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var05.wav", channels: 0);
~sound28var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var06.wav", channels: 0);
~sound28var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var07.wav", channels: 0);
~sound28var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cough_var08.wav", channels: 0);

~sound = [~sound28var1, ~sound28var2, ~sound28var3, ~sound28var4, ~sound28var5, ~sound28var6, ~sound28var7,  ~sound28var8];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 1;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
