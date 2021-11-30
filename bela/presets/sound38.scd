~sound38var1 = Buffer.readChannel(s, "./sounds/axe_var01.wav", channels:1);
~sound38var2 = Buffer.readChannel(s, "./sounds/axe_var02.wav", channels:1);
~sound38var3 = Buffer.readChannel(s, "./sounds/axe_var03.wav", channels:1);
~sound38var4 = Buffer.readChannel(s, "./sounds/axe_var04.wav", channels:1);
~sound38var5 = Buffer.readChannel(s, "./sounds/axe_var05.wav", channels:1);
~sound38var6 = Buffer.readChannel(s, "./sounds/axe_var06.wav", channels:1);

~sound = [~sound38var1, ~sound38var2, ~sound38var3, ~sound38var4, ~sound38var5, ~sound38var6];

~addsound = false;
~outcome = false;
~voices = 5;

//amplitude configuration
~ampfactor = 10.neg;
~ampfactorcat = inf.neg;
//send amplitude config to bela
n.do{|item| item.sendMsg(\bela, \mainDB, ~ampfactor) }; // send mainDB config to Bela
n.do{|item| item.sendMsg(\bela, \catDB, ~ampfactorcat) }; // send catDB 