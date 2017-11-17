SYSTEM = 'Anser1';
DAQ = 'nidaq621Xoem';
BOARDID = 'Dev1';
SAMPLESIZE = 5000;
MODELTYPE = 'exact';


sensorsToTrack = [1];

% Aquisition refresh rate in Hertz
refreshRate = 50;

% Call the setup function for the system.
sys = fSysSetup(sensorsToTrack, SYSTEM, DAQ, BOARDID, SAMPLESIZE, MODELTYPE);
FS = stoploop();




Fs = 100e3;
Ts=1/Fs;
numSamples = SAMPLESIZE;

% Specify the number of time samples, must be the same as the length of X
t=0:Ts:(numSamples - 1) * Ts; 

% Low pass FIR filter
% N, Order %must be the same as the length of t -1
% Fc, Cutoff Frequency
% flag, Sampling Flag
% SidelobeAtten, window parameter  attentation of the stopband
N  = length(t)-1;     
Fc = 0.00005;    
flag = 'scale';  
SidelobeAtten = 200; 

% Create the window vector for the design algorithm.
win = chebwin(N+1, SidelobeAtten);

% Calculate the coefficients using the FIR1 function.
% Extract the filter parameters
bf  = fir1(N, Fc, 'low', win, flag);
Hd = dfilt.dffir(bf); 
f=Hd.Numerator;

% Repeats the filter cooefficnets, must have the same number of rows as there are DAQ input signals.
G=repmat(f,2,1); 

sys.G = G;
figure;
FS=stoploop();
while (~FS.Stop())
   
   sys = fSysDAQUpdate(sys);
   sys = fSysGetField(sys);
   plot(1:8,20*log10(abs(sys.BField)),'o');
   ylim([-200,-50]);
   pause(1/refreshRate);

end