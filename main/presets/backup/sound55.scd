~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/wood_crack_1.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/wood_crack_2.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/wood_crack_3.wav", channels: 0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/wood_crack_4.wav", channels: 0);
~sound5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/wood_crack_5.wav", channels: 0);


~sound = [~sound1, ~sound2, ~sound3, ~sound4, ~sound5];

~addsound = false;
~outcome = false;
~voices = 1;

//amplitude configuration
~ampfactor = 9.0;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = -1.0;
