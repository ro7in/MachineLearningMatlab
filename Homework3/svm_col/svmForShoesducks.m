function [X] = svmForShoesducks (kernelType)
X = load('shoesducks.mat');
n = size(X,1);
end

%Split dataset
idxtrain = randsample(n, n/2);
idxtest = setdiff(1:n, idxtrain);
trnX = X(idxtrain, : );
tstX = X(idxtest, : );
trnY = Y(idxtrain, : );
tstY = Y(idxtest, : );

%Classify using polynomials
d_max = 5;
err_d = zeros(1, d_max);
global p1;

for d=1:d_max
    p1 = d;
    % Training
    [nsv, alpha, bias] = svc(trnX, trnY, 'poly', inf);
    %Predict
    predictedY = svcoutput(trnX, trnY, tstX, 'poly' ,alpha ,bias);
    %Compute test error
    err_d(d) = svcerror(trnX ,trnY ,tstX ,tstY ,'poly', alpha ,bias);
end
%plot error vs polynomial degree
f = figure(1);
clf(f);
plot(1:d_max ,err_d);
print (f , '-depsc', 'poly.eps');

%Classify using rbfs

sigmas = [0.01:0.01:0.09, 0.1:0.1:0.9, 1:1:9, 10:10:100];
err_sigma = zeros (1 ,numel(sigmas));
for sigma_i =1:numel(sigmas)
    p1 = sigmas(sigma_i);
    % train
    [nsv, alpha ,bias] = svc (trnX ,trnY ,'rbf' ,inf);
    % predict
    predictedY = svcoutput(trnX ,trnY ,tstX ,'rbf', alpha, bias);
    % compute t e s t e r r o r
    err_sigma(sigma_i) = svcerror(trnX ,trnY ,tstX ,tstY ,'rbf' ,alpha ,bias);
end
%plot error vs polynomial degree
f = figure(1);
clf(f);
plot(sigmas ,err_sigma) ;
print (f , '-depsc', 'rbf.eps');

%Classify using linear

[nsv, alpha ,bias] = svc (trnX ,trnY ,'linear' ,inf);
    % p r e d i c t
predictedY = svcoutput(trnX ,trnY ,tstX ,'linear', alpha, bias);
    % compute t e s t e r r o r
err_linear = svcerror(trnX ,trnY ,tstX ,tstY ,'linear' ,alpha ,bias);
