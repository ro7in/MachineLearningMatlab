function [theta, perceptron_error, classification_err] = GD(sample,eta,epsilon)

    [l,n] = size(sample);
    sample_b = ones(l, n);
    label = sample(:,3);
    sample_b(:, 1:2) = sample(:, 1:2);

    theta = rand(n, 1);
    maxiter = 1000;
    curiter = 0;
    
    classification_err = [];
    perceptron_error = [];
    prevtheta = theta+2 * epsilon;
    
    while norm(theta - prevtheta) >= epsilon
        if curiter > maxiter
            break;
        end     
        f = sample_b * theta;
        h = label .* f;
        num_err = length(find(h <= 0));
        
        [sample_new] = ExcludeData(sample_b,h,num_err,0);
        [label_new] = ExcludeData(label,h,num_err,0);
        per_err = -sum(label_new .* (sample_new * theta)) / l;
        
        %update theta
        prevtheta = theta;
        theta_new = theta + (sample_new'*label_new/l)*eta;
        theta = theta_new;
        curiter = curiter + 1;
        
        classification_err(curiter,:) = num_err/l;
        perceptron_error(curiter,:) = per_err;
    end
    
    [negative_data] = SelectData(sample_b,label,-1);
    [positive_data] = SelectData(sample_b,label,1);
    
    x=0:0.01:1;
    y = (-theta(3)-theta(1).*x)/theta(2);
    figure,plot(x,y,'r');
    hold on;
    plot (negative_data(:,1),negative_data(:,2),'.');
    plot (positive_data(:,1),positive_data(:,2),'x');
    figure,plot(1:curiter, classification_err,'r',1:curiter, perceptron_error,'b');
    legend('Classifcation Error','Perceptron Error');
end