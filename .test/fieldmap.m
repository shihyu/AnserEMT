

 % Volume over which to calculate B intensity
%  x=-0.3:0.1:0.3;
%  y=-0.3:0.1:0.3;
%  z=-0.3:0.1:0.3;

x = 0;
y = 0;
z = 0.1;
 
 % Generate volume mesh
 [X,Y,Z] = meshgrid(x,y,z);
 
 
 % Allocate space for results
 Hx = zeros(size(X));
 Hy = zeros(size(Y));
 Hz = zeros(size(Z));
 
 % Field current
 Current_I = 0.2;
 
 % Iterate through matrices can caluclate B intensities over specified
 % volume
 for k = 1:length(Z)
     for j = 1:length(Y)
         for i = 1:length(X)
             xp = X(i,j,k);
             yp = Y(i,j,k);
             zp = Z(i,j,k);
             [Hxp, Hyp,Hzp] = spiralCoilFieldCalcMatrixP(Current_I, sys.xcoil,sys.ycoil,sys.zcoil, xp,yp,zp);
             % Sum the H contributions from each transmitter coil to form a
             % final Hx, Hy, Hz results
             Hx(i,j,k) = sum(Hxp);
             Hy(i,j,k) = sum(Hyp);
             Hz(i,j,k) = sum(Hzp);
         end
     end
 end
 
 % Scale by u0 for B field 
 u0 = 4e-7 * pi;
 Bx = Hx * u0;
 By = Hy * u0;
 Bz = Hz * u0;
 
 