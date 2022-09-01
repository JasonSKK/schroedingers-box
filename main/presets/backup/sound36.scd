~sound36var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/lamarina_var01.wav", channels: 0);
~sound36var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/lamarina_var02.wav", channels: 0);
~sound36var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/lamarina_var03.wav", channels: 0);
~sound36var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/lamarina_var04.wav", channels: 0);
~sound36var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/lamarina_var05.wav", channels: 0);

~sound = [~sound36var1, ~sound36var2, ~sound36var3, ~sound36var4, ~sound36var5];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 8;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;

//hpf primary
~hpfPrimary = 200.0;