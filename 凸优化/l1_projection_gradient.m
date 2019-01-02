function [x, f] = l1_projection_gradient(x0, A, b, mu, opts5)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(A);
% [a] = eig(A'*A);
% a = a(m);
B = A'*A;
c = [-A'*b+mu*ones(n,1);A'*b+mu*ones(n,1)];
epsilon = 1e-4;
delta = 1e-8;
tao = 0.01;
rho = 0.95;
sigma = 1e-5;
MAX = 10000;
MAX_ite = 100;
k = 1;
x = zeros(2*n,1);
for j = 1:n
    x(j) = max(x0(j),0);
    x(j+n) =max(-x0(j),0);
end
f=[];
d = -g(x);
f(k)=0.5*Q(d)+c'*x;
alpha = d'*d/Q(d);
while  k <= MAX
    %     alpha = d'*d/Q(d);
    x1 = max(x+alpha*d,0);
    d1 = x1-x;
%     g1 = tao*d1'*d;
    f_new = 0.5*Q(x1)+c'*x1;
%     alpha = 1;
%     Qd = 0.5*Q(d1,d1);
%     Qdx = Q(x,d1) + c'*d1;
%     for ite = 0:MAX_ite      %%armijo线搜索
%         if f_new <= f(k) - alpha*g1
%             break;
%         end
%         %     while f_new > f(k) - alpha*g1
%         alpha = alpha * rho;
%         %         x1 = x + alpha*d1;
%         %         f(k+1)=0.5*Q(x1)+c'*x1;
%         f_new = f(k) + alpha^2*Qd +  alpha*Qdx;
%     end
    f(k+1) = f_new;
%     x1 = x + alpha*d1;
    s = x1-x;
    if norm(s) <= delta || norm(d) <= epsilon
        break
    end
    
    d1 = -g(x1);
    y = -d1 + d;
    d = d1;
    k = k+1;
    %     disp(k)
    x = x1;
    alpha = (s'*s)/(s'*y);  %%BB步长
end

x = x(1:n)-x(n+1:2*n);
    function y = P(x11)  %%projection
        for l =1:2*n
            if x11(l)<0
                x11(l)=0;
            end
        end
        y = x11;
    end
    function y = Q(x11,y11)
        if nargin<2
            y =(x11(1:n)-x11(n+1:2*n));
            y = y'*B*y;
        else
            y = (x11(1:n)-x11(n+1:2*n));
            z = (y11(1:n)-y11(n+1:2*n));
            y = y'*B*z;
        end
    end

    function y =g(x11)
        y1 = x11(1:n);
        y2 = x11(n+1:2*n);
        %         y1 = A*y1;
        %         y2 = A*y2;
        %         y =[A'*y1 - A'*y2;-A'*y1+A'*y2]+c;
        y = [B*y1-B*y2];
        y = [y;-y] + c;
    end
% disp(f(k)+0.5*(b'*b));
end
    