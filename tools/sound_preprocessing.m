
% Matlab/Octage script for pre-processing sound samples
% in order to save computing power on Bela
% 2022 Marian Weger
%
% In Octave, if you get the following error, then do what it says, then run the script again:
%	error: 'resample' undefined near line 22, column 21
%	The 'resample' function belongs to the signal package from Octave Forge
%	which you have installed but not loaded.  To load the package, run 'pkg
%	load signal' from the Octave prompt.
%

filenames = dir('../bela/sounds_raw/*.wav'); % search for wav files in the sound folder
Fs = 48000; % Sampling Rate of Bela

% load impulse response
IR = audioread('../bela/ir/2021-12-12_20-10-41-751_ex_ir_out_01_in_01.wav', 'double');

% go through all soundfiles
for d1=1:length(filenames)
    
    filename = strcat(filenames(d1).folder, '/', filenames(d1).name); % get full path to file
    [soundRaw, FsRaw] = audioread(filename, 'double'); % read audio
    soundRaw = soundRaw(:,1); % take only first channel, if multichannel sample
    
    % Fix samplerate if necessary
    if FsRaw~=Fs
        % needs resampling, as Bela runs on 48000
        resampled = resample(soundRaw, Fs, FsRaw);
    else
        resampled = soundRaw;
    end
    
    % convolve with impulse response
    sound = conv(resampled, IR, 'full');
       
    % set first and last sample to zero (safety so that Playback doesn't stop with DC)
    sound(1) = 0;
    sound(end) = 0;
    
    % prevent files from clipping
    if max(abs(sound))>1
       sound = sound / max(abs(sound)); % normalize to 1 if maximum exceeds 1
    end
    
    % Write processed sound
    audiowrite(strcat('../bela/sounds_preprocessed/',filenames(d1).name), sound, Fs, 'BitsPerSample', 24);
    
end
