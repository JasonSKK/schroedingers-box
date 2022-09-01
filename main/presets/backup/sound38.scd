~sound38var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/axe_var01.wav", channels: 0);
~sound38var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/axe_var02.wav", channels: 0);
~sound38var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/axe_var03.wav", channels: 0);
~sound38var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/axe_var04.wav", channels: 0);
~sound38var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/axe_var05.wav", channels: 0);
~sound38var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/axe_var06.wav", channels: 0);

~sound = [~sound38var1, ~sound38var2, ~sound38var3, ~sound38var4, ~sound38var5, ~sound38var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 5.5;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
