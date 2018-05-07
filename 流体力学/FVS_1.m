function [ U ] = FVS_1( U,gamma,lambda )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(U);
[ Fblus,Fminus ] = F_1( U,gamma );
Fminus(:,n+1) = Fminus(:,1);
Fblus = [Fblus(:,n),Fblus];


U = U  -lambda*(Fminus(:,2:n+1)-Fminus(:,1:n)) - lambda*(Fblus(:,2:n+1)-Fblus(:,1:n));

end

