function [ meanData, CovData ] = getGaussianModel(Data)
%getGaussianModel: gives Gaussian parameters
% Input:    
%       Data: Matrix with column as feature vector (2n x m ) ,m --> number of shapes,n--> number of points in shape 
% Output:
%       meanData = Mean of given Data. ( 2n x 1 ) row vector)
%       CovData  = Covariance of given Data. (2n x 2n ) matrix



%======= WRITE YOUR CODE ==================================================
% write your code to calculate estimated gaussian distribution parameters
[n,m] = size(Data);
meanData = mean(Data,2);   %get columwize means
CenteredData  = Data-repmat(meanData,1,m);
CovData = CenteredData*CenteredData';
CovData=CovData./(m-1); 
% =========================================================================
end
