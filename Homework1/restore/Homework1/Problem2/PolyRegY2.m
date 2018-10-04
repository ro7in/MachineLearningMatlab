function [CV_train_Err,CV_test_Err] = PolyRegY2(x,y,degree)

%x is all the input data
%y is all the output data
%degree is parameter lambda
%CV_train_Err is average squared loss on training of different d
%CV_test_Err is average squared loss on test of different d

m=size(x,1);
[sub_idx] = Pickidx(m);

%Pickidx is the function tha seperate data in to 2 part

x_train = x(sub_idx == 0,:) ;
y_train = y(sub_idx == 0,:) ;

x_test = x(sub_idx == 1,:) ;
y_test = y(sub_idx == 1,:) ;

s = 0;
Lambda = 0:0.5:degree
% lambda is from 0 to figure degrree, increased by 0.5
for lambda = Lambda
    
    [err,model,errT] = polyreg2(x_train,y_train,lambda,x_test,y_test)
    s = s+1;
    CV_train_Err(s,:) = err;
    CV_test_Err(s,:) = errT;
    CV_model{s} = model;
end

clf;
hold on;
plot(0:0.5:degree, CV_train_Err)
plot(0:0.5:degree, CV_test_Err)
[i,j] = min(CV_test_Err);
plot(Lambda(1,j),i,'X');
xlabel('Lambda');
ylabel('Error')
legend('train','test');

function [sub_idx] = Pickidx(m)

for i = 1:100

    s = round(rand(1,m));
    su = sum(s);

        if su == m/2
         sub_idx = s';
        end
end