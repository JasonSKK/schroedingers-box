~sound23var1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/book-pages-chattering_var01.wav", channels:0);
~sound23var2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/book-pages-chattering_var02.wav", channels:0);
~sound23var3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/book-pages-chattering_var03.wav", channels:0);
~sound23var4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/book-pages-chattering_var04.wav", channels:0);
~sound23var5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/book-pages-chattering_var05.wav", channels:0);

~sound = [~sound23var1, ~sound23var2, ~sound23var3, ~sound23var4, ~sound23var5];

~addsound = false;
~outcome = false;
~voices = 3;

//amplitude configuration
~ampfactor = 4.5;
~ampfactorcat = inf.neg;

//Comb Filter config
~combFilterDryWet = 1.0;

//hpf primary
~hpfPrimary = 200.0;