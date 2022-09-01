~presetName = "wood impact + cat";
~primaryBuffers = ~fillNSamples.("wood_hitting", 3);
~secondaryBuffers = ~fillNSamples.("new-cat_var", 9) ++ ~fillNSamples.("cat-scratch_var", 5);
~ampfactor = 9.5.neg;
~ampfactorSecondary = 20.0.neg;
~combFilterDryWet = 0.0;
~secondary = true;
