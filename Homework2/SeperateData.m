function [positive_data, negative_data] = SeperateData(X)

l = size(X,1);
                
label = X(:,3);
sample = X(:,1:2);

n_positive = 0;
n_negative = 0;

for i = 1:l
    if label(i) == 1
        n_positive = n_positive + 1;
    end
end

n_negative = l - n_positive;

[positive_data] = SelectData(sample,label,n_positive,1);
[negative_data] = SelectData(sample,label,n_negative,-1);


end