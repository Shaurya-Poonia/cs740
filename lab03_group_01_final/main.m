%% read DATA from file
data = dlmread ("in.txt");
%% take value of C from user

c = input("Enter the value of C : ");

%% construct C matrix
[row,col] = size(data);
C = zeros(row,row);
for j = 1:row
    outdegree = sum(data(j,:)>0);  
    for k = 1:outdegree
        %outdegree of jth node

        i = data(j,k);
        C(i,j) = 1/outdegree;
        
    end
end
eigval = eig(C);
t=max(eigval);