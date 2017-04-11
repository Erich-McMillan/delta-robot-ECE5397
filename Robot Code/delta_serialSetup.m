function [ deltaserial ] = delta_serialSetup( )
% serialSetup() opens and queries the user to select a comm port to connect 
% to them reads past the 'help' output displayed by the delta
%   use this function before reading or writing anything to the delta
%   controller

    commpath = input('Enter the path to the delta controller:', 's');
    deltaserial = serial(commpath, 'Baudrate', 57600);
    fopen(deltaserial);
   
    for i = 1:1:15
        % scan past stupid shit
        fscanf(deltaserial, '%s'); 
    end

end









