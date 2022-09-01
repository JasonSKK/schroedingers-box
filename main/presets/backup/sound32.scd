~sound32var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/init-impact_var01.wav", channels:0);
~sound32var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/init-impact_var02.wav", channels:0);
~sound32var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/init-impact_var03.wav", channels:0);
~sound32var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/init-impact_var04.wav", channels:0);
~sound32var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/init-impact_var05.wav", channels:0);
~sound32var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/init-impact_var06.wav", channels:0);

~soundoutcomevar1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cartoon-outcome_var01.wav", channels:0);
~soundoutcomevar2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cartoon-outcome_var02.wav", channels:0);
~soundoutcomevar3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cartoon-outcome_var03.wav", channels:0);
~soundoutcomevar4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cartoon-outcome_var03.wav", channels:0);

~sound = [~sound32var1, ~sound32var2, ~sound32var3, ~sound32var4, ~sound32var5, ~sound32var6];

~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3, ~soundoutcomevar4];

~addsound = false;
~outcome = true;
~voices = 3;

//amplitude configuration
~ampfactor = 13;
~ampfactorcat = 12;

//Comb Filter config
~combFilterDryWet = 1.0;

//hpf primary
~hpfPrimary = 100.0;