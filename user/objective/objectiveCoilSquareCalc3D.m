% Anser EMT, the worlds first open-source electromagnetic tracking system.
% Copyright (c) 2017, Alex Jaeger, Kilian O'Donoghue
% All rights reserved.
% This code is licensed under the BSD 3-Clause License.

function [out]= objectiveCoilSquareCalc3D(currentPandO, sys, fluxReal)
% objectiveCoilSquareCalc3D.m
% Objective function to calculate the difference between the modelled and measured magnetic flux values due to a single pcb emitter coil.
% This is the 'Cost' function for the LM algorithm. Each iteration of LMA executes this function 8 times, once for each coil.

% currentPandO = The current position and orientation vector. This vector is the variable parameter of the objective function.
% sys          = The system object
% fluxReal     = A scaler indicating the sensed magnetic flux the sensor. 

% out          = The difference between the sensed and calculated fluxes due to a single coil


% Extract the position and orientation for readability
x = currentPandO(1);
y = currentPandO(2);
z = currentPandO(3);
theta = currentPandO(4);
phi = currentPandO(5);


% Calculate the magnetic field intensity at [x,y,z] due to an emitter coil whose copper tracks are traced by [xcoil, ycoil, zcoil]
% [Hx,Hy,Hz]= spiralCoilFieldCalcMatrix(1,sys.xcoil,sys.ycoil,sys.zcoil,x,y,z); 


% Scale the intensities by the permeability of free space.
% Bx=sys.u0.*Hx;
% By=sys.u0.*Hy;
% Bz=sys.u0.*Hz;


% Calculate the net magnetic flux cutting the tracking sensor coil.
% fluxModel=(sys.BScaleActive)'.*(Bx.*sin(theta).*cos(phi)+By.*sin(theta).*sin(phi)+Bz.*cos(theta));

totalFlux = 0;
radius = 6e-3;
dx = radius/10;
dy = dx;
% numSquares = length(-radius:dx:radius)^2;

T = fSphericalToMatrix([0,0,0,theta,phi]);
T = T(1:3,1:3);


for i=-radius:dx:radius
    for j = -radius:dy:radius

    	fluxPoint = T * [i;j;0];

        [Hxx,Hyy,Hzz]= spiralCoilFieldCalcMatrix(1,sys.xcoil,sys.ycoil,sys.zcoil,x+fluxPoint(1),y+fluxPoint(2),z+fluxPoint(3));
        Bxx=sys.u0.*Hxx;
        Byy=sys.u0.*Hyy;
        Bzz=sys.u0.*Hzz;
        currentFlux = (Bxx.*sin(theta).*cos(phi)+Byy.*sin(theta).*sin(phi)+Bzz.*cos(theta));
        totalFlux = totalFlux + currentFlux;
    end
end

totalFlux =  (sys.BScaleActive)'.* totalFlux;
fluxModel = totalFlux;

% Return the difference between the calculated magnetic flux and the sensed magnetic flux due to a single emitter coil
out = fluxModel - fluxReal;