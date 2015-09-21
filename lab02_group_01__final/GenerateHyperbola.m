function [ HData ] = GenerateHyperbola( n, a, b , x0, y0, theta )
% GenerateHyperbola : Generate n points on Hyperbola. 
%   a --> such that, a will be major axis of Hyperbola
%   b --> such that, b wiil be minor axis of Hyperbola
%   x0 --> X-coordinate of center of Hyperbola
%   y0 --> Y-coordinate of center of Hyperbola
%   theta --> Angle in degree, measured from X-axis to major axis
  a = a/2;
  b = b/2;
  HData = zeros( n , 2 ); %Follow this dimensions
  % Write your code here.  
    mu = (-floor(n/4):1:floor(n/4.0))*.3;
    theta = mod(theta,2*pi);

    X = x0 + (a * cosh(mu) * cos(theta) - b * sinh(mu) * sin(theta));
    Y = y0 + (a * cosh(mu) * sin(theta) + b * sinh(mu) * cos(theta));
    theta = -theta;
    
    X2 = x0 + (a * cosh(mu) * cos(theta) - b * sinh(mu) * sin(theta));
    Y2 = y0 + (a * cosh(mu) * sin(theta) + b * sinh(mu) * cos(theta));
    X = [X 2*x0-X2];
    Y = [Y Y2];
    HData(:,1) = X(1:n);
    HData(:,2) = Y(1:n);
end

