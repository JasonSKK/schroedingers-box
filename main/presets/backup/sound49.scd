//primary sound
~sound49var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/boiler-click_var01.wav", channels:0);
~sound49var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/boiler-click_var02.wav", channels:0);
~sound49var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/boiler-click_var03.wav", channels:0);
~sound49var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/boiler-click_var04.wav", channels:0);

//playback array
~sound = [~sound49var1, ~sound49var2, ~sound49var3, ~sound49var4];

//buffer load and initialisation
~soundstopped = 0; //do not play cat on every detected impact
 
//secondary sound
~sound49cat1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/boiler.wav", channels:0);

~soundcat_sum = [~sound49cat1, ~sound49cat1];

//secondary sound flag 
~addsound = true;
//no outcome sound (eg glass break)
~outcome = false;
//number of voices
~voices = 3;

//amplitude configuration
~ampfactor = 3;
~ampfactorcat = 10;

//Comb Filter config
~combFilterDryWet = 1.0;
