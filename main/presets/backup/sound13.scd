~sound13var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-glass_var01.wav", channels: 0);
~sound13var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-glass_var02.wav", channels: 0);
~sound13var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-glass_var03.wav", channels: 0);
~sound13var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-glass_var04.wav", channels: 0);
~sound13var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-glass_var05.wav", channels: 0);
~sound13var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-glass_var06.wav", channels: 0);


~sound = [~sound13var1, ~sound13var2, ~sound13var3, ~sound13var4, ~sound13var5, ~sound13var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 6;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
