~sound12var1 = Buffer.readChannel(s, "./sounds/harpsi_var01.wav", channels:1);
~sound12var2 = Buffer.readChannel(s, "./sounds/harpsi_var02.wav", channels:1);
~sound12var3 = Buffer.readChannel(s, "./sounds/harpsi_var03.wav", channels:1);
~sound12var4 = Buffer.readChannel(s, "./sounds/harpsi_var04.wav", channels:1);
~sound12var5 = Buffer.readChannel(s, "./sounds/harpsi_var05.wav", channels:1);


~sound = [~sound12var1, ~sound12var2, ~sound12var3, ~sound12var4, ~sound12var5];

~addsound = false;
~outcome = false;