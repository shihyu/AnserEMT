% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

function sys = fGetSensorPosition(sys, sensorNo)
% fGetSensorPosition.m
% Resolves the position of the tracking sensor coil.

% sys            = The system object

% positionVector = The 5-DOF vector describing the tracking coil's position and orientation in space.
% positionMatrix = A 4x4 homogenous transform representiing the tracking coil's position and orientation in space.



% Select the sensor to process. This loads in the specific calibration.
sys = fSysSensor(sys, sensorNo);

% If no sensor selected, raise error.
if sys.SensorNo == -1
    error('Please select the active sensor using fSysSensor()');
end

% Demodulate the stored samples and update the system object with the new field strengths.
sys = fSysGetField(sys);

% Resolve the position of the sensor as a 5-DOF vector.
positionVector = fSysDecodeField(sys);
% Convert the vector to a homogenous transformation matrix.
positionMatrix = fSphericalToMatrix(positionVector);

% Set the initial conditions for the next iteration to the current position
sys.estimateInit(sys.SensorNo,:) = positionVector;
sys.positionVector = positionVector;
sys.positionMatrix = positionMatrix;


end

