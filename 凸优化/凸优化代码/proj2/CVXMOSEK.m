function [ x,out] = CVXMOSEK( c, A, b, opts, x0 )
[m,n]=size(A);
cvx_begin quiet
cvx_solver mosek;
variable x1(n);
minimize( c'*x1 );
subject to
A*x1 == b;
x1 >= 0;
cvx_end
x = x1;
out = [];
end

