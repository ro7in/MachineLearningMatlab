function [XX,newX,T,meanValue] = pca_ro(X,dim)
%Every row of X is a sample
%T the coresponding eigenvector when reducing the dimension
%meanValue  mean vector of X
%dim the dimension that desired to reduce

%setp 1:Subtract the mean
meanValue = ones(size(X,1),1) * mean(X);
X = X - meanValue;

%step 2:Calculate the covariance matrix
C = cov(X);

%step 4:Calculate the eigenvectors and eigenvalues
[V,D]=eig(C);

%Step 5:Sort and extract eigenvectors
[~,order]=sort(diag(-D));
V=V(:,order);
T=V(:,1:dim);

%Reconstruct data
newX=X*T;
XX = newX*T'+meanValue;
gray02 = imagesc(reshape(XX(2,:),38,50));
%gray01 = imagesc(reshape(X(2,:),38,50));
end