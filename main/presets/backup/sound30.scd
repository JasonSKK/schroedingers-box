~sound30var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var01.wav", channels: 0);
~sound30var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var02.wav", channels: 0);
~sound30var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var03.wav", channels: 0);
~sound30var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var04.wav", channels: 0);
~sound30var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var05.wav", channels: 0);
~sound30var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var06.wav", channels: 0);
~sound30var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var07.wav", channels: 0);
~sound30var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/fan-wire-rattle_var08.wav", channels: 0);

~sound = [~sound30var1, ~sound30var2, ~sound30var3, ~sound30var4, ~sound30var5, ~sound30var6, ~sound30var7, ~sound30var8];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 1.5.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;

//hpf primary
~hpfPrimary = 100.0;