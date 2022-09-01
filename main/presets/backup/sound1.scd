~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/atakes_vasi_ixeion_me_kleidi_var01.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/atakes_vasi_ixeion_me_kleidi_var02.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/atakes_vasi_ixeion_me_kleidi_var03.wav", channels: 0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/atakes_vasi_ixeion_me_kleidi_var04.wav", channels: 0);
~sound5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/atakes_vasi_ixeion_me_kleidi_var05.wav", channels: 0);

~sound = [~sound1, ~sound2, ~sound3, ~sound4, ~sound5];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 0.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 0.0;
~presetName = "metalic speaker stand";