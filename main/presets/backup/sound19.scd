~sound19var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/churchbell_var01.wav", channels: 0);
~sound19var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/churchbell_var02.wav", channels: 0);
~sound19var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/churchbell_var03.wav", channels: 0);
~sound19var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/churchbell_var04.wav", channels: 0);
~sound19var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/churchbell_var05.wav", channels: 0);
~sound19var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/churchbell_var06.wav", channels: 0);

~sound = [~sound19var1, ~sound19var2, ~sound19var3, ~sound19var4, ~sound19var5, ~sound19var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 3.5.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
