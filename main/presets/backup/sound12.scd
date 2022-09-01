~sound12var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/harpsi_var01.wav", channels: 0);
~sound12var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/harpsi_var02.wav", channels: 0);
~sound12var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/harpsi_var03.wav", channels: 0);
~sound12var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/harpsi_var04.wav", channels: 0);
~sound12var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/harpsi_var05.wav", channels: 0);


~sound = [~sound12var1, ~sound12var2, ~sound12var3, ~sound12var4, ~sound12var5];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 0.neg;
~ampfactorcat = inf.neg;


//Comb Filter config
~combFilterDryWet = 1.0.neg;
