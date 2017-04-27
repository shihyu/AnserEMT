% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

% Run a real-time fast-fourier tranform a single sensor.
% Use this script as a starting point for visually inspecting the field
% strengths of the tracking system.
% 

% Channel the DAQ to inspect. This does NOT directly corresponding to the sensor
% channelLook at the DAQ pin mapping
sensorsToTest = [1,2];
% Refresh rate of the position acquisition (Hz)
refreshRate = 200;

sys = fSysSetup(sensorsToTest, 'nidaq621X');

% Get access to the global data structure used by the DAQ
global sessionData;

figure;
FS=stoploop();
while (~FS.Stop())
    
    % Perform an FFT of the desired channel. The index is incremented by
    % +1 in order to select the appropriate column in the structure. The
    % 1st column is the current reference signal for the transmitter coils.
    % This reference current signal can be viewed in the FFT by selecting
    % the first column of sessionData
    ft = fft(sessionData(:, 2));
    plot((1:(length(ft)/2))./2500, 20*log10(abs(ft(1:(length(ft)/2)))/length(ft)));
    
    % Scale the axes of the plots to the desired range.
    ylim([-120,0]) 
    xlim([0,1])
    pause(1/refreshRate);
end
