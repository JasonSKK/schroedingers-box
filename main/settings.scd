"Loading Settings ... ".post;



// parameter default values
e = (); // create empty dictionary

e.presetName = "not initialized";

// TBOD
e.tbThreshDB = 65.0.neg; // 120.0.neg;//155.0.neg; // TBOD threshold in dB
e.tbThreshLoDB = 180.0.neg; // TBOD lower threshold in dB
e.tbRefPeriod = 0.05;// specifies a minimum gap (in seconds) between subsequent onset detections
e.tbLpf1Freq = 1000.0; // 25.0; // frequency of 1st low-pass filter in Hz (TBOD)
e.tbLpf2Freq = 1000.0; // 25.0; // frequency of 2nd low-pass filter in Hz (TBOD)
e.tbHpfFreq = 4000.0; // frequency of high-pass filter in Hz  (TBOD)
e.cancelDel = 1.0; // Delay between TBOD trigger and cancel message, in FFT frames.

// FBOD
/*
e.fbThreshDB = -20.0; // FBOD threshold in dB
e.fbRelaxtime = 1.0; // specifies the time (in seconds) for the normalisation to "forget" about a recent onset. If you find too much re-triggering (e.g. as a note dies away unevenly) then you might wish to increase this value.
e.fbFloorDB = 10.0.neg; // is a lower limit, connected to the idea of how quiet the sound is expected to get without becoming indistinguishable from noise. For some cleanly-recorded classical music with wide dynamic variations, I found it helpful to go down as far as 0.000001.
e.fbMingap = 40; // specifies a minimum gap (in FFT frames) between onset detections, a brute-force way to prevent too many doubled detections.
e.fbMedianspan = 22; // specifies the size (in FFT frames) of the median window used for smoothing the detection function before triggering.
*/

//e.od = 1; // toggle onset detection
//e.output = 1; // toggle output synth

// Velocity detection
e.velDelay = 0.0009; // delay between TBOD trigger and reporting of velocity. Velocity will be the maximum in this time period.
e.defaultVel = 0.05; // default velocity
e.velUpdateLag = 0.0002; // lag time for velocity update smoothing
e.velMapInMin = 5e-3; // 0.001; // mapping between amplitude and velocity: inMin
e.velMapInMax = 100e-3; // 485.0e-3;//0.1; // mapping between amplitude and velocity: inMax
e.velMapOutMin = 0.05; // 0.3; // mapping between amplitude and velocity: outMin
e.velMapOutMax = 1.0; // mapping between amplitude and velocity: outMax
//e.velMapCurve = 4.0.neg; // mapping between amplitude and velocity: curve
e.velEnvDur = 0.04; // release time of velocity-controlled high-shelf
e.velPeakLevel = 10.0; // peak level in dB for velocity-controlled high-shef
e.velPeakMapCurve = 0.0; // HF Boost Curve Parameter
e.velPeakMapZeroDB = -5.0; // HF Boost 0dB value. At the given value in dB there will be no HF boost. Above will be HF boost, below will be HF cut.
e.inGain1 = -7.0; // input gain of Mic Channel 1
e.inGain2 = 0.0; // input gain of Mic Channel 2
e.inGain3 = 0.0; // input gain of Mic Channel 3
e.inGain4 = -1.0; // input gain of Mic Channel 4

// Preset Settings
e.primaryDB = inf.neg; // primary level in dB
e.secondaryDB = inf.neg; // secondary level in dB
e.yieldDB = inf.neg; // yield level in dB
e.secondaryCutoff = 4000.0; // Cutoff frequency of LPF for secondary sound, in Hz
e.eqGain = 12.0; // level for eq resonance filter, in dB
e.eqRQ = 1.0; // reciprocal Q-factor of eq resonance filter
e.hpfPrimary = 20;

// Master
e.primaryMasterDB = 0.0; // primary level in dB
e.secondaryMasterDB = 0.0; // secondary level in dB
e.yieldMasterDB = 5.0.neg; // yield level in dB
e.masterHPF = 50.0; // 146.0; // master HPF cutoff in Hz
e.masterLPF = 18000.0; // 6900.0; // master LPF cutoff in Hz
// e.eq = 1; // output equalization
e.masterLevel = 6.0; // Master level in dB

// Experiment
e.participantID = 0; // participant ID
e.preset = 0; // sound preset

// Test Tone Generator
e.sineMasterDB = 80.0.neg; // level of sine generator in dB
e.noiseMasterDB = 80.0.neg; // level of noise generator in dB
e.testFreq = 400.0; // sine frequency in Hz
e.toggleMaster = 0; // start/stop the test tone synth
e.toggle1 = 0; // output channel 1 on/off
e.toggle2 = 0; // output channel 2 on/off
e.toggle3 = 0; // output channel 3 on/off
e.toggle4 = 0; // output channel 4 on/off
e.flip1 = 0; // output channel 1 flip phase
e.flip2 = 0; // output channel 2 flip phase
e.flip3 = 0; // output channel 3 flip phase
e.flip4 = 0; // output channel 4 flip phase

// Primary Sound
e.eqMinFreq = 400.0; // minimum eq frequency in Hz
e.eqMaxFreq = 2000.0; // maximum eq frequency in Hz
e.slMaxPlaybackRate = 1.025; // max playback rate, as controlled by source localization


// Source Localization
e.slMaxRatio = 2.0; // maximum amplitude ratio for source localization

// Parameters of the test signal generator
e.testOnsetPosX = 0.0;
e.testOnsetPosY = 0.0;
e.testOnsetVel = 0.5;
e.testOnsetFreq = 1.5;


// Yield sound
e[\yield] = false; // yield sound active
e.yieldThreshold = 0.999; // threshold velocity for breaking

// Secondary Sound
e.secondary = false; // secondary sound active
e.secondaryMinDel = 0.5; // minimum start delay
e.secondaryMaxDel = 1.0; // maximum start delay
e.secondaryMinCount = 1; // min onset count for secondary trigger
e.secondaryMaxCount = 6; // max onset count for secondary trigger
e.secondaryCountCurve = 3; // curve
e.rateRand = 0.05; // percent rate randomization


"done.".postln;