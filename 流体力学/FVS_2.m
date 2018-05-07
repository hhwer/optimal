function [ U ] = FVS_2( U,gamma,lambda,k)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n,~] = size(U);
if k == 0
    U = FVS_2( U,gamma,lambda/2,1);
    U = FVS_2( U,gamma,lambda,2);
    U = FVS_2( U,gamma,lambda/2,1);
elseif k == 1
    for i = 1:n
        u = reshape(U(:,:,i),m,n);
        [ Fblus,Fminus ] = F_2( u,gamma,1 );
        Fminus(:,n+1) = Fminus(:,1);
        Fblus = [Fblus(:,n),Fblus];
        u = u  -lambda*(Fminus(:,2:n+1)-Fminus(:,1:n)) - ...
                            lambda*(Fblus(:,2:n+1)-Fblus(:,1:n));
        U(:,:,i) = reshape(u,m,n,1);
    end
elseif k == 2   
        for i = 1:n
        u = reshape(U(:,i,:),m,n);
        [ Fblus,Fminus ] = F_2( u,gamma,2 );
        Fminus(:,n+1) = Fminus(:,1);
        Fblus = [Fblus(:,n),Fblus];
        u = u  -lambda*(Fminus(:,2:n+1)-Fminus(:,1:n)) - ...
                            lambda*(Fblus(:,2:n+1)-Fblus(:,1:n));
        U(:,i,:) =  reshape(u,m,1,n);
    end
else
    fprintf('wrong k in FVS\n');
end
end