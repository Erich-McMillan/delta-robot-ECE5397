function [  centroid, upperleft, lowerright ] = calculateCentroidAndBounds( PixelIdxList, imageSize )
% calculateCentroidAndBounds() will find the mass center and the minimum 
% square box in which the object lies
%   passing the PixelIdxList can be accomplished through the following:
%   cc.PixelIdxList{1}; where cc is a structure containing the objects
%   found in an image
    
    IndicatorFunction = false(imageSize);
    IndicatorFunction(PixelIdxList) = true;
    ravg = 0;
    cavg = 0;
    totobjpix = 0;
    
    % find first moment (i.e. centroid of object)
    for r = 1:1:imageSize(1)
        for c = 1:1:imageSize(2)
            ravg = ravg + r*IndicatorFunction(r,c);
            cavg = cavg + r*IndicatorFunction(r,c);
            totobjpix = totobjpix + IndicatorFunction(r,c);
        end
    end
    
    % find the upper r
    flag = 0;
    for r = 1:1:imageSize(1)
        for c = 1:1:imageSize(2)
            if IndicatorFunction(r,c) == 1
                upperr = r;
                flag = 1;
                break;
            end
        end
        if(flag == 1)
           break; 
        end
    end
    
    % find the upper c
    flag = 0;
    for c = 1:1:imageSize(2)
        for r = 1:1:imageSize(1)
            if IndicatorFunction(r,c) == 1
                upperc = c;
                flag = 1;
                break;
            end
        end
        if(flag == 1)
           break; 
        end
    end
    
    % find the lower r
    flag = 0;
    for r = flip(1:1:imageSize(1))
        for c = flip(1:1:imageSize(2))
            if IndicatorFunction(r,c) == 1
                lowerr = r;
                flag = 1;
                break;
            end
        end
        if(flag == 1)
           break; 
        end
    end
    
    % find the lower c
    flag = 0;
    for c = flip(1:1:imageSize(2))
        for r = flip(1:1:imageSize(1))
            if IndicatorFunction(r,c) == 1
                lowerc = c;
                flag = 1;
                break;
            end
        end
        if(flag == 1)
           break; 
        end
    end
    
    centroid = [ravg/totobjpix, cavg/totobjpix];
    upperleft = [upperr, upperc];
    lowerright = [lowerr, lowerc];
    
end

