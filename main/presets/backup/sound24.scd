~sound24var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-scissors_var01.wav", channels: 0);
~sound24var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-scissors_var02.wav", channels: 0);
~sound24var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-scissors_var03.wav", channels: 0);
~sound24var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-scissors_var04.wav", channels: 0);
~sound24var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-scissors_var05.wav", channels: 0);
~sound24var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-scissors_var06.wav", channels: 0);

~sound = [~sound24var1, ~sound24var2, ~sound24var3, ~sound24var4, ~sound24var5, ~sound24var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 3;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
