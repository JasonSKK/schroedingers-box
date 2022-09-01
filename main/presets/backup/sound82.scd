~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var01.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var02.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var03.wav", channels: 0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var04.wav", channels: 0);
~sound5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var05.wav", channels: 0);
~sound6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var06.wav", channels: 0);
~sound7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var07.wav", channels: 0);
~sound8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var08.wav", channels: 0);
~sound9 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var09.wav", channels: 0);
~sound10 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var010.wav", channels: 0);
~sound11 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var011.wav", channels: 0);
~sound12 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var012.wav", channels: 0);
~sound13 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var013.wav", channels: 0);
~sound14 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var014.wav", channels: 0);
~sound15 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/ouch-voice_var015.wav", channels: 0);

~sound = [~sound1, ~sound2, ~sound3, ~sound4, ~sound5, ~sound6, ~sound7, ~sound8, ~sound9, ~sound10, ~sound11, ~sound12, ~sound13, ~sound14, ~sound15];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 8.0;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
~presetName = "Ouch!";
