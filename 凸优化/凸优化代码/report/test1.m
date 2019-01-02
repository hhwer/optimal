clc;
clear;
n = 1000;
T = 100;
B0 = randn(n);
B = B0'*B0;
A0 = rand(n);
A = tril(A0,-1)+triu(A0',0);
% A0 = randn(n);
% A = A0'*A0;
tic
u1 = GenELin(A, B, T);
t1 = toc;
disp(u1'*A*u1);
lambda=B^-1*(A*u1)./u1;

%%%%%%%%%%%%%%%%%
% 
% cvx_begin
% cvx_solver mosek;
% variable x1(n);
% tic;
% minimize( x1'*A*x1 );
% subject to
%     norm(x1) <= 1;
% t2=toc; 
% cvx_end