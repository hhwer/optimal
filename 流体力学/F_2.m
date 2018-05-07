function [ Fblus,Fminus ] = F_2( U,gamma,k )
%得到2维
%   此处显示详细说明

[m,n] = size(U);

Fblus = zeros(m,n);
Fminus = zeros(m,n);
R = zeros(4,3);

if k == 1
    alpha = 1;
    beta = 0;
else
    alpha = 0;
    beta = 1;
end

for k = 1:n
    rho = U(1,k);
    u = U(2,k)/U(1,k);
    v  = U(3,k)/U(1,k);
    E = U(4,k);
    e = E/rho - 1/2*u^2 - 1/2*v^2;
    p = (gamma-1)*rho*e;
    a = sqrt(gamma*p/rho);
    H = (E+p)/rho;
    lambda1 = alpha*u + beta*v;
    lambda2 = lambda1;
    lambda3 = lambda1 - a ;
    lambda4 = lambda1 + a;

    
    u1 = u-alpha*a;
    v1 = v-beta*a;
    u2 = u+alpha*a;
    v2 = v+beta*a;
    R(1:4,1) = [1; u; v; 1/2*(u^2+v^2)];
    R(1:4,2) = [1; u1; v1; 1/2*(u1^2+v1^2) + (3-gamma)/2/(gamma-1)*a^2 ];
    R(1:4,3) = [1; u2; v2; 1/2*(u2^2+v2^2) + (3-gamma)/2/(gamma-1)*a^2 ];
    
    
    lambda1 = [max(lambda1,0),min(lambda1,0)];
    lambda2 = [max(lambda2,0),min(lambda2,0)];
    lambda3 = [max(lambda3,0),min(lambda3,0)];
    lambda4 = [max(lambda4,0),min(lambda4,0)];
    lambda = [2*(gamma-1)*lambda1; lambda3; lambda4];
    F =rho/2/gamma * R*lambda;
    Fblus(:,k) = F(:,1);
    Fminus(:,k) = F(:,2);
end

end