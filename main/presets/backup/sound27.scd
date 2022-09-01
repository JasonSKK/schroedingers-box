~sound27var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/toasterx_var01.wav", channels: 0);
~sound27var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/toasterx_var02.wav", channels: 0);
~sound27var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/toasterx_var03.wav", channels: 0);
~sound27var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/toasterx_var04.wav", channels: 0);
~sound27var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/toasterx_var05.wav", channels: 0);
~sound27var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/toasterx_var06.wav", channels: 0);

~sound = [~sound27var1, ~sound27var2, ~sound27var3, ~sound27var4, ~sound27var5, ~sound27var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 2;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
