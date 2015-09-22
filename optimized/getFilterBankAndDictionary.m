function [ filterBank, dictionary ] = getFilterBankAndDictionary( imagenames )
%GETFILTERBANKANDDICTIONARY Summary of this function goes here
%   Detailed explanation goes here
alpha = 50;
k = 200;
filterBank = createFilterBank();
filterResponses = zeros(alpha*size(imagenames, 1), 3*size(filterBank, 1));

for i=1:length(imagenames)
    fprintf('Proceesing: %s\n', imagenames{i});
    Im = imread(imagenames{i});
    I = Im;
    if size(I, 3) == 1
        I = cat(3, Im, Im, Im);
    end
    
    %Get the filter Response of the image
    normalFilterResponse = extractFilterResponses(I, filterBank);
    
    %Sample the alpha pixels
    pixelnum = numel(I(:,:,1));
    p = randperm(pixelnum, alpha)';
    
    %Try to use SURF here
    %randomPixels = normalFilterResponse(p, :);
    
    surf_points = detectSURFFeatures(I(:,:,1));
    strongPoints = surf_points.selectStrongest(alpha);
    surf_index = round(strongPoints.Location);
    
    if not(isempty(surf_index))
        p(1:length(surf_index)) = (surf_index(:,2)-1).*size(I,2) + surf_index(:,1);
    end
    
    %Put the sample pixels into the 
    startIdx = (i-1)*alpha + 1;
    endIdx = startIdx + alpha - 1;
    filterResponses(startIdx:endIdx,:) = normalFilterResponse(p, :);
end

[~, dictionary] = kmeans(filterResponses, k, 'EmptyAction', 'drop');

end
