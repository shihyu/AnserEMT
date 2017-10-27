function [x_points, y_points, z_points] = fGetCoilDimensions(len, wid, space, thickness, angle, Nturns, ModelType)
%FGETCOILDIMENSIONS Summary of this function goes here
%   Detailed explanation goes here


if strcmpi(ModelType,'EXACT') == 1
    [x_points, y_points, z_points] = spiralCoilDimensionCalc(Nturns,len,wid,space,thickness, angle);
elseif strcmpi(ModelType, 'FAST') == 1
    if (angle == pi/2)
        x_points = [-61.5e-3/2 61.5e-3/2 61.5e-3/2 -61.5e-3/2 -61.5e-3/2];
        y_points = [-61.5e-3/2 -61.5e-3/2 61.5e-3/2 61.5e-3/2 -61.5e-3/2];
        z_points = zeros(1,5)+- 1.6e-3/2;
    elseif(angle == pi/4)
        x_points = [-86.9741e-3/2 0 86.9741e-3/2 0 -86.9741e-3/2];
        y_points = [0 -86.9741e-3/2 0 86.9741e-3/2 0];
        z_points = zeros(1,5)+-1.6e-3/2;
    end
end

