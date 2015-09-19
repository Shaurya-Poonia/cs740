clear;
clc;

%Data = GenerateEllipse( 10, 8, 3 , 0, 0, 0 );
%Data = GenerateEllipse( 10, 8, 3 , 2, 3, 30 );
%Data = GenerateHyperbola( 10, 8, 3 , 0, 0, 0 );
Data = GenerateHyperbola( 10, 8, 3 , 2, 3, 30 );
   
%% FindEllipse_Basic : Find ellipse coefficient using basic method
%
%Input: Data -- (n x 2) sized matrix having 2D pointset.
%Output: a -- coefficients of equation
% err -- error code, 0 if no error , -1 if error
n= size(Data,1);
err=0;

X = Data(:,1);
Y = Data(:,2);

  mx = mean(X);
   my = mean(Y);
   sx = (max(X)-min(X))/2;
   sy = (max(Y)-min(Y))/2;
   x = (X-mx)/sx;
   y = (Y-my)/sy;
   
   % Build design matrix
   D = [ x.*x  x.*y  y.*y  x  y  ones(size(x)) ];

   % Build scatter matrix
   S = D'*D;

   % Build 6x6 constraint matrix
   C(6,6) = 0; C(1,3) = -2; C(2,2) = 1; C(3,1) = -2;

   % Solve eigensystem
   [gevec, geval] = eig(S,C);

   % Find the negative eigenvalue
   [NegR, NegC] =  find(real(diag(geval)) < 1e-8 & ~isinf(diag(geval)));


   % Extract eigenvector corresponding to positive eigenvalue
   A = gevec(:,NegC);

   % unnormalize
   a = [
        A(1)*sy*sy,   ...
        A(2)*sx*sy,   ...
        A(3)*sx*sx,   ...
        -2*A(1)*sy*sy*mx - A(2)*sx*sy*my + A(4)*sx*sy*sy,   ...
        -A(2)*sx*sy*mx - 2*A(3)*sx*sx*my + A(5)*sx*sx*sy,   ...
        A(1)*sy*sy*mx*mx + A(2)*sx*sy*mx*my + A(3)*sx*sx*my*my   ...
                - A(4)*sx*sy*sy*mx - A(5)*sx*sx*sy*my   ...
                + A(6)*sx*sx*sy*sy   ...
       ]';
