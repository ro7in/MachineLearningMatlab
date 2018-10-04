function [err,model,errT] = polyreg2(x,y,labmda,xT,yT)

% x = vector of input scalars for training
% y = vector of output scalars for training
% D = the order plus one of the polynomial being fit
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% model = vector of polynomial parameter coefficients
% errT = average squared loss on testing

xx=x'*x;
model = (xx + labmda * eye(size(xx)))\x'*y;
err   = (1/(2*size(x,1)))*sum((y-x*model).^2);
errT = (1/(2*size(xT,1)))*sum((yT-xT*model).^2);