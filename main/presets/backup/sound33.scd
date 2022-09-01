~sound33var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/chaotic-drop_var01.wav", channels: 0);
~sound33var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/chaotic-drop_var02.wav", channels: 0);
~sound33var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/chaotic-drop_var03.wav", channels: 0);
~sound33var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/chaotic-drop_var04.wav", channels: 0);
~sound33var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/chaotic-drop_var05.wav", channels: 0);
~sound33var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/chaotic-drop_var06.wav", channels: 0);

~sound = [~sound33var1, ~sound33var2, ~sound33var3, ~sound33var4, ~sound33var5, ~sound33var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 7;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
~presetName = "chaotic drop";