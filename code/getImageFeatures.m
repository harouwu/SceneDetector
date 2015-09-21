function [ h ] = getImageFeatures( wordMap, dictionarySize )
%GETIMAGEFEATURES Summary of this function goes here
%   Detailed explanation goes here

h = hist(wordMap(:), 1:dictionarySize);
h = h / norm(h, 1);
h = h';

end

