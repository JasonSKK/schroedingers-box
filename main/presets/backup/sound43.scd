//primary sound
~sound43var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var01.wav", channels:0);
~sound43var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var02.wav", channels:0);
~sound43var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var03.wav", channels:0);
~sound43var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var04.wav", channels:0);
~sound43var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var05.wav", channels:0);
~sound43var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var06.wav", channels:0);
~sound43var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var07.wav", channels:0);
~sound43var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var08.wav", channels:0);
~sound43var9 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var09.wav", channels:0);
~sound43var10 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-imp_var010.wav", channels:0);



//playback array
~sound = [~sound43var1, ~sound43var2, ~sound43var3, ~sound43var4, ~sound43var5, ~sound43var6, ~sound43var7, ~sound43var8, ~sound43var9, ~sound43var10];

//buffer load and initialisation
~soundstopped = 0; //do not play cat on every detected impact
 
//secondary sound
~sound43cat1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var01.wav", channels:0);
~sound43cat2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var02.wav", channels:0);
~sound43cat3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var03.wav", channels:0);
~sound43cat4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var04.wav", channels:0);
~sound43cat5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var05.wav", channels:0);
~sound43cat6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var06.wav", channels:0);
~sound43cat7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var07.wav", channels:0);
~sound43cat8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var08.wav", channels:0);
~sound43cat9 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/stapler-pins-drop_var09.wav", channels:0);

~soundcat_sum = [~sound43cat1, ~sound43cat2, ~sound43cat3, ~sound43cat4, ~sound43cat5, ~sound43cat6, ~sound43cat7, ~sound43cat8, ~sound43cat9];

//secondary sound flag 
~addsound = true;
//no outcome sound (eg glass break)
~outcome = false;
//number of voices
~voices = 3;

//amplitude configuration
~ampfactor = 4.5;
~ampfactorcat = 10;

//Comb Filter config
~combFilterDryWet = 1.0;

//secondary max count
~secondaryMaxCount = 3;

~hpfPrimary = 200.0;