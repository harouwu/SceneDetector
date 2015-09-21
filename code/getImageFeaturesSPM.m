function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
%function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
%extract the histograms of visual words of the given image in a
%multi-resolution representation by spatial pyramid matching
%Inputs:
%   layerNum: the number of layers in the spatial pyramid
%   wordMap: a H * W image containing the IDs of the visual words
%   dictionarySize: the maximum visual word ID
%Outputs:
%   h: L1 normalized histogram of visual words

%create the result vector
dim = dictionarySize * (4 ^ (layerNum) - 1)/3;
h = zeros(dim, 1);

%get the histogram for the finest layer
L = layerNum - 1;
cellsize = 2 ^ L;
rowsize = floor(size(wordMap,1) / cellsize);
colsize = floor(size(wordMap,2) / cellsize);

%record the current size of h
current_size = 0;
uplevel_index = 0;

for i = 1:cellsize
    for j = 1:cellsize
        cell = wordMap(1+(i-1)*rowsize:i*rowsize, 1+(j-1)*colsize:j*colsize);
        cellNum = (i-1)*(2^L) + j;
        current_size = cellNum*dictionarySize;
        h(1+(cellNum-1)*dictionarySize: current_size, 1) = getImageFeatures(cell, dictionarySize) .* 0.5;
        
    end
end

%get the histogram for higher layer
for i = 1:L
    layer = L - i;
    
    %calculate the weight for each layer
    if layer == 0
        weight = 2 ^ (layer - L);
    else
        weight = 2 ^ (layer - L -1);
    end
    
    layersize = 2 ^ layer;
    for j = 1:layersize
        for k = 1:layersize
            %get the index for four blocks
            lup_index = dictionarySize*(4*(j-1)*layersize + 2*(k-1)) + uplevel_index;
            rup_index = lup_index + 1*dictionarySize;
            ldw_index = lup_index + 2*layersize*dictionarySize;
            rdw_index = ldw_index + 1*dictionarySize;
            
            %calculate histogram
            current_size;
            weight;
            h(1+current_size:dictionarySize+current_size) = (h(1+lup_index:lup_index+dictionarySize) + h(1+rup_index:rup_index+dictionarySize) + ...
            h(1+ldw_index:ldw_index+dictionarySize) + h(1+rdw_index:rdw_index+dictionarySize)) .* weight;
            current_size = current_size + dictionarySize;
            
        end
    end
    
    uplevel_index = uplevel_index + dictionarySize * (2 ^ (layer+1))^2;
end

h = h / norm(h,1);
    
end
            
    