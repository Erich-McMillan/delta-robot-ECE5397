function [ connected, imageGrey  ] = detectObjects( imageRGB )
%detectObjects() will find the objects in the image provided
%   To find the objects in the image the image is converted to grey scale
%   and then segmentation is used to remove the background *we assume the
%   object appear well on the background*.
%   to display the objects one shall create an empty image the size of the
%   original image and then write the following
%   >> objects = false(size(origImgGreyScale)); creates the empty image
%   >> objects(connected.PixelIdxList{2}) = true; fills object 2 into emtpy
%   image
%   >> imshow(objects); displays the object


% Convert to greyscale %FUCK the differences between English and American
% spellings of grey<-the correct way to spell it!
imageGrey = rgb2gray(imageRGB);

% Remove background *anything which is white*
imageBin = imageGrey < 230;

% Get object in image
connected = bwconncomp(imageBin, 4);

end

