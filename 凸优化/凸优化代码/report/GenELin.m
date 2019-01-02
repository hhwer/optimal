function w = GenELin(A, B, T)
[d,~] = size(A);
w = randn(d,1);
w = w/normB(w);
beta = norm(B);
alpha = min(abs(eig(B)));
Q = beta/alpha;
eta = 1/beta;
M = 1000;
epsilon = 1e-7;
disp(w'*A*w);
for t = 1:T
    beta1 = w'*A*w;
    x0 = beta1*w;
    g = @(x)(B*x-A*w); 
    w1 = Nesterov(g,x0,Q,eta,M,epsilon);
%     disp(norm(w)^2);
    w1 = w1/normB(w1);
    if norm(w1-w)<epsilon
        break;
    end
    w = w1;
end
function y = normB(x)
    y = sqrt(x'*B*x);
end

function y = Nesterov(g,x0,Q,eta,T,epsilon)
x = x0;
y = x;
for k = 1:T
    y1 = x - eta*g(x);
    x = y1 + (sqrt(Q)-1)/(sqrt(Q)+1)*(y1-y);
    if norm(y1-y) < epsilon;
        break;
    end
    y = y1;
end
end
end