% eigenface

clear all
close all
clc

%step 1:Get some data
num = 20;
[height, width] = size(imread('data/1.pgm'));
Data(height*width,num) = 0; %convert one image data into a column

for i=1:num
    path = ['data/',num2str(i),'.pgm'];
    temp = imread(path);
    temp = im2double(temp);
    Data(:,i) = reshape(temp, [], 1);   %convert one image data into a column
end

%setp 2:Subtract the mean
MeanValue = mean(Data, 2);
OriginalMean = repmat(MeanValue,1, size(Data,2));
DataAdjust = Data - OriginalMean;

%step 3:Calculate the covariance matrix
% ע�������cov�����������������Ǿ�����ô�д�����ά�ȣ�Ҳ���������x1,x2,x3,xn��
% ���ԣ�����DataAdjust��Ҫת��һ�¡�
% Covariance = cov(DataAdjust');
% Covariance_2 = (DataAdjust * DataAdjust')./(size(Data,2)-1); %��֤��A*A'/(N-1)����Э�������

%step 4:calculate the eigenvectors and eigenvalues
% [EigenVectors, EigenValues] = eig(Covariance); %����ֵEigenValues���մ�С��������ģ����ԣ��ӿ������ѡ�����ɷ�

%step 5:choosing components and forming a feature vector.
[row, col] = size(Data);
if row >= col
    length = col;
else
    length = row;
end
% SortEigenVectors = fliplr(EigenVectors); %�����������򣬵�һ�ж�Ӧ������ֵ�����������
% FeatureVectors = SortEigenVectors(:,1:length-1); %%select part the EigenVectors as the components, here is the first length-1 columns

%������һ�ַ����õ�FeatureVectors,��Ե�������ά���ϴ�����,���ַ�������
C1 = DataAdjust' * DataAdjust;
[C1_EigenVectors, C1_EigenValues] = eig(C1);
V = DataAdjust * C1_EigenVectors;
%���й�һ�� ��һ���ںö������ﶼû���ἰ��
EigenVectors_2 = V ./ (ones(size(V, 1),1) * sqrt(sum(V .* V)));
%ѡȡpricipal components
SortEigenVectors_2 = fliplr(EigenVectors_2);
FeatureVectors = SortEigenVectors_2(:,1:length-1); 

%ѡȡһ��������������չʾ������ν����������Ŀǰһ����20-1=19��������
% EigenFace_1 = reshape(FeatureVectors(:,2),height, width);
% figure
% imshow(EigenFace_1, []);

%ͼ������ͶӰ�������ռ���
PatternVectors = FeatureVectors' * DataAdjust; %ÿһ�д���һ��ͼ��ͶӰ��n-1ά�Ŀռ��


%����ͼ��
%��һ��ͼ��ӳ�䵽�����ռ��õ���ģʽ������Ҳ������n-1ά�ϵĸ���ͶӰ
TestData = imread('D:\Matlab\3_eigenface\study\orl_faces\s20\2.pgm');
temp = im2double(TestData);
TestData = reshape(temp, [], 1);
TestDataPatternVector = FeatureVectors' * (TestData - MeanValue); 
%����ŷ�Ͼ�����бȽϡ�
result(1, length) = 0;
for i=1:length
    temp = (PatternVectors(:,i) - TestDataPatternVector).^2;
    result(1,i) = sqrt(sum(temp));
end
[minimum, index] = min(result);
X = ['Match the s', num2str(index), ' successfully.  Congratulations!'];
disp(X)








