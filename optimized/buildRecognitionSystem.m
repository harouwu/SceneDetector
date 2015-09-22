tic

load('../dat/traintest.mat','train_imagenames','train_labels');
load('dictionary.mat','filterBank','dictionary');

layerNum = 3;
trainSize = length(train_imagenames);
dictionarySize = length(dictionary);
train_features = zeros(dictionarySize*(4^(layerNum)-1)/3, trainSize);

fprintf('Generating features for training images:\n');
for i = 1:trainSize
    load(['../dat/', strrep(train_imagenames{i}, '.jpg', '.mat')]);
    train_features(:,i) = getImageFeaturesSPM(layerNum, wordMap, dictionarySize);
end

fprintf('saving results\n');
save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

toc