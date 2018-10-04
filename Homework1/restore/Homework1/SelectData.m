function [test_sample, test_label] = SelectData(sample, label, sub_idx, itr)
% dataから部分集合itrのデータを取り出す

% created by hayashida 2008/06/27
[l, n] = size(sample);  % データ集の取得
s_test = 0;
                
for i = 1:l
   if sub_idx(i) == itr
       s_test = s_test + 1;
   end
end
test_sample = zeros(s_test,n);
test_label = zeros(s_test,1);
s = 0;
for i = 1:l
   if sub_idx(i) == itr
       s = s + 1;
       test_sample(s,:) = sample(i,:);
       test_label(s,:) = label(i,:);
   end
end
end