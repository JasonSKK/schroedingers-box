~sound10var1 = Buffer.readChannel(s, "./sounds/bottle-hit_var01.wav", channels:1);
~sound10var2 = Buffer.readChannel(s, "./sounds/bottle-hit_var02.wav", channels:1);
~sound10var3 = Buffer.readChannel(s, "./sounds/bottle-hit_var03.wav", channels:1);
~sound10var4 = Buffer.readChannel(s, "./sounds/bottle-hit_var04.wav", channels:1);
~sound10var5 = Buffer.readChannel(s, "./sounds/bottle-hit_var05.wav", channels:1);

~soundoutcomevar1 = Buffer.readChannel(s, "./sounds/bottle-break_var01.wav", channels:1);
~soundoutcomevar2 = Buffer.readChannel(s, "./sounds/bottle-break_var02.wav", channels:1);
~soundoutcomevar3 = Buffer.readChannel(s, "./sounds/bottle-break_var03.wav", channels:1);

~sound = [~sound10var1, ~sound10var2, ~sound10var3, ~sound10var4, ~sound10var5];

~soundcat_sum = [~soundoutcomevar1, ~soundoutcomevar2, ~soundoutcomevar3];

~addsound = false;
~outcome = true;
