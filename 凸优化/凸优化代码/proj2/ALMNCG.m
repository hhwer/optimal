function [x, out] = ALMNCG (c, A, b, opts, x0)
out = [];
phi=@(y,x,sigma)(b'*y+(norm(proj(x-sigma*(A'*y+c)),2)^2-x'*x)/(2*sigma));
[m,~] = size(A);
ep = opts.ep;
x = x0;
y = randn(m,1);
T = 200;
sigma = 2;
for i =1:T
    y1 = NCG(y,x,sigma);
    x1 = proj(x - sigma*(A'*y1+c));
    if norm(x-x1,inf)<ep
        break;
    end       
    x = x1;
    y = y1;
end
    function y =  NCG(y0,x,sigma)
        Mj = 15;
        mu = 0.3;
        etahat = 0.9;
        tau = 0.9;
        tau1 = tau;
        tau2 = tau;
        delta = 0.5;
        J = 3e2;
        y = y0;
        nj = 100;
        B = A';
        for j =1:J
            Q = proj(x-sigma*(A'*y+c));
            H = b-A*Q;
            W = norm(H);
            etaj = min([etahat,W^(1+tau)]);
            B((Q==0),:)= 0;
            V = sigma*A*B;
            epsilon = tau1*(min([tau2,W]));
            d = GC(V+epsilon*eye(m),-(H),etaj,nj);
            for mj = 1:Mj
                if phi(y+delta^mj*d,x,sigma)<=phi(y,x,sigma)+mu*delta^mj*((H)'*d)
                    break;
                end
            end
            alpha = delta^mj;
            y11 = y + alpha*d;
            if norm(y11-y,inf)<ep
                break;
            end
            y = y11;
        end
    end
    function x0 = GC(A,b,eta,imax)
        x0 = zeros(length(b),1);
        r0 = b;
        j = 0;
        r1 = r0;
        while norm(r1)>eta && j < imax
            j = j+1;
            if j == 1
                p = r0;
            else
                beta = (r1'*r1)/(r0'*r0);
                p = r1 + beta*p;
            end
            alpha = (r1'*r1)/(p'*A*p);
            x0 = x0 + alpha*p;
            r0 = r1;
            r1 = r1 - alpha*A*p;
        end
    end
    function w = proj (u)
        w = u.*(u>0);
    end
end