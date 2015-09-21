% FindEllipse_Basic : Find ellipse coefficient using basic method
%
clear;
clc;

Data = GenerateEllipse( 10, 8, 3 , 0, 0, 0 );
%Data = GenerateEllipse( 10, 8, 3 , 2, 3, 30 );
%Data = GenerateHyperbola( 10, 8, 3 , 0, 0, 0 );
%Data = GenerateHyperbola( 10, 8, 3 , 2, 3, 30 );
   
%% FindEllipse_Basic : Find ellipse coefficient using basic method
%
%Input: Data -- (n x 2) sized matrix having 2D pointset.
%Output: a -- coefficients of equation
% err -- error code, 0 if no error , -1 if error
n= size(Data,1);
err=0;
% a = zeros( n , 6 ); % Follow this dimensions. 
a = zeros( 6,1);
  %assume cofficient dimensions should be 5x1 err = 0;

% Write your code here
% ----------- Algebric Distance Fit--------------

X = Data(:,1);
Y = Data(:,2);

% Distance matrix D
D =[ X.*X ,X.*Y ,Y.*Y,X ,Y ,ones(n,1)];
D
% Constrain matrix C
C = zeros(6,6);
C(1,3)= -2;
C(2,2)= 1;
C(3,1)= -2;
C
% scatter matrix S
S  = D'*D;


%%%%%%%%%%
%
% check if matrix s is positive definite or not 
if(any(eig(s)+1e14<0))
  err = -1;
  disp("error: scatter matrix is not postive definite (has negative eigen value) ");
  return
end

% cholsky decomposition
L= chol(s)';

% c* matrix 
c_star = inv(l)*c*inv(l');

% compute eigen value and eigen vector
[eigvec,eigval] = eig(c_star);

% compute the vector with negative eigen value;
[negr , negc ] = find(real(eigval)<0 & ~isinf(eigval));

a_star = eigvec(:,negc);
a = inv(l')*a_star;
a = a(:,1);

% ezplot(@(x,y) a(1)*(x.^2) +a(2)*x*y+ a(3)*y.^2+ a(4)*x+ a(5)*y+a(6)-1);