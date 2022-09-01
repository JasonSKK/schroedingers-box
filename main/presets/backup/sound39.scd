~sound39var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/match_var01.wav", channels:0);
~sound39var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/match_var02.wav", channels:0);
~sound39var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/match_var03.wav", channels:0);

//happens only once??
~soundonce = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/match_light.wav", channels:0);

~soundoutcomevar1 = Buffer.read(s, ~path+/+"./sounds_preprocessed/match-light_var01.wav");
~soundoutcomevar2 = Buffer.read(s, ~path+/+"./sounds_preprocessed/match-light_var02.wav");
~soundoutcomevar3 = Buffer.read(s, ~path+/+"./sounds_preprocessed/match-light_var03.wav");
~soundoutcomevar4 = Buffer.read(s, ~path+/+"./sounds_preprocessed/match-light_var04.wav");

~sound = [~sound39var1, ~sound39var2, ~sound39var3];

~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3, ~soundoutcomevar4, ~soundonce];

~addsound = false;
~outcome = true;
//only one voice
~voices = 1;

//amplitude configuration
~ampfactor = 8;
~ampfactorcat = 7.5;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
