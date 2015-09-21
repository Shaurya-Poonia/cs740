function [ EData ] = GenerateEllipse( n, a, b , x0, y0, theta )
% GenerateEllipse : Generate n points on Ellipse. 
%   a --> such that, a will be major axis of Ellipse
%   b --> such that, b wiil be minor axis of Ellipse
%   x0 --> X-coordinate of center of ellipse
%   y0 --> Y-coordinate of center of ellipse
%   theta --> Angle in radians, measured from X-axis to major axis

  a = a/2;
  b = b/2;
 
  EData = zeros( n , 2 ); %Follow this dimensions
  % Write your code here.
  % assumption a will always be greater than b as said a is major axis 
    theta = mod(theta,2*pi);
    sintheta = sin(theta);
    costheta=  cos(theta);
    
    % alpha is list of angles
    alpha = linspace(0, 2*pi, n+1)';
    
    sinalpha = sin(alpha);
    cosalpha = cos(alpha);

    %   rotating by alpha and translating by x0 y0;   
    X = x0 + (a * cosalpha * costheta - b * sinalpha * sintheta);
    Y = y0 + (a * cosalpha * sintheta + b * sinalpha * costheta);

    EData(:,1) = X(1:n);
    EData(:,2) = Y(1:n);
end

