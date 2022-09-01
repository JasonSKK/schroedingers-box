"Loading Trigger Logic (server-logic) ... ".post;




/*===================== TRIGGER LOGIC =====================*/



// ONSET DETECTION
OSCdef(\triggerLogic, { |msg, time|
	var id = msg[2];
	var val = msg[3];

	// preset increment
	if(id==63, {
		// "DigitalIn0 triggered!".postln;
		~bigRedButtonFunc.();
		~presetChangeFunc.(~presetNr);
	});

	// trigger only if preset other than 0!
	if(~preset>0, {

		// Triggering, Cancelling, and Velocity update LOGIC
		if(id==1, {
			// TBOD trigger new
			p.primary[\vel] = val;
			~maybeTriggerYield.(); // maybe trigger yield sound
			~maybeNewSecondarySound.(); // maybe trigger new secondary sound
			if(~debugOnsets, {
				("TBOD: new onset. Vel:"+val).postln;
			});
		});

		/*
		// only for debug
		switch (id,
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
				if(~debugSourcePos, {
					("Source Localization: Velocities (dB rel to mean):"+(~globalvels/~globalvels.mean).ampdb.round(1.0)).postln;
				});
			};
		);
		*/

	});

},'/tr', s.addr);

"done.".postln;