%% This is the solution to part (a) of question 1  to calculate double integration of  exp((x+y)^2)  in the 
% range [0 1] [0 1]

clc;
clear;


CORRECTANSWER = 4.89916;    %calculated from http://www.wolframalpha.com/input/?i=int+int+e%5E%28x%2By%29%5E2+dx+dy+%2C+x%3D0..1%2C+y%3D0..1 
SMALL =0.0000004;   % error  
TOOMANY =4000000;   % upper bound on iteration 
average = 0;




for x= 1:TOOMANY
   u_x = rand;  % uniform random x  
   u_y = rand;  % uniform random y
   average = (average*(x-1) + func(u_x,u_y))/x; 
   if(x==1)
      fprintf("initial guess (only 1 sample) is: %f\n",average); 
   end
   if(abs(average-CORRECTANSWER)<=SMALL)
      break;
   end
end

fprintf("After %d  samples:  average is: %f\n",x,average); 
