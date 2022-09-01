~sound31var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/micro-ding_var01.wav", channels: 0);
~sound31var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/micro-ding_var02.wav", channels: 0);
~sound31var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/micro-ding_var03.wav", channels: 0);
~sound31var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/micro-ding_var04.wav", channels: 0);
~sound31var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/micro-ding_var05.wav", channels: 0);
~sound31var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/micro-ding_var06.wav", channels: 0);

~sound = [~sound31var1, ~sound31var2, ~sound31var3, ~sound31var4, ~sound31var5, ~sound31var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 12;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
