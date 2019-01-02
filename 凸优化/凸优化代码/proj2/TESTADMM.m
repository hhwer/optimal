clc;clear;
errfun = @(x1, x2) (norm(x1-x2)/(1+norm(x1)));
objfun = @(x) (c'*x);
n = 100;
m = 20;
A = rand(m,n);
xs = abs(sprandn(n,1,m/n));
b = A*xs;
y = randn(m,1);
s = rand(n,1).*(xs==0);
c = A'*y+s;
ep = 1e-7;
tic;
% cvx_begin
% cvx_solver mosek;
% variable y1(m);
% minimize( b'*y1 );
% subject to
%     A'*y1+c >= 0;
% cvx_end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cvx_begin
variable x1(n);
minimize( c'*x1 );
subject to
A*x1 == b;
x1 >= 0;
cvx_end
t1 = toc;

tic;
[x2]=ADMM(A, b, c, ep);
t2 = toc;

fprintf(' cvx call mosek: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t1, errfun(x1, x1));
fprintf('   ALM for dual: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t2, errfun(x1, x2));