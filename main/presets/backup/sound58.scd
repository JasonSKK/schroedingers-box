~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop_var01.wav", channels:0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop_var02.wav", channels:0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop_var03.wav", channels:0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop_var04.wav", channels:0);

~soundoutcomevar1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop-oc_var05.wav", channels:0);
~soundoutcomevar2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop-oc_var06.wav", channels:0);
~soundoutcomevar3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stone-drop-oc_var07.wav", channels:0);

~sound = [~sound1, ~sound2, ~sound3, ~sound4];

~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3];

~addsound = false;
~outcome = true;
~voices = 3;

//amplitude configuration
~ampfactor = 12.0;
~ampfactorcat = 14.5;


//Comb Filter config
~combFilterDryWet = 1.0;
