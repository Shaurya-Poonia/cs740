function [ Data ] = GenerateEllipseData( a_list , b , angles )
%GenerateEllipseData Generate Ellipse pointset data for given inputs
%  Inputs : a_list =  list of a's in basic ellipse equation (x^2/a^2 + y^2/b^2 = 1), (1 x m ) row vector, m --> number of shapes.
%           b      =  'b' in basic ellipse equation
%           angles =  set of polar angles for points (in Radians). (1 x n ) row vector, n--> number of points in shape 

% output : Data = (2n x m ) dimensional matrix 


% =================== Write your code here ================================
% write ellipse data vector generation code.
  m = size(a_list,2);
  n = size(angles,2);
  Data = zeros(2*n,m);           % 
  angle90 = pi/2;
  angle270 = 3*pi/2;
  angle360 = 2*pi;
      
  b_square = b*b;
  for i = 1:m
      a = a_list(1,i);   % get a
      a_square = a*a;   % calculate a^2
      for j = 1:n
          
          theta = mod(angles(j),angle360);    % get angle
          %theta
          tan_theta = tan(theta);  % tan(theta);
          %tan_theta
          tan_theta_square = tan_theta*tan_theta;   %tan(theta)^2
          num = a*b;                  %numerator
          den = sqrt(b_square+a_square*tan_theta_square);
          x = num/den;  
          y = x*tan_theta;
         %x,y
          if(theta>angle90 && theta<= angle270)
              Data(2*j-1,i) = -x;
              Data(2*j,i)   = -y;
          else
              Data(2*j-1,i) = x;
              Data(2*j,i)   = y;
          end
             
      end
  end
% =========================================================================
end
