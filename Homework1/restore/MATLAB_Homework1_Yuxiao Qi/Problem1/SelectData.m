function [test_sample] = SelectData(sample, sub_idx, itr)


[l, n] = size(sample); 
s_test = 0;
                
for i = 1:l
   if sub_idx(i) == itr
       s_test = s_test + 1;
   end
end
test_sample = zeros(s_test,n);
s = 0;
for i = 1:l
   if sub_idx(i) == itr
       s = s + 1;
       test_sample(s,:) = sample(i,:);
   end
end
end