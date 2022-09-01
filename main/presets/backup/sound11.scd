~sound11var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/can_var01.wav", channels: 0);
~sound11var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/can_var02.wav", channels: 0);
~sound11var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/can_var03.wav", channels: 0);
~sound11var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/can_var04.wav", channels: 0);
~sound11var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/can_var05.wav", channels: 0);
~sound11var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/can_var06.wav", channels: 0);


~sound = [~sound11var1, ~sound11var2, ~sound11var3, ~sound11var4, ~sound11var5, ~sound11var6];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 1.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
