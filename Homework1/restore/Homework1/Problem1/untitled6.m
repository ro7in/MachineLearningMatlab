x_train = x(sub_idx == 0) ;
y_train = y(sub_idx == 0) ;
x_test = x(sub_idx == 1) ;
y_test = y(sub_idx == 1) ;

for d=1:40
[ err , model , errT ] = polyreg ( x_train , y_train , d, x_test , y_test ) ;
%title( sprintf ( 'd = %d ? , d ) ) ;
train_error(d) = err;
test_error(d) = errT ;
o{d} = model ;
end