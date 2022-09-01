~sound46var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var01.wav", channels:0);
~sound46var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var02.wav", channels:0);
~sound46var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var03.wav", channels:0);
~sound46var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var04.wav", channels:0);
~sound46var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var05.wav", channels:0);
~sound46var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var06.wav", channels:0);
~sound46var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var07.wav", channels:0);
~sound46var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-toing-overtones_var08.wav", channels:0);

~sound = [~sound46var1, ~sound46var2, ~sound46var3, ~sound46var4, ~sound46var5, ~sound46var6, ~sound46var7, ~sound46var8];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 4.5;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;

//hpf primary
~hpfPrimary = 100.0;
~presetName = "aluminum can overtones";