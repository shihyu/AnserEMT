% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

% Use this file as a blank starting point for EMT applications

SYSTEM = 'Anser1';
DAQ = 'nidaq621Xoem';
BOARDID = 'Dev2';
SAMPLESIZE = 5000;


% Calls the setup function for the tracking system with two sensor channels
% [1,2] enabled. The returned object contains all the information regarding
% the tracking system, including coil dimensions, calibration data and the
% DAQ object.
sensorsToTrack = [1, 2];
sys = fSysSetup(sensorsToTrack, SYSTEM, DAQ, BOARDID, SAMPLESIZE);
