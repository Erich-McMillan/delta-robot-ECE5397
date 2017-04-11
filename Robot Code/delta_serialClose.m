function [] = delta_serialClose( deltaserial )
% serialClose() properly terminates serial connection with the delta
%   call this function when you are done using/communicating with the delta
%   robot

    fclose(deltaserial);
end