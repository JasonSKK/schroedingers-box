~sound14var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/physical-plucked-string_var01.wav", channels: 0);
~sound14var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/physical-plucked-string_var02.wav", channels: 0);
~sound14var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/physical-plucked-string_var03.wav", channels: 0);
~sound14var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/physical-plucked-string_var04.wav", channels: 0);
~sound14var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/physical-plucked-string_var05.wav", channels: 0);
~sound14var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/physical-plucked-string_var06.wav", channels: 0);


~sound = [~sound14var1, ~sound14var2, ~sound14var3, ~sound14var4, ~sound14var5, ~sound14var6];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 5.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
