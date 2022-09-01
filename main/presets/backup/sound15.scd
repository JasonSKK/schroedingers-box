~sound15var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/artificial_var01.wav", channels: 0);
~sound15var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/artificial_var02.wav", channels: 0);
~sound15var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/artificial_var03.wav", channels: 0);
~sound15var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/artificial_var04.wav", channels: 0);
~sound15var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/artificial_var05.wav", channels: 0);
~sound15var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/artificial_var06.wav", channels: 0);


~sound = [~sound15var1, ~sound15var2, ~sound15var3, ~sound15var4, ~sound15var5, ~sound15var6];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 0.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
