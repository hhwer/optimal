function [ Fblus,Fminus ] = F_3( U,gamma,k )
%得到3维
%   此处显示详细说明
epi = 0.1;
[m,n] = size(U);

Fblus = zeros(m,n);
Fminus = zeros(m,n);
R = zeros(5,3);

if k == 1
    alpha1 = 1;
    alpha2 = 0;
    alpha3 = 0;
elseif k == 2
    alpha1 = 0;
    alpha2 = 1;
    alpha3 = 0;
else
    alpha1 = 0;
    alpha2 = 0;
    alpha3 = 1;
end

for k = 1:n
    rho = U(1,k);
    u = U(2,k)/U(1,k);
    v  = U(3,k)/U(1,k);
    w = U(4,k)/U(1,k);
    E = U(5,k);
    e = E/rho - 1/2*u^2 - 1/2*v^2 - 1/2*w^2;
    p = (gamma-1)*rho*e;
    a = sqrt(gamma*p/rho);
    lambda1 = alpha1*u + alpha2*v;
    lambda4 = lambda1 - a ;
    lambda5 = lambda1 + a;

    
    u1 = u-alpha1*a;
    v1 = v-alpha2*a;
    w1 = w-alpha3*a;
    u2 = u+alpha1*a;
    v2 = v+alpha2*a;
    w2 =w+alpha3*a;
    
    R(1:5,1) = [1; u; v; w; 1/2*(u^2+v^2+w^2)];
    R(1:5,2) = [1; u1; v1; w1; 1/2*(u1^2+v1^2+w1^2) + (3-gamma)/2/(gamma-1)*a^2 ];
    R(1:5,3) = [1; u2; v2; w2; 1/2*(u2^2+v2^2+w2^2) + (3-gamma)/2/(gamma-1)*a^2 ];
    
        
    lambda10 = sqrt(lambda1^2+epi^2);
    lambda50 = sqrt(lambda5^2+epi^2);
    lambda40 = sqrt(lambda4^2+epi^2);
    lambda1 = [lambda10,-lambda10]+lambda1;
    lambda5 = [lambda50,-lambda50]+lambda5;
    lambda4 = [lambda40,-lambda40]+lambda4;
    lambda1 = lambda1/2;
    lambda5 = lambda5/2;
    lambda4 = lambda4/2;
%     lambda1 = [max(lambda1,0),min(lambda1,0)];
%     lambda4= [max(lambda4,0),min(lambda4,0)];
%     lambda5 = [max(lambda5,0),min(lambda5,0)];
    lambda = [2*(gamma-1)*lambda1; lambda4; lambda5];
    F =rho/2/gamma * R*lambda;
    Fblus(:,k) = F(:,1);
    Fminus(:,k) = F(:,2);
end

end