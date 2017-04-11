function [ x, y, z, F, A ] = delta_getPosition( deltaserial  )
% getDeltaPostion() will get the current position of the robot
%   queries the robot using M114 and then waits for serial response to get
%   the robot's position will block until a response is received

    fprintf(deltaserial, 'M114');
    serialread = fscanf(deltaserial, '%s');
    while isempty(strfind(serialread, 'M114'))
        serialread = fscanf(deltaserial, '%s');
    end
    
    x = fscanf(deltaserial, '%s');
    y = fscanf(deltaserial, '%s');
    z = fscanf(deltaserial, '%s');
    F = fscanf(deltaserial, '%s');
    A = fscanf(deltaserial, '%s');
    
    x = str2double(x(3:end));
    y = str2double(y(3:end));
    z = str2double(z(3:end));
    F = str2double(F(3:end));
    A = str2double(A(3:end));
    fscanf(deltaserial, '%s');

end