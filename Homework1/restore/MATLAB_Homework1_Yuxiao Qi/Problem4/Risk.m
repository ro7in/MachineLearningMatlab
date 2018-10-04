function R = Risk(x,y,theta)
    f = 1./(1+exp(-x*theta));
    r = (y-1).*log(1-f)-y.*log(f); 
    % r logistic loss
    r(isnan(r)) = 0;
    R = mean(r) ;
end