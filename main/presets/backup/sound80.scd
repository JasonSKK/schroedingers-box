~sound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_1.wav", channels: 0);
~sound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_2.wav", channels: 0);
~sound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_3.wav", channels: 0);
~sound4 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_6.wav", channels: 0);
~sound5 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_7.wav", channels: 0);
~sound6 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_8.wav", channels: 0);
~sound7 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_9.wav", channels: 0);

~sound = [~sound1, ~sound2, ~sound3, ~sound4, ~sound5, ~sound6, ~sound7];

~addsound1 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_add_1.wav", channels: 0);
~addsound2 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_add_2.wav", channels: 0);
~addsound3 = Buffer.readChannel(s, ~path+/+"./sounds_preprocessed/cash_register_add_3.wav", channels: 0);

~soundcat_sum = [~addsound1, ~addsound2, ~addsound3];

~addsound = true;
~outcome = false;
~voices = 2;
~ampfactor = 8.0;
~ampfactorcat = 8.0;
~presetName = "cash register";
