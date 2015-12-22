%% This is the solution to part (a) of question 1  to calculate integration of  exp(-x^2)  in the 
% in the interval [0,inf]

% we have not done it directly we have change the variable in the function 
%  by putting  let  u = 1/(1+x)
%                   du = -1/(1+x)^2 dx
%                    dx = -(1+x)^2 du
%            function becomes  (e-((1-u)/u)^2)/u^2 with respect to du in
%            the interval  0 to 1 
%            now we can take the  uniform distribution as our underline pdf



clc;
clear;
CORRECTANSWER = sqrt(pi)/2.0;        % calculated using  http://www.wolframalpha.com/input/?i=int+e%5E-x%5E2+dx%2C+x%3D0..infinity&lk=4&num=2
% also taken help from this http://math.stackexchange.com/questions/1200443/evaluating-difficult-monte-carlo-integration-in-r
SMALL =0.000004;       % threshold error
 
TOOMANY =4000000;      % max number of iteration
average = 0;

for x= 1:TOOMANY        
   sample = rand;
   average = (average*(x-1) + H(sample))/x; 
   if(x==1)
      fprintf("initial guess (only 1 sample) is: %f\n",average); 
   end
   if(abs(average-CORRECTANSWER)<=SMALL)
      break;
   end
end

fprintf("After %d  samples:  average is: %f\n",x,average); 



% another method  but dropped it due to mathmetical manupulation
%ROOT_PI = sqrt(pi)/2;
%
%TOOMANY =100;
%sum = 0;
%for x= 1:TOOMANY
%   sample = abs(randn);
%   sum = sum + ROOT_PI; 
%end
%
%average = sum/TOOMANY;