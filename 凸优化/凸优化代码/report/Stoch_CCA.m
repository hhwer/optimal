function [u,v] = Stoch_CCA(X, Y, T, k)
[n,d1] = size(X);
[~,d2] = size(Y);
n = n-1;
SXX = X'*X/n;  %d1*d1
SYY = Y'*Y/n;  %d2*d2
X = X';
Y = Y';
u = randn(d1,1);
u = u/normR(u,SXX);
v = randn(d2,1);
v = v/normR(v,SYY);
M = 200;
m = 10;
epsilon = 1e-7;
eta = 2;
for t = 1:T
    disp(t);
    fg = @(x)(X*(X'*x-Y'*v)/n+eta*x);
    u1 = SVRG(X,fg,eta,M,m,epsilon);
    u1 = u1/normR(u1,SXX);
    fg = @(x)(Y*(Y'*x-X'*u)/n+eta*x);
    v1 = SVRG(Y,fg,eta,M,m,epsilon);
    v1 = v1/normR(v1,SYY);
    if norm(u1-u)<epsilon && norm(v1-v)<epsilon
        break;
    end
    u = u1;
    v = v1;
%     disp(norm(u));
%     disp(norm(v));
end
u = u(:,1:k);
v = v(:,1:k);
    function y = normR(x,R)
        y = sqrt(x'*R*x);
    end
    function  u = SVRG(X,g,eta,M,m,epsilon)
        s = 0.001;
        [dx,N] = size(X);
        u = zeros(dx,1);
        u11 = u;
        ww = cell(m+1,1);
        for j =1:M
            w0 = u;
            g0 = g(w0);
            ww{1} = w0;
            for tt = 1:m
                i  = randi(N);
                ww{tt+1} = ww{tt} - s*((X(:,i)*X(:,i)'+eta*eye(dx))*(ww{tt}-w0)+g0);
            end
            tt = randi(m);
            u = ww{tt+1};
            if norm(u-u11)<epsilon
                break;
            end
            u11 = u;
%             disp(norm(u));
        end
    end
end