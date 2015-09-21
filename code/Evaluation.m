tic 

load('../dat/traintest.mat','test_imagenames','test_labels','mapping');
load('vision.mat');
classNum = 8;
C = zeros(classNum);
testSize = size(test_labels, 2);
for k = 1:testSize
    i = test_labels(k);
    myGuess = guessImage(['../dat/', test_imagenames{k}]);
    index = strfind(mapping, myGuess);
    
    j = find(not(cellfun('isempty', index)));
    
    C(i,j) = C(i,j) + 1;
end

rate = trace(C) / sum(C(:)) * 100;
fprintf('accuracy=%d%',rate);
toc