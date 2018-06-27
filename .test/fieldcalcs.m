


l=70e-3; 
w=0.5e-3; 
s=0.25e-3; 
thickness=1.6e-3; 
Nturns=25;

% Calculate generic points for both the vertical and angled coil positions
[x_points_angled,y_points_angled,z_points_angled] = fGetCoilDimensions(l, w, s, thickness, pi/4, Nturns, 'exact');
[x_points_vert,y_points_vert,z_points_vert] = fGetCoilDimensions(l, w, s, thickness, pi/2, Nturns, 'exact');

%[x_points_angled,y_points_angled,z_points_angled]=spiralCoilDimensionCalc(Nturns,l,w,s,thickness,pi/4); %angled coils at 45 degrees
%[x_points_vert,y_points_vert,z_points_vert]=spiralCoilDimensionCalc(Nturns,l,w,s,thickness,pi/2); %coils that are square with the lego

% Define the positions of each centre point of each coil

x_centre_points=[-93.543 0 93.543 -68.55 68.55 -93.543 0 93.543]*1e-3;
y_centre_points=[93.543 68.55 93.543 0 0 -93.543 -68.55 -93.543]*1e-3;

% Add the center position offsets to each coil
x_points1=x_points_vert+x_centre_points(1);
x_points2=x_points_angled+x_centre_points(2);
x_points3=x_points_vert+x_centre_points(3);
x_points4=x_points_angled+x_centre_points(4);
x_points5=x_points_angled+x_centre_points(5);
x_points6=x_points_vert+x_centre_points(6);
x_points7=x_points_angled+x_centre_points(7);
x_points8=x_points_vert+x_centre_points(8);

y_points1=y_points_vert+y_centre_points(1);
y_points2=y_points_angled+y_centre_points(2);
y_points3=y_points_vert+y_centre_points(3);
y_points4=y_points_angled+y_centre_points(4);
y_points5=y_points_angled+y_centre_points(5);
y_points6=y_points_vert+y_centre_points(6);
y_points7=y_points_angled+y_centre_points(7);
y_points8=y_points_vert+y_centre_points(8);

z_points1=z_points_vert;
z_points2=z_points_angled;
z_points3=z_points_vert;
z_points4=z_points_angled;
z_points5=z_points_angled;
z_points6=z_points_vert;
z_points7=z_points_angled;
z_points8=z_points_vert;

%Now bundle each into a matrix with coil vertices organised into columns.
x_matrix=[x_points1; x_points2; x_points3; x_points4; x_points5; x_points6; x_points7; x_points8];
y_matrix=[y_points1; y_points2; y_points3; y_points4; y_points5; y_points6; y_points7; y_points8];
z_matrix=[z_points1; z_points2; z_points3; z_points4; z_points5; z_points6; z_points7; z_points8];

MinSize = 1000;
MaxSize = 1000;
zheight = -0.02;
length = 70e-3;

txCoil = 1;

sourceCoilx = x_matrix(txCoil,:);
sourceCoily = y_matrix(txCoil,:);
sourceCoilz = z_matrix(txCoil,:);

% Select Receive Coil
rxCoil = 7;
rxCoilAngle = pi/4;
receiveCoilOffsetx = x_centre_points(rxCoil);
receiveCoilOffsety = y_centre_points(rxCoil);



% 
% for currentSize = MinSize:MaxSize
% 
%     dx = linspace(0,70e-3,currentSize + 1);
%     dy = linspace(0,70e-3,currentSize + 1);
%     dz = ones(1,currentSize + 1) * zheight;
% 
%     dA = (dx(2)-dx(1))*(dy(2)-dy(1));
% 
%     dhx=zeros(currentSize,currentSize);
%     dhy=zeros(currentSize,currentSize);
%     dhz=zeros(currentSize,currentSize);
% 
% 
% 
%     parfor i=1:(currentSize)
%         for j=1:(currentSize)
%             [dhx(i,j),dhy(i,j),dhz(i,j)]=spiralCoilFieldCalcMatrix(1,sourceCoilx,sourceCoily,sourceCoilz,dx(1,i),dy(1,j),zheight);
%         end
%     end
% 
%     FluxZ1(currentSize) = sum(sum(dhz.*dA))
% end

% The the resolution of the integration
currentSize = 1000;

dx = linspace(-35e-3,35e-3,currentSize + 1);
dy = linspace(-35e-3,35e-3,currentSize + 1);
dA = (dx(2)-dx(1))*(dy(2)-dy(1));
[dx,dy] = meshgrid(dx,dy);

dx1 = dx;
dy1 = dy;
R=[cos(rxCoilAngle), -sin(rxCoilAngle);sin(rxCoilAngle), cos(rxCoilAngle)];

temp = [dx1(:), dy1(:)] * R';
temp(:,1) = temp(:,1) + receiveCoilOffsetx;
temp(:,2) = temp(:,2) + receiveCoilOffsety;

dx=dx(:)';
dy=dy(:)';
dz = ones(1,currentSize + 1) * zheight;



dhx=zeros(currentSize);
dhy=zeros(currentSize);
dhz=zeros(currentSize^2,1);
dhz=dhz(:);

tic
parfor (i=1:currentSize^2,8)
    [dhx,dhy,dhz(i)]=spiralCoilFieldCalcMatrix(1,sourceCoilx,sourceCoily,sourceCoilz,dx(i),dy(i),zheight);
end
toc
FluxZ2 = sum(sum(dhz.*dA))



