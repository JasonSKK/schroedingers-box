~sound35var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var01.wav", channels: 0);
~sound35var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var02.wav", channels: 0);
~sound35var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var03.wav", channels: 0);
~sound35var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var04.wav", channels: 0);
~sound35var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var05.wav", channels: 0);
~sound35var6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var06.wav", channels: 0);
~sound35var7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var07.wav", channels: 0);
~sound35var8 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var08.wav", channels: 0);
~sound35var9 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var09.wav", channels: 0);
~sound35var10 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var010.wav", channels: 0);
~sound35var11 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var011.wav", channels: 0);
~sound35var12 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var012.wav", channels: 0);
~sound35var13 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var013.wav", channels: 0);
~sound35var14 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var014.wav", channels: 0);
~sound35var15 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/punch_var015.wav", channels: 0);


~sound = [~sound35var1, ~sound35var2, ~sound35var3, ~sound35var4, ~sound35var5, ~sound35var6, ~sound35var7, ~sound35var8, ~sound35var9, ~sound35var10, ~sound35var11, ~sound35var12, ~sound35var13, ~sound35var14, ~sound35var15];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 6.neg;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0.neg;
