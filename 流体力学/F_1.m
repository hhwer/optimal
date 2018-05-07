function [ Fblus,Fminus ] = F_1( U,gamma )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

epi = 0.1;

[m,n] = size(U);

Fblus = zeros(m,n);
Fminus = zeros(m,n);
R = zeros(3,3);

for k = 1:n
    rho = U(1,k);
    u = U(2,k)/U(1,k);
    E = U(3,k);
    
    e = E/rho - 1/2*u^2;
    p = (gamma-1)*rho*e;
    a = sqrt(gamma*p/rho);
    H = (E+p)/rho;
    lambda1 = u-a;
    lambda2 = u;
    lambda3 = u+a;
    R(1:3,1) = [1;lambda1;H-u*a];
    R(1:3,2) = [1;u;1/2*u^2];
    R(1:3,3) = [1;lambda3;H+u*a];
    
    lambda10 = sqrt(lambda1^2+epi^2);
    lambda20 = sqrt(lambda2^2+epi^2);
    lambda30 = sqrt(lambda3^2+epi^2);
    lambda1 = [lambda10,-lambda10]+lambda1;
    lambda2 = [lambda20,-lambda20]+lambda2;
    lambda3 = [lambda30,-lambda30]+lambda3;
    lambda1 = lambda1/2;
    lambda2 = lambda2/2;
    lambda3 = lambda3/2;
%     lambda1 = [max(lambda1,0),min(lambda1,0)];
%     lambda2 = [max(lambda2,0),min(lambda2,0)];
%     lambda3 = [max(lambda3,0),min(lambda3,0)];
    lambda = [lambda1; 2*(gamma-1)*lambda2; lambda3];
    F =rho/2/gamma * R*lambda;
    Fblus(:,k) = F(:,1);
    Fminus(:,k) = F(:,2);
end

end

