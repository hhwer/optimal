clear;
clc;

n = 1024;
m = 512;
A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;
mu = 1e-3;
x0 = rand(n,1);
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));
cvx_begin
cvx_solver mosek;
variable x1(n);
tic;
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
t1=toc;
cvx_end
w = [10,1,0.1,0.01,1e-3];
ep = [1e-1,1e-2,1e-2,1e-5,1e-6];
lambda = [1e-1,1e-2,1e-3,1e-5,1e-6];
% huber
x2 = x0;
tic
for i = 1:length(w)
    mu = w(i);
% mu = 1e-3;
    epsilon = ep(i);
% epsilon = 1e-6;
    lamb = lambda(i);
    x2 = BBsmooth(A,b,mu,x2,3,lamb,epsilon);
end
t2 = toc;

% % log-sum-exp
% x3 = x0;
% tic
% for i = 1:length(w)
%     mu = w(i);
%     epsilon = ep(i);
%     x3 = BBForSmoothed(A,b,mu,x3,2,lambda,epsilon);
% end
% t3 = toc;
% % sqrt
% x4 = x0;
% tic
% for i = 1:length(w)
%     mu = w(i);
%     epsilon = ep(i);
%     x4 = BBForSmoothed(A,b,mu,x4,3,lambda,epsilon);
% end
% t4 = toc;

fprintf('       BB for huber smoothed: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t2, errfun(x1, x2));
% fprintf(' BB for log-sum-exp smoothed: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t3, errfun(x1, x3));
% fprintf('        BB for sqrt smoothed: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t4, errfun(x1, x4));