~sound37var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var01.wav", channels: 0);
~sound37var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var02.wav", channels: 0);
~sound37var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var03.wav", channels: 0);
~sound37var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var04.wav", channels: 0);
~sound37var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var05.wav", channels: 0);
~sound37var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var06.wav", channels: 0);
~sound37var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var07.wav", channels: 0);
~sound37var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var08.wav", channels: 0);
~sound37var9 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var09.wav", channels: 0);
~sound37var10 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var010.wav", channels: 0);
~sound37var11 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/drum_var011.wav", channels: 0);


~sound = [~sound37var1, ~sound37var2, ~sound37var3, ~sound37var4, ~sound37var5, ~sound37var6, ~sound37var7, ~sound37var8, ~sound37var9, ~sound37var10, ~sound37var11];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 1.5.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
