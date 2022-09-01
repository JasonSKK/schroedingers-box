~presetName = "match strike | yield: match light";
~primaryBuffers = ~fillNSamples.("match_var", 3);
~yieldBuffers = ~fillNSamples.("match-light_var", 4) ++ ~fillSamples.(["match_light"]);
~yield = true;
~voices = 1;
~ampfactor = 8.0;
~ampfactorYield = 7.5;
