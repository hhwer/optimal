function [ Q,M,L,U ] = Updata( Q,M,L,U,s,y,m)
%   Q,M,D的更新
%  input
%   Q  n*m or n*k matrix
%   M=LU  m*m or k*k matrix   D is inverse of M
%   s   n_vector   s = x_{k} - x_{k-1}
%   y   n_vector   y = g_{k} - g_{k-1}
%   m    int     存储规模
%
%  output
%     Q,M,L,U为对应的更新,若新的M奇异则取旧值
%
q = s - y;
k = length(M);
if k < m
    Q1 = Q;
    Q1(:,k+1) = q;
    M1(k+1,1:k+1) = y'*Q1;
    M1(1:k,k+1) = M1(k+1,1:k);
    M1(1:k,1:k) = M;
    [L1,U1]=lu(M1);
else
    Q1 = [Q(:,2:m),q];
    M1(m,1:m) = y'*Q1;
    M1(1:m,m) = M1(m,1:m);
    M1(1:m-1,1:m-1) = M(2:m,2:m);
    [L1,U1]=lu(M1);
end
% if abs(prod(diag(U1)))>1e-1
if rcond(U1) > 1e-14
    U = U1;
    L = L1;
    M = M1;
    Q = Q1;
end
end

