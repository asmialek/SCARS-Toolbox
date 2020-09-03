function pos = getSunPositions(initial_time, simulation_time, dT)
    pos = [];
    juliansec = juliandate([2000 1 1 12 0 1]) - juliandate([2000 1 1 12 0 0]);
    if simulation_time <= 24*60*60
        pos = [0, planetEphemeris(initial_time, 'Earth', 'Sun');
               simulation_time, planetEphemeris(initial_time+simulation_time*juliansec, 'Earth', 'Sun')];
    elseif dT < 24*60*60
        for time = 0:24*60*60:simulation_time
            disp(100*time/simulation_time)
            pos = [pos; time, planetEphemeris(initial_time+time*juliansec, 'Earth', 'Sun')];
        end
    else
        for time = 0:dT:simulation_time
            disp(100*time/simulation_time)
            pos = [pos; time, planetEphemeris(initial_time+time*juliansec, 'Earth', 'Sun')];
        end
    end
end
