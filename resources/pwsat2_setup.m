h = 6378e3;
G = 6.6743015e-11;
Re = 6356e3;
Me = 5.972e24;

mass = 1;

omega = 7.2921150e-5;
mu = 3.986004418e14;

n = 14.94845317;
a = (mu^(1/3))/((2*n*pi/86400)^(2/3))+0.01e5;
% a = h+400e3;
e = 0.0011871;
incl = deg2rad(97.7672);
RA = deg2rad(56.1804);
w = deg2rad(236.0402);
MA = deg2rad(123.9692);
[my_ga, TA] = kepler1(MA, e);

T = 2*pi*sqrt(a^3/(G*Me));

% SIMULATION PARAMETERS
TStart = 0; 
% TFinal = 24*60*60*700;
% dT2 = 24*60*60;
TFinal = 3*24*60*60;
% TFinal = 50*T;
%larget possible tested: 50s
dT2 = 5;
%for PD, dT <= 0.01
t = TStart:dT2:TFinal;

initEuler = [0 0 0]; % [deg]sun_position(:,1)
forcesBody = [0 0 0];
momentsBody = [0 0 0];

initYear = 2000;
initDay = 0;
utc = [2018 12 13 2 56 43];
julian = juliandate(utc);
juliansec = juliandate([2000 1 1 12 0 1]) - juliandate([2000 1 1 12 0 0]);
decstart = decyear(utc);
decsec = decyear(2000,1,1,12,0,1) - decyear(2000,1,1,12,0,0);
[r_eci, v_eci] = kep2eci(a, e, RA, incl, w, TA, mu);
% 2453404
% [r_ecef,v_ecef] = eci2ecef([2005 2 2 12 0 0],r_eci,v_eci); % this is from aerorpace tb
[r_ecef,v_ecef] = eci2ecef(utc,r_eci,v_eci); % this is from aerorpace tb
r_lla = ecef2lla(r_ecef'); % this too

dT = 0.1;
cube = sim('cubesat_propagation' ,[0 1]);
v_b = cube.v_b(1,:); % you have to find how it is calculated
dT = dT2;
dT_table = dT2;

refVel = [v_b(1) v_b(2) v_b(3)];
% refEuler = [0 0.5 1];
% refVel = [v_b(1) v_b(2)+500 v_b(3)];
refEuler = [0 deg2rad(45) deg2rad(45)];
% refEuler = [0 0 0];
initMoments = [0 0 0];
initEulerRates = [0.0 0.0 0.0];
% initEulerRates = -scars_out.SatStates.Omega_B.Data(1,:);


% steps
startTime = 0;
lengthTime = 0;
stepTime = 50;
dtStep = 10;

% open_system('scars_model')
% disp('Sun position')
% sun_position = getSunPositions(julian, TFinal, dT);

%%
disp('Simulations')

rw_script
thrusters_script
magnetorquers_script
pwsat2
% plot_position
% conversions