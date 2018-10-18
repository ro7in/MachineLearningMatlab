% eigenface

clear all
close all
clc

%step 1:Get some data
num = 20;
[height, width] = size(imread('data/1.pgm'));
Data(num, height*width) = 0; %convert one image data into a column

for i=1:num
    path = ['data/',num2str(i),'.pgm'];
    temp = imread(path);
    temp = im2double(temp);
    Data(i, :) = reshape(temp, 1, []);   %convert one image data into a column
end

%setp 2:Subtract the mean
MeanValue = mean(Data, 1);
OriginalMean = repmat(MeanValue,size(Data,1), 1);
DataAdjust = Data - OriginalMean;

%step 3:Calculate the covariance matrix
% 注意这里的cov函数，如果传入参数是矩阵，那么行代表了维度，也就是上面的x1,x2,x3,xn。
% 所以，这里DataAdjust需要转置一下。
% Covariance = cov(DataAdjust);
% Covariance_2 = (DataAdjust' * DataAdjust)./(size(Data,1)-1); %验证了A*A'/(N-1)等于协方差矩阵

%step 4:calculate the eigenvectors and eigenvalues
% [EigenVectors, EigenValues] = eig(Covariance); %返回值EigenValues按照从小到大排序的，所以，从靠后的列选择主成分

%step 5:choosing components and forming a feature vector.
[row, col] = size(Data);
if row >= col
    length = col;
else
    length = row;
end
% SortEigenVectors = fliplr(EigenVectors); %特征向量排序，第一列对应的特征值最大，依次往后
% FeatureVectors = (SortEigenVectors(:,1:length-1))'; %%select part the EigenVectors as the components, here is the first length-1 columns

%用另外一种方法得到FeatureVectors,针对的是数据维数较大的情况,这种方法更快
%C1 = DataAdjust * DataAdjust';
C1 = cov(DataAdjust);
[C1_EigenVectors, C1_EigenValues] = eig(C1);
C1_EValues_1 = diag(C1_EigenValues);
C1_EValues_2 = diag(C1_EValues_1(end-2:end,:));
C1_EVector = C1_EigenVectors(:,end-2:end);
Feature = C1_EVector * C1_EValues_2 * C1_EVector';

V = C1_EigenVectors' * DataAdjust;
%进行归一化 这一步在好多叙述里都没有提及到
EigenVectors_2 = V ./ (sqrt(sum(V .* V, 2)) * ones(1, size(V,2)));
%选取pricipal components
SortEigenVectors_2 = flipud(EigenVectors_2);
FeatureVectors = SortEigenVectors_2(1:length-1,:); 

%选取一个特征向量进行展示，即所谓的特征脸，目前一共有20-1=19个特征脸
% EigenFace_1 = reshape(FeatureVectors(2,:),height, width);
% figure
% imshow(EigenFace_1, []);

%图像数据投影到特征空间上
RowFeatureVector  = FeatureVectors';
PatternVectors = DataAdjust * RowFeatureVector; %每一行代表一幅图像投影到n-1维的空间里。


%测试图像
%将一张图像映射到特赠空间后得到的模式向量，也就是在n-1维上的各个投影
TestData = imread('D:\Matlab\3_eigenface\study\orl_faces\s10\2.pgm');
temp = im2double(TestData);
TestData = reshape(temp, 1, []);
TestDataPatternVector = (TestData - MeanValue) * FeatureVectors'; 
%利用欧氏距离进行比较。
result(length,1) = 0;
for i=1:length
    temp = (PatternVectors(i,:) - TestDataPatternVector).^2;
    result(i,1) = sqrt(sum(temp));
end
[minimum, index] = min(result);
X = ['Match the s', num2str(index), ' successfully.  Congratulations!'];
disp(X)








