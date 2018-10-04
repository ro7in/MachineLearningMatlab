function [CV_train_Err,CV_test_Err] = PolyRegY(x,y,degree)

%x is all the input data
%y is all the output data
%d is set by user when test degree from 1 to d
%CV_train_Err is average squared loss on training of different d
%CV_test_Err is average squared loss on test of different d

m=length(x);
[sub_idx] = Pickidx(m);

%Pickidx is the function tha seperate data in to 2 part

x_train = x(sub_idx == 0) ;
y_train = y(sub_idx == 0) ;

x_test = x(sub_idx == 1) ;
y_test = y(sub_idx == 1) ;

s = 0;
for D = 1:degree
    
    [err,model,errT] = polyreg(x_train,y_train,D,x_test,y_test)
    title(sprintf('degree = %d', ));
    s = s+1;
    CV_train_Err(s,:) = err;
    CV_test_Err(s,:) = errT;
    CV_model{s} = model;
end

clf;
hold on;
plot(CV_train_Err)
plot(CV_test_Err)
[i,j] = min(CV_test_Err);
plot(j,min(CV_test_Err),'X');
xlabel('d');
ylabel('Error')
legend('train','test');
%title('Cross-Validation Test Error');

function [sub_idx] = Pickidx(m)

for i = 1:100

    s = round(rand(1,m));
    su = sum(s);

        if su == m/2
         sub_idx = s';
        end
end