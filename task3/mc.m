%% Program which finds page ranks of pages in "sink" graph %%%

inputFile = "in.txt";
%arg_list = argv ();
%inputFile = arg_list{1};

%c = str2double(arg_list{2});
data = dlmread (inputFile);
c  = .15;
% your code goes here


%% read DATA from file
data = dlmread (inputFile);
n = size(data,1);
A = zeros(n);
%construct Adjancy matrix
[row,col] = size(data);
for i = 1:row
  for j = 1:col
    x =data(i,j); 
    if x!=0
      A(i,x)=1;
    end
  end
end

%remove self loops
A = A - diag(diag(A));

%% construct C matri

%% normalize every row


C = zeros(row,row);
for j = 1:n
    outdegree = sum(A(j,:)>0);  
    if outdegree >0
      for i = 1:n
        if(A(j,i)>0 )
            C(i,j) = 1/outdegree;
        end   
      end
    elseif outdegree==0
      C(:,j) = 1/n;
    end
end
M = C + (c/n)*ones(n);
[eigvec,eigval] = eig(M);
d = 1.0+c;
eigval = real(eigval);
[x,y] = find(abs(eigval-d)<=1e-6);
Rank_vector = eigvec(:,y)