~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/2kHz_48000_100ms.wav", channels: 0);

~sound = [~sound1, ~sound1];


~addsound = false;
~outcome = false;
~voices = 1;
~ampfactor = 1.9382002601611; // 0.8.reciprocal.ampdb;
~ampfactorcat = inf.neg;
~presetName = "2kHz test tone";
