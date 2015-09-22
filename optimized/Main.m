tic

fprintf('Compute Dictionary...\n');
computeDictionary();

toc

tic

fprintf('Batch To Visual Words...\n')
batchToVisualWords();

toc

tic

fprintf('Build Recognition System...\n')
buildRecognitionSystem();

toc

tic

fprintf('Evaluate...\n')
Evaluation();

toc