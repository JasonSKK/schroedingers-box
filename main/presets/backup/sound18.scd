~sound18var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spray_var01.wav", channels: 0);
~sound18var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spray_var02.wav", channels: 0);
~sound18var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spray_var03.wav", channels: 0);
~sound18var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spray_var04.wav", channels: 0);
~sound18var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/spray_var05.wav", channels: 0);


~sound = [~sound18var1, ~sound18var2, ~sound18var3, ~sound18var4, ~sound18var5];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 0.5;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
