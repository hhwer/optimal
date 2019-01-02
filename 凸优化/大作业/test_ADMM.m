% clear;
% clc;

n = 100;
m = 20;
A = randn(m,n);
xs = full(abs(sprandn(n,1,m/n)));
b = A*xs;
y = randn(m,1);
s = rand(n,1).*(xs==0);
c = A'*y + s;
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
Fun = @(y)-b'*y;

tic; 
cvx_begin
    cvx_solver mosek
    variable x1(n)
    minimize( c'*x1  )
    subject to
        A * x1 == b
        x1 >= 0
cvx_end
t1 = toc;

tic; 
cvx_begin
    cvx_solver mosek
    variable y1(m) 
    variable s1(n)
    minimize( -b'*y1  )
    subject to
        A' * y1 + s1 == c 
        s1 >= 0
cvx_end
t2 = toc;

tic
[y2,out2] = ADMM(y,s,A,b,c);
t3 = toc; 

% fprintf('    Proxgrad for primal: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));