function [ a , err ,C_Star] = FindEllipse_Basic( Data )
  % FindEllipse_Basic : Find ellipse coefficient using basic method
  %
  %Input: Data -- (n x 2) sized matrix having 2D pointset.
  %Output: a -- coefficients of equation
  % err -- error code, 0 if no error , -1 if error
  n= size(Data,1);
  err=0;

  % a = zeros( n , 6 ); % Follow this dimensions. 
  a = zeros( 6,1);
    %assume cofficient dimensions should be 5x1 err = 0;

  % Write your code here
  % ----------- Algebric Distance Fit--------------
  % get X and Y cordinates
    X = Data(:,1);
    Y = Data(:,2);
  
  %Distance_matrix  
   D = [ X.*X  X.*Y  Y.*Y  X  Y  ones(size(X))];

  % Constrain matrix C
  C = zeros(6,6);C(1,3)= -2;C(2,2)= 1;C(3,1)= -2;

  % Make scatter matrix
  S = D'*D;  
  
  % Check if scatter matrix is cholesky Decomposable
  [R,P]= chol(S);
  if (P!=0)
     err = -1;
      disp('Scatter matrix is not positive definite');
    return; 
  end
  % Get L matrix 
  L = R';
  
  % compute C_Star
  C_Star = inv(L)*C*inv(L');
  [eigvec,eigval] = eig(C_Star);
  
  %find indexs with negative eigenvalue
  [NegR , NegC ] = find(real(eigval)<0 & ~isinf(eigval));
  
  % find u vector
  u = inv(L')*eigvec(:,NegC);
  
  %% possiblity of error here
  if(size(NegC)==0)
    err = -1;
    disp('No negative eigenvalue corresponds to C_Star No fit possible ');
    return;
  end
  %% take first u only
  u = u(:,1);
  % calculate alpha
  alpha = u'*C*u;
  alpha = sqrt(-1/alpha);
  % if alpha is not real Then no fit found
  if(imag(alpha)!=0)
    err = -1;
    disp('can not fit ellipse(alpha value is not real) ')
    return;
   end
   
  % final a matrix   
  a = alpha*u;
  [cx ,cy, r1, r2, theta_radian ,theta_degree ]=findparameters(a);
  
  figure(1);clf;
  title ("Ellipse Fit");
  hold on;
  scatter(X,Y);
  fitted_DATA = GenerateEllipse(1000,r1,r2,cx,cy,theta_radian);
  plot(fitted_DATA(:,1),fitted_DATA(:,2),'Color','Red');
  axis equal;
  hold off;
  
end
