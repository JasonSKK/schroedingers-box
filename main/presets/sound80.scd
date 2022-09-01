~presetName = "cash register + secondary opening";
~primaryBuffers = ~fillNSamples.("cash_register_", 3, digits: 1) ++  ~fillNSamples.("cash_register_", 4, digits: 1, startIndex: 6);
~secondaryBuffers = ~fillNSamples.("cash_register_add_", 3, digits: 1);
~secondary = true;
~ampfactor = 8.0;
~ampfactorSecondary = 8.0;
