~sound34var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash-light_var01.wav", channels:0);
~sound34var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash-light_var03.wav", channels:0);
~sound34var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash-light_var04.wav", channels:0);
~sound34var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash-light_var05.wav", channels:0);
~sound34var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash-light_var06.wav", channels:0);

~soundoutcomevar1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash_var01.wav", channels:0);
~soundoutcomevar2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash_var02.wav", channels:0);
~soundoutcomevar3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash_var03.wav", channels:0);
~soundoutcomevar4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash_var04.wav", channels:0);
~soundoutcomevar5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash_var05.wav", channels:0);
~soundoutcomevar6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/water-splash_var06.wav", channels:0);

~sound = [~sound34var1, ~sound34var2, ~sound34var3, ~sound34var4, ~sound34var5];

~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3, ~soundoutcomevar4, ~soundoutcomevar5, ~soundoutcomevar6];


~addsound = false;
~outcome = true;
~voices = 3;

//amplitude configuration
~ampfactor = 12;
~ampfactorcat = 10;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
~presetName = "water";