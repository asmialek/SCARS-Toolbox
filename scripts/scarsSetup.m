h = 6371e3;
G = 6.6743015e-11;
Re = 6356e3;
Me = 5.972e24;

omega = 7.2921150e-5;

% vy = sqrt(G*Me/h);
% v0 = [0 vy 0];

a = h+400e3;
e = 0.0;
incl = deg2rad(20);
% incl = deg2rad(0.00001);
RA = deg2rad(0);
w = deg2rad(0);
TA = deg2rad(0);
mu = 3.986004418e14;

mass = 1.0;

T = 2*pi*sqrt(a^3/(G*Me));

% SIMULATION PARAMETERS
TStart = 0; 
% TFinal = 24*60*60*700;
% dT2 = 24*60*60;
TFinal = 100;
% TFinal = 10*24;
%larget possible tested: 50s
dT2 = 10;
%for PD, dT <= 0.01
t = TStart:dT2:TFinal;
% initEuler = [0 0 0]; % [deg]
% forcesBody = [0 0.0 0];

initYear = 2000;
initDay = 0;
utc = [2000 1 1 12 0 0];
julian = juliandate(utc);
juliansec = juliandate([2000 1 1 12 0 1]) - juliandate([2000 1 1 12 0 0]);
decstart = decyear(utc);
decsec = decyear(2000,1,1,12,0,1) - decyear(2000,1,1,12,0,0);
[r_eci, v_eci] = kep2eci(a, e, RA, incl, w, TA, mu);
% 2453404
% [r_ecef,v_ecef] = eci2ecef([2005 2 2 12 0 0],r_eci,v_eci); % this is from aerorpace tb
[r_ecef,v_ecef] = eci2ecef(utc,r_eci,v_eci); % this is from aerorpace tb
r_lla = ecef2lla(r_ecef'); % this too

% refEuler = [0 0.5 1];
% refVel = [v_b(1) v_b(2)+500 v_b(3)];
refEuler = [0 0 1];
% refEuler = [0 0 0];
forcesBody = [0 0 0];
momentsBody = [0 0 0];
initEuler = [0 0 0]; % [deg]sun_position(:,1)
initMoments = [0 0 0];
initEulerRates = [0.0 0.0 0.0];

dT = 0.1;
cube = sim('cubesat_propagation' ,[0 1]);
v_b = cube.v_b(1,:); % you have to find how it is calculated
dT = dT2;
dT_table = dT2;
refVel = [v_b(1) v_b(2) v_b(3)];

% steps
startTime = 0;
lengthTime = 0;
stepTime = 50;
dtStep = 10;

% open_system('scars_model')
disp('Sun position')
sun_position = getSunPositions(julian, TFinal, dT);

%%
disp('Simulations')

rw_script
thrusters_script
magnetorquers_script
pwsat2
vrml_setup
% plot_position
% conversions