//primary sound
~sound48var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var01.wav", channels:0);
~sound48var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var02.wav", channels:0);
~sound48var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var03.wav", channels:0);
~sound48var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var04.wav", channels:0);
~sound48var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var05.wav", channels:0);
~sound48var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var06.wav", channels:0);


//playback array
~sound = [~sound48var1, ~sound48var2, ~sound48var3, ~sound48var4, ~sound48var5, ~sound48var6];

 
//secondary sound
~sound48cat1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-movement_var01.wav", channels:0);
~sound48cat2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-movement_var02.wav", channels:0);
~sound48cat3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-movement_var03.wav", channels:0);
~sound48cat4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-squeek_var01.wav", channels:0);
~sound48cat5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-squeek_var02.wav", channels:0);
~sound48cat6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-squeek_var03.wav", channels:0);
~sound48cat7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-squeek_var04.wav", channels:0);

~soundcat_sum = [~sound48cat1, ~sound48cat2, ~sound48cat3, ~sound48cat4, ~sound48cat5, ~sound48cat6, ~sound48cat7];

//secondary sound flag 
~addsound = true;
//no outcome sound (eg glass break)
~outcome = false;
//number of voices
~voices = 3;

//amplitude configuration
~ampfactor = 4.5;
~ampfactorcat = 5;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
