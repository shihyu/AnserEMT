% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

% Run a real-time fast-fourier tranform a single sensor.
% Use this script as a starting point for visually inspecting the field
% strengths of the tracking system.

SYSTEM = 'Anser1';
DAQ = 'mccdaq';
BOARDID = 'Board0';
SAMPLESIZE = 10000;

% SYSTEM = 'Anser1';
% DAQ = 'nidaq621Xoem';
% BOARDID = 'Dev2';
% SAMPLESIZE = 10000;

% Channel the DAQ to inspect. This does NOT directly corresponding to the sensor
% channelLook at the DAQ pin mapping
sensorsToTrack = [2];

% Refresh rate of the position acquisition (Hz)
refreshRate = 20;

sys = fSysSetup(sensorsToTrack,SYSTEM, DAQ, BOARDID, SAMPLESIZE);

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
    sys=fSysDAQUpdate(sys);
    plot(1:SAMPLESIZE, sessionData(:,2));
    %periodogram(sessionData(:, 1))
    % Scale the axes of the plots to the desired range.
    pause(1/refreshRate);
end
stop(sys.NIDAQ);