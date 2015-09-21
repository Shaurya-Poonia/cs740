%%%%%%%%% Main Program File %%%%%%%%%%
% Write your Main script here.
% It should contain following subsections.
% 1. generation of Data
% 2. Estimate ellipse using basic method and plot ellipse on Data.
% 3. Estimate ellipse using alternate method and plot ellipse on Data.


%% Generate Data
clc;
clear;


% Write your code here.
   EData1 = GenerateEllipse( 10, 8, 3 , 0, 0, 0 );
   %figure(1);scatter(EData1(:,1),EData1(:,2)); axis equal;
   
   EData2 = GenerateEllipse( 10, 8, 3 , 2, 3, 30 );
   %figure(2);scatter(EData2(:,1),EData2(:,2));axis equal;
   
   HData3 = GenerateHyperbola( 10, 8, 3 , 0, 0, 0 );
   %figure(3);scatter(HData3(:,1),HData3(:,2));axis equal;
     
   HData4 = GenerateHyperbola( 10, 8, 3 , 2, 3, 30 );
   %figure(4);scatter(HData4(:,1),HData4(:,2));axis equal;
   
%% Add Gaussian Noise to Data
  mu = [0 0 ];
  sigma = [.3 0 ; 0 .3];
  R = chol(sigma);
  n = size(EData1,1);
  
  noise = repmat(mu,n,1)+ randn(n,2)*R;
  EData1_noisy = EData1+ noise;
  %figure(5);scatter(EData1_noisy(:,1),EData1_noisy(:,2));axis equal;
   
  n = size(EData2,1);
  noise = repmat(mu,n,1)+ randn(n,2)*R;
  EData2_noisy = EData2+ noise;
  %figure(6);scatter(EData2_noisy(:,1),EData2_noisy(:,2));axis equal;
   
  n = size(HData3,1);
  noise = repmat(mu,n,1)+ randn(n,2)*R; 
  HData3_noisy = HData3+ noise;
  %figure(7);scatter(HData3_noisy(:,1),HData3_noisy(:,2));axis equal;
  
  
  n = size(HData4,1);
  noise = repmat(mu,n,1)+ randn(n,2)*R;
  HData4_noisy = HData4+ noise;   
  %figure(8);scatter(HData4_noisy(:,1),HData4_noisy(:,2));axis equal;
  
    
  %% Estimate Ellipse using basic method
  % Write your code here.
  %% Estimate Ellipse using alternate method
% Write your code here.

   disp("Choose A method");
   disp("1 Basic Method");
   disp("2 Alternate Method");
   x = input("METHOD : ");
   
   disp("Choose A DataSet Press");
   disp("1 EData1");
   disp("2 EData2");
   disp("3 HData3");
   disp("4 HData4");
   disp("5 EData1_noisy");
   disp("6 EData2_noisy");
   disp("7 HData3_noisy");
   disp("8 HData4_noisy");
   y = input("SELECT DATASET : (Default EData1) : ");
   switch (y)
  case 1
   Data = EData1
  case 2
    Data = EData2
  case 3
   Data = HData3
  case 4
    Data = HData4
  case 5
   Data = EData1_noisy
  case 6
    Data = EData2_noisy
  case 7
   Data = HData3_noisy
  case 8
    Data = HData4_noisy
  otherwise
    Data = EData1
  endswitch
    if(x==1)
      [a,err] = FindEllipse_Basic(Data);
      err
      if(err !=0)
        disp("Can  not fit ellipse");
      else
        Cofficient_matrix = a'
        figure(2);
        title ("generated Data");
        scatter(Data(:,1),Data(:,2));axis equal;
      end
    end
   if(x==2)
       [a,err] = FindEllipse_Alternate(Data);
      err
      if(err !=0)
         disp("Can  not fit ellipse");
      else
        Cofficient_matrix = a'
         figure(2);
         title ("generated Data");
        scatter(Data(:,1),Data(:,2));axis equal;
      end
   end
   if(x<=0 & x>2)
     disp('Wrong Method Selected');
   end