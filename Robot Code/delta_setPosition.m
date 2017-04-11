function [] = delta_setPosition( deltaserial, x, y, z ) 
% setDeltaPosition() will set the robot's x y z position
%   uses G0 to set the robot position will call getDeltaPosition() to check
%   if the robot has reached to position which will block the function call
%   until the robot has reached the desired position. x y and z can be
%   vectors allowing a complete path to be specified which will be executed
%   in order at the beginnings of the list x, y and z MUST be the same
%   lengths

    if length(x) ~= length(y) && length(x) ~= length(z)
       print('error in sizes of the lists provided to setDeltaPosition');
       exit 
    end

    for i = 1:1:length(x)
        command = sprintf('G0 X%f Y%f Z%f', x(i), y(i), z(i));
        fprintf(deltaserial, command);
        while [x(i) y(i), z(i)] ~= delta_getPosition( deltaserial ) 
        end
    end

end