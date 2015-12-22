function [Wasted] = q5(TOGENERATE=1000)
    data = [];
    comp = [];
    dPdf = [];
    Range = 5;   % scale the pdf 
    c = 2;
    TOTAL =0;
    n = TOGENERATE;
    while (n>0)  
      
        X  = rand*Range; % uniform random numbers between 0 and 5
        fX = f(X); % desired pdf
        pX = genY(X/Range);   % pX is pdf of comparison function
        zeta = rand;  
        comp = [comp pX];
        dPdf = [dPdf fX];
        if zeta < fX/(c*pX) % accept
            data = [data X];
            n = n-1; 
        end
        TOTAL = TOTAL+1;
    end
    figure(1);
    hist(data,70,1);
    Wasted  = TOTAL -TOGENERATE;
    Wasted = Wasted*100/TOTAL;
    fprintf("Wasted = %d%s\n ",Wasted,"%");
end

  

function [y] =  f(x)      % f(x) 
    y = 2*sqrt(x/pi)*exp(-x);
end



function y =  genY(x)      % g(X)
    y = (-3/2)*log(1-x);
 
end
