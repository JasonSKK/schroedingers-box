~sound41var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var01.wav", channels: 0);
~sound41var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var02.wav", channels: 0);
~sound41var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var03.wav", channels: 0);
~sound41var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var04.wav", channels: 0);
~sound41var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var05.wav", channels: 0);
~sound41var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var06.wav", channels: 0);
~sound41var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var07.wav", channels: 0);
~sound41var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sk8_var08.wav", channels: 0);

~sound = [~sound41var1, ~sound41var2, ~sound41var3, ~sound41var4, ~sound41var5, ~sound41var6,  ~sound41var7,  ~sound41var8];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 3.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
