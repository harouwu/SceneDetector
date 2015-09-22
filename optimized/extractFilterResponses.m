function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses


%Convert input Image to Lab
Im = I;
if size(I, 3) == 1
    I = cat(3, Im, Im, Im);
end
doubleI = double(I);
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);

%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);


%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===


for i=0:length(filterBank)-1
    filter = filterBank{i+1};
    filterResponses(:,i*3+1) = reshape(imfilter(L, filter, 'conv'), pixelCount, 1);
    filterResponses(:,i*3+2) = reshape(imfilter(a, filter, 'conv'), pixelCount, 1);
    filterResponses(:,i*3+3) = reshape(imfilter(b, filter, 'conv'), pixelCount, 1);
end


end
