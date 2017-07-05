% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

function channelMap = fDAQMap(DAQType)
% FDAQMAP Maps the sensor indices to physical DAQ channels. The pinout of
% DAQ cards differ depending on the manfacturer. Pinout details are readily
% found in the device datasheets and user manuals. Pinouts for the
% National Instruments NI6212/6216 incl. OEM have been already included.


% Use a map structure to link channel indices to physical DAQ channels.
map = containers.Map('KeyType','double','ValueType','double');

if strcmp(DAQType, 'nidaq621X') == 1
    map(0) = 0;
    map(1) = 1;
    map(2) = 4;
    % Add additional sensor
elseif strcmp(DAQType, 'nidaq621Xoem') == 1
    % NI-6212 OEM DAQ channels for Anser sytem
    map(0) = 4;
    map(1) = 8;
    map(2) = 0;
elseif strcmp(DAQType, 'mccdaq') == 1
    % MCCDAQ channels mappings go here
   
else
    error('DAQType not supported');

end

% Return a channel mapping object. When accessed using a channel index, the
% map will return the corresponding hardware analog input channel ID
channelMap = map;
end

