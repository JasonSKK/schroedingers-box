//primary sound
~sound51var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var03.wav", channels:0);
~sound51var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var04.wav", channels:0);
~sound51var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var05.wav", channels:0);
~sound51var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/sackl-pop_var06.wav", channels:0);

//playback array
~sound = [~sound51var1, ~sound51var2, ~sound51var3, ~sound51var4];

 
//secondary sound
~sound51cat1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/party-trompete_var01.wav", channels:0);
~sound51cat2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/party-trompete_var02.wav", channels:0);
~sound51cat3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/party-trompete_var03.wav", channels:0);
~sound51cat4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/party-trompete_var04.wav", channels:0);
~sound51cat5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/party-trompete_var05.wav", channels:0);
~sound51cat6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/party-trompete_var06.wav", channels:0);

~soundcat_sum = [~sound51cat1, ~sound51cat2, ~sound51cat3, ~sound51cat4, ~sound51cat5, ~sound51cat6];

//secondary sound flag 
~addsound = true;
//no outcome sound (eg glass break)
~outcome = false;
//number of voices
~voices = 3;

//amplitude configuration
~ampfactor = 0.neg;
~ampfactorcat = 20;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
