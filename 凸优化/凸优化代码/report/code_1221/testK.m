clc;
clear;
k = 10;
n = 100;
T = 1000;
B0 = randn(n);
B = B0'*B0;
A0 = rand(n);
A = tril(A0,-1)+triu(A0',0);
% A0 = randn(n);
% A = A0'*A0;
tic
u1 = GenELinK(A, B, T, k);
t1 = toc;
% disp(u1'*A*u1);
lambda=B^-1*(A*u1)./u1;
u1 = u1{:,1:5};