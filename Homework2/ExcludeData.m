function [sample_new] = ExcludeData(sample,label,num,tar_lab)
    [l, n] = size(sample);
    sample_new = zeros(num,n);
    
    s = 0;
    for i = 1:l
       if label(i) <= tar_lab
           s = s + 1;
           sample_new(s,:) = sample(i,:);
       end
    end
end