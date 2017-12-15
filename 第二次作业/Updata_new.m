function [ Q,S,Y,Ms,My,L,U ] = Updata_new( Q,S,Y,Ms,My,L,U,s,y,m,rho)
%   S,Y,M,D的更新 
%  input
%   Q  n*m or n*k matrix
%   M=LU  m*m or k*k matrix   D is inverse of M 
%   M = Ms - My
%   s   n_vector   s = x_{k} - x_{k-1}
%   y   n_vector   y = g_{k} - g_{k-1}
%   m    int     存储规模
%
%  output
%     Q,M,L,U为对应的更新,若新的M奇异则取旧值
%

k = length(L);
if k < m
    S1 = [S,s];
    Y1 = [Y,y];
    Ms1(k+1,1:k+1) = s'*Y1;
    Ms1(1:k,k+1) = Ms1(k+1,1:k);
    Ms1(1:k,1:k) = Ms;
    My1(k+1,1:k+1) = y'*Y1;
    My1(1:k,k+1) = My1(k+1,1:k);
    My1(1:k,1:k) = My;
else
    S1 = [S(:,2:m),s];
    Y1 = [Y(:,2:m),y];
    Ms1(m,1:m) = s'*Y1;
    Ms1(1:m-1,m) = Ms1(m,1:m-1);
    Ms1(1:m-1,1:m-1) = Ms(2:m,2:m);
    My1(m,1:m) = y'*Y1;
    My1(1:m-1,m) = My1(m,1:m-1);
    My1(1:m-1,1:m-1) = My(2:m,2:m);
end
[L1,U1]=lu(Ms1-rho*My1);
if rcond(U1) > 1e-14
    U = U1;
    L = L1;
    Ms = Ms1;
    My = My1;
    Q = S1-rho*Y1;
    S = S1;
    Y = Y1;
  
end
    Ms = Ms1;
    My = My1;
    Q = S1-rho*Y1;
    S = S1;
    Y = Y1;
end
