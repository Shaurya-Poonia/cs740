function [error,mean1,Cov1,mean2,Cov2] = EllipseModelTesting( a1_range, a2_range , b ,n1 , n2 , angles, Test_n1, Test_n2)
%EllipseModelTesting: Ellipse shape model testing. where ellipse data
%                     are on basic ellipse of form 
%                     ( x^2 / a^2 ) + ( y^2 / b^2 ) = 1
% Input:
%       a1_range = range of 'a' for class1 ellipse data, it is of the form
%                   [a_min,a_max].
%       a2_range = range of 'a' for class2 ellipse data.
%       b        = value of 'b' for both classes.
%       n1       = number of shapes in class1.
%       n2       = number of shapes in class2.
%       angles   = set of polar angles for points on ellipse shape
%                  (in Radians).(1 x n ) row vector
%        Test_n1 = number of shapes in class1 in Test data.
%        Test_n2 = number of shapes in class2 in Test data.
% Output:
%       error   = error value, which is number of misclassified test samples.
%       mean1    = mean shape vector of class1 ( 2n x 1 ) dimension, n--> number of points in shape 
%       Cov1     = shape covariance of class1  ( 2n x 2n ) dimension
%       mean2    = mean shape vector of class2 ( 2n x 1 ) dimension
%       Cov2     = shape covariance of class2  ( 2n x 2n ) dimension


%===== WRITE YOUR CODE ====================================================
% generate UNIFORMLY distributed 'a' for both classes in given range

a1_min = a1_range(1,1);
a1_max = a1_range(1,2);

a2_min = a2_range(1,1);
a2_max = a2_range(1,2);


diff1 = a1_max-a1_min;

diff2 = a2_max-a2_min;

step1 = diff1/(n1-1);
step2 = diff2/(n2-1);

a1_train_list = [a1_min:step1:a1_max];

a2_train_list = [a2_min:step2:a2_max];


%==========================================================================

% Generate training data for both classes.
% output it in .mat files named, training_<groupID>.mat (in training_class1 and training_class2 variables)



training_class1 = GenerateEllipseData(a1_train_list,b,angles);

training_class2 = GenerateEllipseData(a2_train_list,b,angles);

%plotting code
%m = size(angles,2);
%m = m*2;
%x = training_class2(1:2:m,:);
%y = training_class2(2:2:m,:);
%plot(x,y);axis equal;


save('training_01.mat','training_class1','training_class2');

% Estimate gaussian probability model for both clases




[mean1,Cov1] = getGaussianModel(training_class1);
[mean2,Cov2] = getGaussianModel(training_class2);



%========== WRITE YOUR CODE ===============================================
% write code to generate test data for both classes.
% generate RANDOMLY distributed 'a' for both classes in given range.
% output it in .mat files named, testing_<groupID>.mat (in testing_class1 and testing_class2 variables)



a1_test_list = a1_min+rand(1,Test_n1)*diff1;
a2_test_list = a2_min+rand(1,Test_n2)*diff2;


testing_class1 = GenerateEllipseData(a1_test_list,b,angles);
testing_class2 = GenerateEllipseData(a2_test_list,b,angles);


save('testing_01.mat','testing_class1','testing_class2');


%==========================================================================


% Classify the generated test data using Bayes classfier.

%========== WRITE YOUR CODE ===============================================
% write code to calculate error in classification.
error = 0; % error value of classification


y1 = predict( testing_class1, mean1,Cov1 ,mean2,Cov2, n1 , n2 );

y2 = predict( testing_class2, mean1,Cov1 ,mean2,Cov2, n1 , n2 );
error=error+ sum(y1~=1);
error=error+ sum(y2~=2);

%==========================================================================
end
