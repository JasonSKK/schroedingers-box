~sound16var1 = Buffer.readChannel(s, "./sounds/finger-snap_var01.wav", channels:1);
~sound16var2 = Buffer.readChannel(s, "./sounds/finger-snap_var02.wav", channels:1);
~sound16var3 = Buffer.readChannel(s, "./sounds/finger-snap_var03.wav", channels:1);
~sound16var4 = Buffer.readChannel(s, "./sounds/finger-snap_var04.wav", channels:1);
~sound16var5 = Buffer.readChannel(s, "./sounds/finger-snap_var05.wav", channels:1);
~sound16var6 = Buffer.readChannel(s, "./sounds/finger-snap_var06.wav", channels:1);


~sound = [~sound16var1, ~sound16var2, ~sound16var3, ~sound16var4, ~sound16var5, ~sound16var6];

~addsound = false;
~outcome = false;
~voices = 5;

//amplitude configuration
~ampfactor = 10.neg;
~ampfactorcat = inf.neg;
//send amplitude config to bela
n.do{|item| item.sendMsg(\bela, \mainDB, ~ampfactor) }; // send mainDB config to Bela
n.do{|item| item.sendMsg(\bela, \catDB, ~ampfactorcat) }; // send catDB 