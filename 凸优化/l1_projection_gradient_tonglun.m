function [x0, f] = l1_projection_gradient_tonglun(x0, A, b, mu, opts5)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
mu = [10000*mu,1000*mu,100*mu,10*mu,4*mu,2*mu,mu];
for mu1 = mu
     [x0 ,f]= l1_projection_gradient(x0, A, b, mu1, opts5);
end