function [ y,L ] = likeli_0( x0, X ,  N, p, K,lambda,type)
%UNTITLED3 此处显示有关此函数的摘要
%  X cell*K  X{i}是以class==i的x为行构成的矩阵
nums = zeros(K,1);
kernels = cell(K,1);
load('data.mat')
for i = 1:K
    d = sqrt(sum((X{i}-x0).^2,2));
    idx = d<=lambda;
    kernels{i} = kernel1(d(idx), lambda,type);
    X{i} = X{i}(idx, :);
    nums(i) = sum(kernels{i});
end
dense = nums/sum(nums);
mu = zeros(K,p);
dist_mu = cell(K,1);
sig = zeros(p, p);
for i = 1:K
    if nums(i) == 0
        continue
    end
    mu(i, :) = kernels{i}'*X{i}/nums(i);
    dist_mu{i} = X{i}-mu(i, :);
    sig = sig+dist_mu{i}'*(dist_mu{i}.*kernels{i});
end
sig = sig/sum(nums);
sig_I = sig^(-1);

pro = zeros(K,1);
for i = 1:K
    dist_0 = x0-mu(i, :);
    pro(i) = log(dense(i)) - 1/2*(dist_0*sig_I*dist_0');
end
[~,y] = max(pro);
y = y-1;

if nargout < 2
    return
end
   
L=0;
for i = 1:K
    P = log(dense(i)) - 1/2*diag(dist_mu{i}*sig_I*dist_mu{i}');
    L = L + kernels{i}'*P;
end

end