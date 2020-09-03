fid = fopen('test.e', 'wt');

data = scars_out.SatStates.X_ECEF.Data;
vata = scars_out.SatStates.V_ECEF.Data;
time = scars_out.SatStates.X_ECEF.Time;

preamble = {'stk.v.4.3'
'BEGIN Ephemeris'
['NumberOfEphemerisPoints ' int2str(size(data, 1))]
'ScenarioEpoch           1 Jan 2000 12:0:0.0000'
'InterpolationOrder      5'
'DistanceUnit            Meters'
'CentralBody             Earth'
'CoordinateSystem        Fixed'
'EphemerisTimePosVel'};

utc = [2000 1 1 12 0 0];

n = 1;
    
for i = 1:size(preamble,1)
    fprintf(fid, '%s\n', preamble{i});
end

for i = 1:n:size(data, 1)
    fprintf(fid, '%s ', [num2str(time(i)) ' ']);
    fprintf(fid, '%s ', [num2str(data(i,1)) ' ' num2str(data(i,2)) ' ' num2str(data(i,3))]);
    fprintf(fid, '%s\n', [num2str(vata(i,1)) ' ' num2str(vata(i,2)) ' ' num2str(vata(i,3))]);
end
fprintf(fid, 'END Ephemeris');

fid = fopen('test.a', 'wt');

data = scars_out.SatStates.Euler_NED.Data;
time = scars_out.SatStates.Euler_NED.Time;
 
preamble = {'stk.v.4.3'
'BEGIN Attitude'
['NumberOfAttitudePoints ' int2str(size(data, 1))]
'ScenarioEpoch           1 Jan 2000 12:0:0.0000'
'InterpolationOrder      5'
'CentralBody             Earth'
'CoordinateSystem        Fixed'
'AttitudeTimeEulerAngles'};

for i = 1:size(preamble,1)
    fprintf(fid, '%s\n', preamble{i});
end

for i = 1:n:size(data, 1)
%     DCM = scars_out.SatStates.NED2Body.Data(:,:,i);
%     DCM = scars_out.SatStates.ECEF2NED.Data(:,:,i);
%     bata = rad2deg((DCM\data(i,:)')');
    bata = rad2deg(data(i,:));
%     bata = [ 0 0 0 ];
    fprintf(fid, '%s ', [num2str(time(i)) ' ']);
    fprintf(fid, '%s\n', [num2str(bata(1)) ' ' num2str(bata(2)) ' ' num2str(bata(3))]);
%     fprintf(fid, '%s\n', [num2str(bata(2)) ' ' num2str(bata(3)) ' ' num2str(bata(4)) ' ' num2str(bata(1))]);
end
fprintf(fid, 'END Attitude');

fclose('all');