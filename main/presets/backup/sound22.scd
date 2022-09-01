~sound22var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-impact_var01.wav", channels: 0);
~sound22var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-impact_var02.wav", channels: 0);
~sound22var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-impact_var03.wav", channels: 0);
~sound22var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-impact_var04.wav", channels: 0);
~sound22var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-impact_var05.wav", channels: 0);
~sound22var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-impact_var06.wav", channels: 0);

~sound = [~sound22var1, ~sound22var2, ~sound22var3, ~sound22var4, ~sound22var5, ~sound22var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 4;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;

//hpf primary
~hpfPrimary = 200.0;