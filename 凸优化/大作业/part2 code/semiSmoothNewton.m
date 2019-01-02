function [x, out] = semiSmoothNewton(x,A,b,c,Rule)
n = size(c,1);
Q = (A*A')^(-1);
D = eye(n) - A'*Q*A;
nu = Rule.nu;
eta1 = Rule.eta1;
eta2 = Rule.eta2;
gamma1 = Rule.gamma1;
gamma2 = Rule.gamma2;
epi = Rule.epi;
lambda = Rule.lambda;

t=1;
T = 10000;
z = x;
xi = norm(F(Q,A,b,c,t,z));
lambdak = 10*lambda;
for i =1:T
    Jk = J(D,z);
    Fz = F(Q,A,b,c,t,z);
    temp0 = norm(Fz);
    muk = lambdak*norm(Fz);
    s = -(Jk+muk*eye(n))\Fz;
    u = z+s;
    Fu = F(Q,A,b,c,t,u);
    temp1 = norm(Fu);
    if temp1 <= nu*xi
        z = u;
        xi = temp1;
    else
        rho = -Fu'*s/(s'*s);
        v = z - Fu'*(z-u)/temp1^2*Fu;
        w = z - Fz;
        if rho >= eta1
            temp2 = norm(F(Q,A,b,c,t,v));
            if temp2 < 0.9*temp0
                z = v;
            else
                z = w;
            end
        end
        if rho > eta2
            lambdak = (lambdak+lambda)/2;
        else
            if rho >= eta1
                lambdak = gamma1*lambdak;
            else
                lambdak = gamma2*lambdak;
            end
        end
        
    end
%     z = w;
    num = norm(F(Q,A,b,c,t,z));
    disp(num)
    if num < epi
        break;
    end
end
x = z;
x(x<0) = 0;
out.Fun = c'*x;
out.ite = i;
end