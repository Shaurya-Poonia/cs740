%% Program which finds page ranks of pages in "sink" graph %%%

%inputFile = "in.txt";
arg_list = argv ();
inputFile = arg_list{1};

c = str2double(arg_list{2});
data = dlmread (inputFile);
%c  = 0.15;
% your code goes here


%% read DATA from file
data = dlmread (inputFile);
n = size(data,1);
A = zeros(n);

%construct Adjancy matrix with coloumn sum =1
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


%% construct C matrix %% normalize every row


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

% Construct M matrix  
M = C + (c/n)*ones(n);

% calculate eigenvalues and eigenvector
[eigvec,eigval] = eig(M);

%eigenvector correspond to eigenvalues(d) look for
d = 1.0+c;


% find the eigvector correspond to d
eigval = real(eigval);
[x,y] = find(abs(eigval-d)<=1e-6);
value_vector = eigvec(:,y);
x = size(value_vector,2);
for ev = 1: x 
  %this vector should be positive
   if sum(value_vector(:,ev)<0)==n
    value_vector(:,ev) = -value_vector(:,ev);
   end
  disp(' possible rankings:');
  % sorting the value 
  [value,RANK] = sort(value_vector(:,ev),"descend");

  RankofPage = zeros(n,1); % contains  rank of every page

  % calculate the actual Rank 
  counter =1;
  z = -1;
  add =0;
  for i = 1:n
     if(abs(value(i)-z)>=1e-12)
        counter = counter +add;
        z = value(i);
        RankofPage(RANK(i)) = counter;
        add=1;
     else
        RankofPage(RANK(i)) = counter;
        add = add+1;
     end
  end

  %% print only top 20 pages
  disp("Top 20(n) pages: ");
  disp("    ID  RANK ");  
  TOP = [ RANK(1:n), RankofPage(RANK(1:n))];
  TOP20= TOP(1:min(20,n),:);
  disp(TOP20);
end