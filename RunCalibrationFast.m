% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.


% SYSTEM = 'Anser1';
% DAQ = 'mccdaq';
% BOARDID = 'Board0';
% SAMPLESIZE = 5000;

SYSTEM = '7x7';
DAQ = 'nidaq621Xoem';
BOARDID = 'Dev4';
SAMPLESIZE = 5000;
MODELTYPE = 'exact';

% Select which sensor channel you will use for calibration.
% Each sensor must be calibrated seperatly due to gain variations
% in the system amplifier electronics.
% Sensor indices begin at '1'
sensorToCal = input('Enter the channel to Calibrate: ');
refSensor = input('Enter channel of reference sensor: ');

% Select the desired sensor. This will also ensure the appropriate calibration
% parameters are saved after calibration.
sys = fSysSetup([sensorToCal,refSensor],SYSTEM, DAQ, BOARDID, SAMPLESIZE, MODELTYPE);


% Acquire the testpoints necessary for calibration.
fprintf('\nConnect probe to reference channel, press enter when done....\n');
pause;
sys = fSysSensor(sys, refSensor);
sys = fSysDAQUpdate(sys);
sys = fSysGetField(sys);
Bref = sys.BField(1);

fprintf('Connect probe to desired calibration channel, press enter when done....\n');
pause;
sys = fSysSensor(sys, sensorToCal);
sys = fSysDAQUpdate(sys);
sys = fSysGetField(sys);
Bcal = sys.BField(1);

sys.BScaleActive = (Bref/Bcal).*sys.BScale(refSensor,:);

sys=fSysSave(sys);
fprintf('Done....!\n');
