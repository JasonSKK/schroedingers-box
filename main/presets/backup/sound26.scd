~sound26var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spring-wire_var01.wav", channels: 0);
~sound26var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spring-wire_var02.wav", channels: 0);
~sound26var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spring-wire_var03.wav", channels: 0);
~sound26var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spring-wire_var04.wav", channels: 0);
~sound26var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spring-wire_var05.wav", channels: 0);
~sound26var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spring-wire_var06.wav", channels: 0);

~sound = [~sound26var1, ~sound26var2, ~sound26var3, ~sound26var4, ~sound26var5, ~sound26var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 3;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
~presetName = "resonating spring wire";