~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/laser_var01.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/laser_var02.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/laser_var03.wav", channels: 0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/laser_var04.wav", channels: 0);
~sound5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/laser_var05.wav", channels: 0);
~sound6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/laser_var06.wav", channels: 0);

~sound = [~sound1, ~sound2, ~sound3, ~sound4, ~sound5, ~sound6];

~addsound = false;
~outcome = false;
~voices = 5;

//amplitude configuration
~ampfactor = 6.0;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 1.0;
