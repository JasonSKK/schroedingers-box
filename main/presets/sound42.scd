~presetName = "thermo | secondary: balloons";
~primaryBuffers = ~fillNSamples.("thermo-metallic_var", 6);
~secondaryBuffers = ~fillNSamples.("ballon-defl_var", 2) ++ ~fillNSamples.("ballon-infl_var", 3) ++ ~fillNSamples.("balloon-pop_var_", 6) ++ ~fillSamples.(["balloon-defl_var03", "balloon-squeek_var01"]);
~secondary = true;
~ampfactor = 0.0;
~ampfactorSecondary = 5.0.neg;
