~sound9var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var01.wav", channels:0);
~sound9var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var02.wav", channels:0);
~sound9var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var03.wav", channels:0);
~sound9var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var04.wav", channels:0);
~sound9var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var05.wav", channels:0);
~sound9var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var06.wav", channels:0);
~sound9var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/real-deal_var07.wav", channels:0);

~sound = [~sound9var1, ~sound9var2, ~sound9var3, ~sound9var4, ~sound9var5, ~sound9var6, ~sound9var7];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 3.5;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 1.0;
