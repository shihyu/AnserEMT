% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

% Run a real-time fast-fourier tranform a single sensor.
% Use this script as a starting point for visually inspecting the field
% strengths of the tracking system.

SYSTEM = 'Anser1';
DAQ = 'nidaq621Xoem';
BOARDID = 'Dev1';
SAMPLESIZE = 5000;
MODELTYPE = 'exact';

% Channel the DAQ to inspect. This does NOT directly corresponding to the sensor
% channelLook at the DAQ pin mapping
sensorsToTrack = [1];

% Refresh rate of the position acquisition (Hz)
refreshRate = 20;

sys = fSysSetup(sensorsToTrack,SYSTEM, DAQ, BOARDID, SAMPLESIZE, MODELTYPE);

% Get access to the global data structure used by the DAQ
global sessionData;

figure;
FS=stoploop();
pause(1);
while (~FS.Stop())
    
    % Perform an FFT of the analog-in channels. The index is incremented by
    % +1 in order to select the appropriate column in the structure. The
    % 1st column is the current reference signal for the transmitter coils.
    % This reference current signal can be viewed in the FFT by selecting
    % the first column of sessionData (i.e. '1')
    ft = fft(sessionData(:, 2));
    plot((1:(length(ft)/2))./(length(ft)/2), 20*log10(abs(ft(1:(length(ft)/2)))/length(ft)));
    %periodogram(sessionData(:, 1))
    % Scale the axes of the plots to the desired range.
    ylim([-120,-0]) 
    xlim([0,1])
    pause(1/refreshRate);
end
stop(sys.NIDAQ);