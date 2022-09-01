~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var01.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var02.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var03.wav", channels: 0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var04.wav", channels: 0);
~sound5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var05.wav", channels: 0);
~sound6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var06.wav", channels: 0);
~sound7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var07.wav", channels: 0);
~sound8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-restmuell_var08.wav", channels: 0);

~soundoutcomevar1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var01.wav", channels: 0);
~soundoutcomevar2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var02.wav", channels: 0);
~soundoutcomevar3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var03.wav", channels: 0);
~soundoutcomevar4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var04.wav", channels: 0);
~soundoutcomevar5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var05.wav", channels: 0);
~soundoutcomevar6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var06.wav", channels: 0);
~soundoutcomevar7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/bin-top-bounce_var07.wav", channels: 0);

~sound = [~sound1, ~sound2, ~sound3, ~sound4, ~sound5, ~sound6, ~sound7, ~sound8];
~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3, ~soundoutcomevar4, ~soundoutcomevar5, ~soundoutcomevar6, ~soundoutcomevar7];

~addsound = false;
~outcome = true;
~voices = 3;

//amplitude configuration
~ampfactor = 18.0;
~ampfactorcat = 15.0;


//Comb Filter config
~combFilterDryWet = 1.0;
~presetName = "litter bin bounce";