angles = [0,pi/4,pi/2,3*pi/4,pi,5*pi/4,3*pi/2,7*pi/4];

numPointsPerShape = length(angles);
numDimensions = 2;

b = 5;

Test_n1 = 100;
Test_n2 = 100;

n1 = 300;
n2 = 100;

a1_range = [ 0.01 , 1.5 ];
a2_range = [ 1.4 , 4.9 ];

[ error, mean1,Cov1,mean2,Cov2 ] = EllipseModelTesting( a1_range, a2_range , b ,n1 , n2 , angles, Test_n1, Test_n2);

%======= WRITE YOUR CODE ==================================================
% write code to test your function for provided TestEllipseData
% Output label array in variable DemoTestLabels inside DemoTestLabels_<GroupID>.mat.

load('DemoTestData');

DemoTestLabels = predict( DemoTestData, mean1,Cov1 ,mean2,Cov2, n1 , n2 );

save DemoTestLabels_01.mat DemoTestLabels;
%==========================================================================
