function [err] = svmPro2 (kernelType)

load('shoesducks.mat');
n = size(X,1);

%Split dataset
idxtrain = randsample(n, n/2);
idxtest = setdiff(1:n, idxtrain);
trnX = X(idxtrain, : );
tstX = X(idxtest, : );
trnY = Y(idxtrain, : );
tstY = Y(idxtest, : );
global p1;

switch lower(kernelType)
    case('linear')
        kernelPa = NaN;
    case('poly')
        kernelPa = 1:1:5;
    case('rbf')
        kernelPa = [0.01:0.01:0.09, 0.1:0.1:0.9, 1:1:9, 10:10:100];
end

err = zeros (1 ,numel(kernelPa));

for parm_i =1:numel(kernelPa)
    p1 = kernelPa(parm_i);
    % train
    [nsv, alpha ,bias] = svc (trnX ,trnY ,kernelType ,inf);
    % predict
    predictedY = svcoutput(trnX ,trnY ,tstX ,kernelType, alpha, bias);
    % compute t e s t e r r o r
    err(parm_i) = svcerror(trnX ,trnY ,tstX ,tstY ,kernelType ,alpha ,bias);
end
% plot error vs polynomial degree
% f = figure(1);
% clf(f);
% plot(sigmas ,err_sigma) ;
% print (f , '-depsc', 'rbf.eps');

end