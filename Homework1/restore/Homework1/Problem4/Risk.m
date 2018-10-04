function R = Risk(x,y,theta)
    
    f = x*theta;
    f ( f >= 0) = 1;
    f ( f < 0 ) = -1;
    A = f - Y;
    num = length(find(A~=0));
    
    [x_new] = ExcludeData(x,A,num,0);
    [y_new] = ExcludeData(y,A,num,0);

    r = (y-1).*log(1-f)-y.*log(f); 
    % r logistic loss
    r(isnan(r)) = 0;
    R = mean(r) ;
end