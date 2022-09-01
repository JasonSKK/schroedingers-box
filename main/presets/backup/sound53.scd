//primary sound
~sound53var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var01.wav", channels:0);
~sound53var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var02.wav", channels:0);
~sound53var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var03.wav", channels:0);
~sound53var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var04.wav", channels:0);
~sound53var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var05.wav", channels:0);
~sound53var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var06.wav", channels:0);
~sound53var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var07.wav", channels:0);
~sound53var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/aluminum-impact_var08.wav", channels:0);


//playback array
~sound = [~sound53var1, ~sound53var2, ~sound53var3, ~sound53var4, ~sound53var5, ~sound53var6, ~sound53var7, ~sound53var8];
 
//secondary sound
~sound53cat1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var01.wav", channels:0);
~sound53cat2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var02.wav", channels:0);
~sound53cat3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var03.wav", channels:0);
~sound53cat4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var04.wav", channels:0);
~sound53cat5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var05.wav", channels:0);
~sound53cat6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var06.wav", channels:0);
~sound53cat7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var07.wav", channels:0);
~sound53cat8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/nails-drop_var08.wav", channels:0);

~soundcat_sum = [~sound53cat1, ~sound53cat2, ~sound53cat3, ~sound53cat4, ~sound53cat5, ~sound53cat6, ~sound53cat7, ~sound53cat8];

//secondary sound flag 
~addsound = true;
//no outcome sound (eg glass break)
~outcome = false;
//number of voices
~voices = 3;

//amplitude configuration
~ampfactor = 7.5;
~ampfactorcat = 0.neg;

//Comb Filter config
~combFilterDryWet = 1.0;

~secondaryMaxCount = 4;