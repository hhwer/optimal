function [ Q ] = rand_rangefinder(A,c,k);
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[~,n] = size(A);

Omega = randn(n,c);
Y = A*Omega;
% [Q,~] = qr(Y);
[Q,~] = svd(Y,0);
Q = Q(:,1:k);

end
