"Loading Trigger Logic (sclang-logic) ... ".post;


/*===================== Primary Sound =====================*/

~chooseSound = {
	// set new sample ID (random from array, but not same as previous)
	~lastSoundID = ~soundIndArray[~soundIndArray.rejectIndices({|i| i==~lastSoundID})].choose;
};



// Primary sound
~newPrimarySound = {
	// set parameters
	p.primary[\bufnum] = ~primaryBuffers[~chooseSound.()];
	p.primary[\rate] = 1.0; // pitch is controlled by position
	p.primary[\eqFreq1] = (q[\eqMinFreq]*q[\eqMaxFreq]).sqrt; // map position to filter frequency
	p.primary[\eqFreq2] = p.primary[\eqFreq1]; // map position to filter frequency
	// p.primary[\combFiltFreq] = (q[\combFiltMinFreq]*q[\combFiltMaxFreq]).sqrt; // comb filter is controlled by position. just set it to the geometric mean.
	// p.primary[\vel] = q[\defaultVel];
	// play voice
	v.trigger(freq: 1, gate: 1, args: p.primary.asKeyValuePairs, lat: nil);
};


/*
// Primary sound TEST
~newPrimarySoundTest = {
	// set parameters
	p.primary[\vel] = q[\testOnsetVel];
	~mapVelPeakLevel.();
	p.primary[\bufnum] = ~primaryBuffers[~chooseSound.()];
	p.primary[\rate] = ~posToRate.([q[\testOnsetPosX],q[\testOnsetPosY]]); // map position to playback speed
	/*
	p.primary[\combFiltFreq1] = ~posToCombFreq.(q[\testOnsetPosX]); // map position to filter frequency
	p.primary[\combFiltFreq2] = ~posToCombFreq.(q[\testOnsetPosY]); // map position to filter frequency
	*/
	p.primary[\eqFreq1] = ~posToEQFreq.(q[\testOnsetPosX]); // map position to filter frequency
	p.primary[\eqFreq2] = ~posToEQFreq.(q[\testOnsetPosY]); // map position to filter frequency
	// play voice
	v.trigger(freq: 1, gate: 1, args: p.primary.asKeyValuePairs, lat: nil);
	// Yield
	~maybeTriggerYield.();
};
*/


/*
~posToRate = {|sourcePos|
	sourcePos.sum.linexp(inMin: -2.0, inMax: 2.0, outMin: q[\slMinPlaybackRate], outMax: q[\slMaxPlaybackRate], clip: \minmax); // map position to playback speed
};
*/

/*
~posToCombFreq = {|sourcePos|
	sourcePos.linexp(inMin: -2.0, inMax: 2.0, outMin: q[\combFiltMinFreq], outMax: q[\combFiltMaxFreq], clip: \minmax); // map position to filter frequency
};
*/

/*
~posToEQFreq = {|sourcePos|
	sourcePos.linexp(inMin: -1.0, inMax: 1.0, outMin: q[\eqMinFreq], outMax: q[\eqMaxFreq], clip: \minmax); // map position to filter frequency
};
*/


~updateSourcePos = {

	// Position goes from -1 to +1.

	// Channel mapping:
	//  top left: 2
	//  top right: 3
	//  bottom left: 0
	//  bottom right: 1

	// guess source position from level differences (i.e., from amplitude ratios)
	// right vs. left
	~sourcePos[0] = [~globalvels[3]/(~globalvels[2] + 1e-16), ~globalvels[1]/(~globalvels[0] + 1e-16)].collect{|i| i.explin(inMin: q[\slMinRatio], inMax: q[\slMaxRatio], outMin: -1.0, outMax: 1.0)}.mean;
	// top vs. bottom
	~sourcePos[1] = [~globalvels[2]/(~globalvels[0] + 1e-16), ~globalvels[3]/(~globalvels[1] + 1e-16)].collect{|i| i.explin(inMin: q[\slMinRatio], inMax: q[\slMaxRatio], outMin: -1.0, outMax: 1.0)}.mean;

	// set playback rate and comb filter, respectively
	p.primary[\rate] = ~posToRate.(~sourcePos); // map position to playback speed
	// p.primary[\combFiltFreq] = ~posToCombFreq.(~sourcePos); // map position to filter frequency

	p.primary[\eqFreq1] = ~posToEQFreq.(~sourcePos[0]); // map position to filter frequency
	p.primary[\eqFreq2] = ~posToEQFreq.(~sourcePos[1]); // map position to filter frequency

	// update voice
	~lastvoice.set([\rate, p.primary[\rate], \eqFreq1, p.primary[\eqFreq1], \eqFreq2, p.primary[\eqFreq2]]);

	if(~debugSourcePos, {
		("Localozation:"+~sourcePos.round(0.01)).postln;
	});


};




