function [ H,sigma,tsvd ] = monte_carlo( A,c,k )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(A);
beta = 1;
p = zeros(n,1);
Prob = zeros(n,1);

for i =1:n
p(i) = norm(A(:,i))^2;
end
nor = sum(p);
p(1) = p(1)/nor;
Prob(1) = beta*p(1);
for i = 2:n
    p(i) = p(i)/nor;
    Prob(i) = Prob(i-1) + beta*p(i);
end


C = zeros(m,c);

for t = 1:c
    pi = rand(1);
    i = length(Prob(Prob<pi)) + 1;
    C(:,t) = A(:,i)/sqrt(c*p(i));
end

tic
[~,sigma,V] = svd(C'*C);
sigma = sqrt(diag(sigma));
H = C*V./(sigma');
% [H,sigma,V] = svd(C);   %%%  svd(C'*C)比svd(C)快!!!
tsvd = toc;

% sigma = diag(sigma);
% sigma = sigma(1:k);
H = H(:,1:k);
end

