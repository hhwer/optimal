function [ l,d ] = correctCholesky (g ,delta)
%UNTITLED2                  ����cholesky�ֽ�
%   
%intpu      
%           g     n*n_matrix
%           delta �����Խ�Ԫ�½� Ĭ��0.01
%
%output     
%           l     ��λ������
%           d     �Խ�
if nargin < 2
    delta = 0.01;
end
n = size(g);
n = n(1);
row = 0;  % max gij
sigma = 0;  % max gii
for i = 1:n
    for j = 1:n
        if i==j
            sigma = max(sigma,g(i,i));
        else
            row = max(row,g(i,j));
        end
    end
end
beta2 = max(sigma,row/n);
theta = zeros(n);
c = zeros(n,n);
d = delta * ones(n,1);
l = eye(n,n);
for j = 1:n
        c(j,j) = g(j,j);
    for r= 1:j-1
        c(j,j) = c(i,j) - c(j,r)^2/d(r);
    end
    for i = j+1:n
        c(i,j) = g(i,j);
       for r = 1:j-1
           c(i,j) = c(i,j) - l(j,r)*c(i,r);
       end
    end
    if j<n
        theta(j) = max(abs(c(j+1:n,j)));
    end
    d(j) = max([d(j),theta(j)^2/beta2,abs(c(j,j))]);
    for i =j+1:n
        l(i,j) = c(i,j)/d(j);
    end
end
end

