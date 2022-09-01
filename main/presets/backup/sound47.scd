~sound47var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metallic-box-w-nuts-inside_var01.wav", channels:0);
~sound47var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metallic-box-w-nuts-inside_var02.wav", channels:0);
~sound47var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metallic-box-w-nuts-inside_var03.wav", channels:0);
~sound47var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metallic-box-w-nuts-inside_var04.wav", channels:0);
~sound47var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metallic-box-w-nuts-inside_var05.wav", channels:0);
~sound47var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/metallic-box-w-nuts-inside_var06.wav", channels:0);

~sound = [~sound47var1, ~sound47var2, ~sound47var3, ~sound47var4, ~sound47var5, ~sound47var6];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 0.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;
