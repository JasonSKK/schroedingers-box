~sound50var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/coolness-imp_var01.wav", channels:0);
~sound50var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/coolness-imp_var02.wav", channels:0);
~sound50var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/coolness-imp_var03.wav", channels:0);
~sound50var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/coolness-imp_var04.wav", channels:0);
~sound50var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/coolness-imp_var05.wav", channels:0);
~sound50var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/coolness-imp_var06.wav", channels:0);

~sound = [~sound50var1, ~sound50var2, ~sound50var3, ~sound50var4, ~sound50var5, ~sound50var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 8;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
