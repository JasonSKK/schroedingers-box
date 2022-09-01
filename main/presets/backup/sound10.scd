~sound10var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-hit_var01.wav", channels: 0);
~sound10var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-hit_var02.wav", channels: 0);
~sound10var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-hit_var03.wav", channels: 0);
~sound10var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-hit_var04.wav", channels: 0);
~sound10var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-hit_var05.wav", channels: 0);

~soundoutcomevar1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-break_var01.wav", channels: 0);
~soundoutcomevar2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-break_var02.wav", channels: 0);
~soundoutcomevar3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bottle-break_var03.wav", channels: 0);

~sound = [~sound10var1, ~sound10var2, ~sound10var3, ~sound10var4, ~sound10var5];

~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3];

~addsound = false;
~outcome = true;
~voices = 3;

//amplitude configuration
~ampfactor = 3.5;
~ampfactorcat = 2.5;


//Comb Filter config
~combFilterDryWet = 1.0;
~presetName = "breaking glass";