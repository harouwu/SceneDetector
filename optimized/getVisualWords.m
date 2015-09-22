function [ wordMap ] = getVisualWords( I, filterBank, dictionary )
%GETVISIUALWORD Summary of this function goes here
%   Detailed explanation goes here

rows = size(I, 1);
cols = size(I, 2);
imsize = rows*cols;
wordMap = zeros(imsize, 1);
wmim = zeros(imsize,3);

fr = extractFilterResponses(I, filterBank);
dist = pdist2(dictionary, fr);

mindist = min(dist);

for i =1:imsize
    wordMap(i) = find(dist(:, i) == mindist(i));
    
end

wordMap = reshape(wordMap, rows, cols);

end

