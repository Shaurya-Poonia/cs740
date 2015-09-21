function [ a , err ] = FindEllipse_Alternate( Data )
  % FindEllipse_Alternate : Find ellipse coefficient using alternate method
  %
  %  Input: Data -- (n x 2) sized matrix having 2D pointset.
  % Output: a -- coefficients of equation
  %        err -- error code, 0 if no error , -1 if error

  % a = zeros( n , 6 ); % Follow this dimensions. 
  a = zeros( 1 , 6 );  %assume cofficient dimensions should be 1x6

  err = 0;
  X = Data(:,1);
  Y = Data(:,2);
  
  %Distance_matrix  
  D = [ X.*X  X.*Y  Y.*Y  X  Y  ones(size(X))];

  % find  D1 and D2
  D1 = D(:,1:3);
  D2 = D(:,4:6);

  % Constrain matrix C
  C = zeros(6,6);C(1,3)= -2;C(2,2)= 1;C(3,1)= -2;
  
  %find C1 matrix
  C1 = C(1:3,1:3);
  
  % Build scatter matrices
  S1 = D1'*D1;
  S2 = D1'*D2;
  S3 = D2'*D2;
  
  %calculate Z matrix  
  Z  = -inv(S3)*S2';
  
 % calculate scater_final_matrix
 
  S = S1+S2*Z;
 
 %M matrix is M = C^-1 *S in eq C^-1 *S*a  = lamda*a
  M = inv(C1)*S;
  
 % find eigen values of M
 [eigvec,eigval] =eig(M);
 
 % check for the condition  4*a*c - b^2>0
 
 cond = 4*eigvec(3,:).*eigvec(1,:)-eigvec(2,:).^2;
 
 %% possible error condition not met
 a1 = eigvec(:,find(cond>0));
 if(size(a1,1)==0)
    err = -1;
    disp("4*a*c- b.^2 >0 condition not met(cannot fit data poitns) " );
    return 
 end;

 a1 = a1(:,1);
  % get back a2 (a2 = Z*a1)
 a2 = Z*a1;
 %final a  = (a1;a2)
  a = [a1;a2];
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
