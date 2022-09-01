//primary sound
~sound45var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var01.wav", channels:0);
~sound45var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var02.wav", channels:0);
~sound45var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var03.wav", channels:0);
~sound45var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var04.wav", channels:0);
~sound45var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var05.wav", channels:0);
~sound45var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var06.wav", channels:0);
~sound45var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-imp-top_var07.wav", channels:0);
//playback array
~sound = [~sound45var1, ~sound45var2, ~sound45var3, ~sound45var4, ~sound45var5, ~sound45var6, ~sound45var7];

//buffer load and initialisation
 
//secondary sound
~sound45cat1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-shake_var01.wav", channels:0);
~sound45cat2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-shake_var02.wav", channels:0);
~sound45cat3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-shake_var03.wav", channels:0);
~sound45cat4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-shake_var04.wav", channels:0);
~sound45cat5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-shake_var05.wav", channels:0);
~sound45cat6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/noodles-shake_var06.wav", channels:0);

~soundcat_sum = [~sound45cat1, ~sound45cat2, ~sound45cat3, ~sound45cat4, ~sound45cat5, ~sound45cat6];

//secondary sound flag 
~addsound = true;
//no outcome sound (eg glass break)
~outcome = false;
//number of voices
~voices = 3;

//amplitude configuration
~ampfactor = 4.5;
~ampfactorcat = 5.neg;

//Comb Filter config
~combFilterDryWet = 1.0;

//hpf primary
~hpfPrimary = 200.0;

~secondaryMaxCount = 3;