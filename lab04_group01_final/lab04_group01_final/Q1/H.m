function [temp] = H (u)
      u_square = u*u;
      x = ((1-u)/u);
      x = x*x;
      x = -x;
      temp = exp(x);
      temp=temp/u_square;
      
endfunction