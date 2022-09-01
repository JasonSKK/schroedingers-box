~sound17var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/plastic-container-impact_var01.wav", channels: 0);
~sound17var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/plastic-container-impact_var02.wav", channels: 0);
~sound17var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/plastic-container-impact_var03.wav", channels: 0);
~sound17var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/plastic-container-impact_var04.wav", channels: 0);
~sound17var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/plastic-container-impact_var05.wav", channels: 0);
~sound17var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/plastic-container-impact_var06.wav", channels: 0);


~sound = [~sound17var1, ~sound17var2, ~sound17var3, ~sound17var4, ~sound17var5, ~sound17var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 0.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;

//hpf primary
~hpfPrimary = 100.0;