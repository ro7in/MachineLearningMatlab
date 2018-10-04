function [sample_new] = SelectData(sample,label,tar_lab)
    [l, n] = size(sample);
    sample_new = zeros(l,n);
    
    s = 0;
    for i = 1:l
       if label(i) == tar_lab
           s = s + 1;
           sample_new(s,:) = sample(i,:);
       end
    end
end