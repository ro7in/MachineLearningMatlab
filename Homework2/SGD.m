function [theta, Risks, classification_err] = SGD(sample,eta,epsilon)
    
    [l,n] = size(sample);
    sample_b = ones(l,n);
    label = sample(:,3);
    sample_b(:,1:2) = sample(:,1:2);

    theta = rand(n,1);
    maxiter = 200000;
    curiter = 0;
    
    classification_err = [];
    perceptron_error = [];
    num_err = 1;
    
    while num_err > 0        
        f = sample_b*theta;
        h = label.*f;
        num_err = length(find(h<=0));
        
        
        [sample_new] = ExcludeData(sample_b,h,num_err,0);
        [label_new] = ExcludeData(label,h,num_err,0);
        
        c = round(rand(num_err,1));
        
        [sample_c] = SelectData(sample_new,c,sum(c),1);
        [label_c] = SelectData(label_new,c,sum(c),1);
        
        
        for i = 1:length(label_c)
            theta = theta + (label(i,:)*sample_b(i,:))';
        end
        
        f = sample_b*theta;
        h = label.*f;
        num_err = length(find(h<=0));
        
        %classification_err(curiter,:) = num_err;
    end
end