~mapVel = {
	p.primary[\vel] = ~globalvel.expexp(q[\velMapInMin], q[\velMapInMax], q[\velMapOutMin], q[\velMapOutMax], clip: \minmax);
};

~setVel = {
	~lastvoice.set([\vel, p.primary[\vel]]);
};

~mapVelPeakLevel = {
	// p.primary[\velPeakLevel] = ~globalvel.lincurve(q[\velMapInMin], q[\velMapInMax], 0.0, q[\velPeakLevel], curve: q[\velPeakMapCurve], clip: \minmax);
	p.primary[\velPeakLevel] = p.primary[\vel].ampdb.lincurve(2.0*q[\velPeakMapZeroDB], 0.0, q[\velPeakLevel].neg, q[\velPeakLevel], clip: \minmax);
};


/*===================== TRIGGER LOGIC =====================*/



// ONSET DETECTION
OSCdef(\triggerLogic, { |msg, time|
	var id = msg[2];
	var val = msg[3];

	// trigger only if preset other than 0!
	if(~preset>0, {

		// Triggering, Cancelling, and Velocity update LOGIC
		switch (id,
			/*
			0, { // False Alarm Cancellation
				if(~tbodTriggered&&~fbodAgrees.not, {
					~lastvoice.set([\gate, 0]);
					if(~debugOnsets, {
						("Onset cancelled.").postln;
					});
				});
				~tbodTriggered = false;
				~fbodAgrees = false;
			},
			*/
			1, { // TBOD trigger new
				~globalvel = val;
				~mapVel.();
				~mapVelPeakLevel.();
				~lastvoice = ~newPrimarySound.(); // trigger new primary sound
				~maybeTriggerYield.(); // maybe trigger yield sound
				~maybeNewSecondarySound.(); // maybe trigger new secondary sound
				if(~debugOnsets, {
					("TBOD: new onset. Vel:"+val).postln;
				});
				~tbodTriggered = true;
				~fbodAgrees = false;
			},
			/*
			2, { // FBOD trigger
				if( ~tbodTriggered, { // agree
					~fbodAgrees = true;
					if(~debugOnsets, {
						("FBOD: confirm").postln;
					});
				}, { // trigger new
					~globalvel = q[\defaultVel];
					~mapVel.();
					~mapVelPeakLevel.();
					~lastvoice = ~newPrimarySound.(); // trigger new primary sound
					~maybeTriggerYield.(); // maybe trigger yield sound
					~maybeNewSecondarySound.(); // maybe trigger new secondary sound
					if(~debugOnsets, {
						("FBOD: new onset").postln;
					});
				});
			},
			*/
			/*
			3, { // Velocity update
				~globalvel = val;
				~mapVel.();
				~setVel.();
				//~lastvoice.set([\vel, ~globalvel.lincurve(q[\velMapInMin], q[\velMapInMax], q[\velMapOutMin], q[\velMapOutMax], curve: q[\velMapCurve], clip: \minmax)]);
				if(~debugOnsets, {
					("Velocity update:"+val).postln;
				});
			},
			*/
			// Source Localization:
			4, { // Velocity update, Channel 1
				~globalvels[0] = val;
			},
			5, { // Velocity update, Channel 2
				~globalvels[1] = val;
			},
			6, { // Velocity update, Channel 3
				~globalvels[2] = val;
			},
			7, { // Velocity update, Channel 4
				~globalvels[3] = val;
				~updateSourcePos.(); // update source position
				if(~debugSourcePos, {
					("Source Localization: Velocities (dB rel to mean):"+(~globalvels/~globalvel).ampdb.round(1.0)).postln;
				});
			};
		);

	});

},'/tr', s.addr);

"done.".postln;