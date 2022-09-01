~sound44var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-rattle_var01.wav", channels:0);
~sound44var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-rattle_var02.wav", channels:0);
~sound44var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-rattle_var03.wav", channels:0);
~sound44var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-rattle_var04.wav", channels:0);
~sound44var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-rattle_var05.wav", channels:0);
~sound44var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-rattle_var06.wav", channels:0);

~sound = [~sound44var1, ~sound44var2, ~sound44var3, ~sound44var4, ~sound44var5, ~sound44var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 3;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
