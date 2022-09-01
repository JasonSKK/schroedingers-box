~sound21var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/thermo-metallic_var01.wav", channels: 0);
~sound21var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/thermo-metallic_var02.wav", channels: 0);
~sound21var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/thermo-metallic_var03.wav", channels: 0);
~sound21var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/thermo-metallic_var04.wav", channels: 0);
~sound21var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/thermo-metallic_var05.wav", channels: 0);
~sound21var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/thermo-metallic_var06.wav", channels: 0);

~sound = [~sound21var1, ~sound21var2, ~sound21var3, ~sound21var4, ~sound21var5, ~sound21var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 3.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
