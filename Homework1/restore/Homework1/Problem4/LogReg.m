function [theta, Risks, Errs] = LogReg(X,Y,eta,epsilon)

    % X: the inpput vectors
    % Y:binary labels
    % eta: step size
    % epsilon: tolerence

    theta = rand(size(X,2),1);
    maxiter = 200000;
    curiter = 0;
    % For plotting stats
    Risks = [];
    Errs = [];
    prevtheta = theta+2*epsilon;
    
    while norm(theta - prevtheta) >= epsilon
        if curiter > maxiter
            break;
        end
        % Current stats
        r = Risk(X,Y,theta);
        f = 1./(1+exp(-X*theta));
        f ( f >= 0.5) = 1;
        f ( f < 0.5 ) = 0;
        err = sum(f~=Y)/length(Y);
        fprintf('Iter:%d, error:%0.4f, risk:%0.4f\n', curiter , err ,r);
        %risks = cat (1 , risks , r);
        %errs = cat (1 , errs , err ) ;

        % Update theta
        prevtheta = theta ;
        G = gradient (X, Y, theta);
        theta = theta - eta*G;
        curiter = curiter + 1;
        
        Risks(curiter,:) = r;
        Errs(curiter,:) = err;
    end
    
    figure,plot(1:curiter,Errs,'r',1:curiter,Risks,'g');
    disp ('theta');
    disp (theta)
    x=0:0.01:1;
    y = (-theta(3)-theta(1).*x)/theta(2);
    figure,plot(x,y,'r');
    hold on;
    plot (X(:,1),X(:,2),'.');
end



