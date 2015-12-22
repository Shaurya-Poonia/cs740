

function  Q3(TOGENERATE=1000)
  
  neta=zeros(TOGENERATE,1);  % (1000x1);
  
  % used sorting 
  
  for i = 1:TOGENERATE
    zeta = rand;
    if( zeta<0.3)
       neta(i) = 1;
    elseif(zeta<0.6)
       neta(i) = 3;
    elseif(zeta<0.8)
      neta(i) = 2;
    else
      neta(i) = 4;
     end
  end
  hist(neta,[1,2,3,4],1);   % plot histogram
endfunction
