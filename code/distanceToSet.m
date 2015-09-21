function [histInter] = distanceToSet(wordHist, histograms)
%function [histInter] = distanceToSet(wordHist, histograms)
%This function will use histogram intersection similarity to find the
%nearest instance of image in the training data.
%Inputs:
%   wordHist: image represented by a vector of histograms of visual words.
%   histograms: a matix containing T features from T training samples
%   concatenated along the columns
%Outputs:
%   histInter:the histogram intersection similarity between wordHist and
%   each training sample as in histograms in a 1 * T vector

histInter = sum(bsxfun(@min, wordHist, histograms));

end