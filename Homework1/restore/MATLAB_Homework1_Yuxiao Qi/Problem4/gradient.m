function g = gradient (x , y , theta )
    %nabla_thetaR
    yy = repmat(y,1,size(x,2));
    f = 1./(1+exp(-x*theta));
    ff = repmat(f,1,size(x,2));
    d = x.*repmat(exp(-x*theta),1,size(x,2));
    g = (1-yy).*(x-d.*ff) - yy.*d.*ff;
    g = sum(g);
    g = g/length(y);
    g = g';
end