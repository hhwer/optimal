function[sigmaN,omega] =  get_model(k)
n = 100;
p = 30;
u = zeros(p,1);
% % % model 1
if k == 1
    for i = 1:p
        for j = 1:p
            omega(i,j) = 0.6^(abs(i-j));
        end
    end
% % model 2
else
    while 1
        B = zeros(p);
        a = rand(1,p^2);
        reshape(a,p,p);
        B(a>0.9) = 0.5;
        for i = 1:p
            B(i,i) = 0;
            for j = i+1:p
                B(i,j)=B(j,i);
            end
        end
        q2 = eig(B);
        delta = (q2(1)-p*q2(p))/(p-1);
        omega = B + delta*eye(p);
        omega = omega/delta;
        [q11,q22,q33]=svd(omega);
        if abs(q22(1,1)/q22(p,p) - p)<1e-10;
            break
        end
    end
end
X = mvnrnd(u,(omega)^(-1),100);
sigmaN = cov(X)*p/(p-1);
end
