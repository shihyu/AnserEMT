function [x,y,z] = fCalPoints(calibrationtype)

 if (strcmpi(calibrationtype, 'DUPLO') == true)

    % Specify no. of blocks used for the system calibration NOT including the sensor block
    % as this determines the z values of each testpoint. 
    calBlockNum = 5;
    % Sensor positioned halfway up one block
    calSensorPosition = 0.5;


    % Total height in terms of blocks. Dimensions in millimeters.
    calTowerBlocks  = calBlockNum + calSensorPosition;
    BlockHeight = 19.2;
     
    % Spacing of test points on the Duplo board
    x=(-3:1:3)*(31.75e-3); 
    x=[x x x x x x x];
    y=[ones(1,7)*95.25*1e-3 ones(1,7)*63.5*1e-3  ones(1,7)*31.75*1e-3 ones(1,7)*0  ones(1,7)*-31.75*1e-3 ones(1,7)*-63.5*1e-3 ones(1,7)*-95.25*1e-3 ];

    boardDepth = 15; % Millimeters
    z = (1e-3*(boardDepth + calTowerBlocks*BlockHeight)) * ones(1,49);
    
 elseif (strcmpi(calibrationtype, '9x9') == true)
    % Spacing of test points on the Anser board
    spacing = (100/3) * 1e-3;
    probeHeight = 80e-3;
    x=(-4:1:4)*(spacing); 
    x=[x x x x x x x x x];
    y=[ones(1,9)*spacing*4 ones(1,9)*spacing*3  ones(1,9)*spacing*2 ones(1,9)*spacing*1 ones(1,9)*0 -ones(1,9)*spacing*1 -ones(1,9)*spacing*2 -ones(1,9)*spacing*3 -ones(1,9)*spacing*4];

    boardDepth = 4e-3; % Millimeters
    z = ((boardDepth + probeHeight)) * ones(1,81);
 
 elseif (strcmpi(calibrationtype, '7x7') == true)
    % Spacing of test points on the Anser board
    spacing = (42.86) * 1e-3;
    probeHeight = 80e-3;
    x=(-3:1:3)*(spacing); 
    x=[x x x x x x x];
    y=[ones(1,7)*spacing*3  ones(1,7)*spacing*2 ones(1,7)*spacing*1 ones(1,7)*0 -ones(1,7)*spacing*1 -ones(1,7)*spacing*2 -ones(1,7)*spacing*3];

    boardDepth = 4e-3; % Millimeters
    z = ((boardDepth + probeHeight)) * ones(1,49);
 end
 
end