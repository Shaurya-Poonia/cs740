function[ y ] = predict( TestData , mean1,Cov1 ,mean2,Cov2, n1 , n2 )
%predict: predict class label for given TestData
% [MGP] Please indicate dimension of input and output (wherever applicable)
% Input: 
%       TestData = matrix with each column vector as feature. (2n x m ), n--> number of points in shape, m --> number of shapes.
%       mean1    = mean shape vector of class1 (2n x 1 ) column vector 
%       mean2    = mean shape vector of class2 (2n x 1 ) column vector 
%       Cov1     = shape covariance of class1 (2n x 2n ) matrix
%       Cov2     = shape covariance of class2 (2n x 2n ) matrix
%       n1       = number of training samples in class1
%       n2       = number of training samples in class2
% Output:
%       y        = list of class labels for Test Data (1 x m )

y = zeros(1,size(TestData,2));% Follow this dimension strictly.   (1xm)

%======== Write your code =================================================
% write code to predict labels of given test data

[density1] = mvnGaussian(TestData,mean1,Cov1);      % (1 x m)
[density2] = mvnGaussian(TestData,mean2,Cov2);      %   (1 x m)
m =size(y,2);
for i = 1:m
    if(density1(i)>density2(i))
           y(1,i) = 1;
    else
           y(1,i) = 2;
    end

end
%==========================================================================
end
