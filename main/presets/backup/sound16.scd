~sound16var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/finger-snap_var01.wav", channels: 0);
~sound16var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/finger-snap_var02.wav", channels: 0);
~sound16var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/finger-snap_var03.wav", channels: 0);
~sound16var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/finger-snap_var04.wav", channels: 0);
~sound16var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/finger-snap_var05.wav", channels: 0);
~sound16var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/finger-snap_var06.wav", channels: 0);


~sound = [~sound16var1, ~sound16var2, ~sound16var3, ~sound16var4, ~sound16var5, ~sound16var6];

~addsound = false;
~outcome = false;
~voices = 3;

~hpfPrimary = 200.0;

//amplitude configuration
~ampfactor = 8;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
