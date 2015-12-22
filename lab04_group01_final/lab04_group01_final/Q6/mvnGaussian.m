function [ density ] = mvnGaussian( X , Mu , Cov )
% mvnGaussian Calculates Gaussian probability density of given vectors for 
%  given Mu, Cov [without normalizing factor]
%  Input:  X: ( 2n x m ) matrix,m --> number of shapes,n--> number of points in shape 
%          Mu: ( 2n X 1 ) Mean vector.
%          Cov: ( 2n X 2n ) Covariance Matrix

% Regularizing covariance matrix ( Is it needed? )
% ==== Write your Code Here ===============================================
[n,m] = size(X);
density = ones(1,m);

[PC,V] = eig(Cov);
V =diag(V);
B = X-repmat(Mu,1,m);


for i = 1:m
    C = PC'*B(:,i); 
    for j = 1:n
        if(V(j)>1e-10)
          val = -0.5*(C(j)^2)/V(j);
          den = sqrt(2*pi*V(j));
          prob= exp(val)/den;
          density(1,i) = density(1,i)*prob;
        end
    end
    
end


%=============================================
