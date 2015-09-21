function guessedImage = guessImage( imagename ) 
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image

load('vision.mat');
fprintf('[Loading..]\n');
image = im2double(imread(imagename));
% imshow(image);
fprintf('[Getting Visual Words..]\n');
wordMap = getVisualWords(image, filterBank, dictionary);
h = getImageFeaturesSPM( 3, wordMap, length(dictionary));
distances = distanceToSet(h, train_features);
[~,nnI] = max(distances);
load('../dat/traintest.mat','mapping');
guessedImage = mapping{train_labels(nnI)};
fprintf('[My Guess]:%s.\n',guessedImage);

%figure(1);
%imshow(image);
%title('image to classify')

end

