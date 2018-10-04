function [test_sample, test_label] = SelectData(sample, label, sub_idx, itr)
% data���畔���W��itr�̃f�[�^�����o��

% created by hayashida 2008/06/27
[l, n] = size(sample);  % �f�[�^�W�̎擾
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