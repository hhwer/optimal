function w = GenELinK(A, B, T, k)
[d,~] = size(A);
w = normrnd(0,1,d,k);
w = GSB(w);
beta = norm(B);
alpha = min(abs(eig(B)));
Q = beta/alpha;
eta = 1/beta;
M = 1000;
epsilon = 5e-6;
for t = 1:T
    disp(t);
    tau = w'*A*w;
    x0 = w*tau;
    g = @(x)(B*x-A*w); 
    w1 = Nesterov(g,x0,Q,eta,M,epsilon);
%     disp(norm(w)^2);
    w1 = GSB(w1);
    if norm(w1-w,inf)<epsilon
        break;
    end
    w = w1;
%     disp(norm(w'*B*w-eye(k)));
end

function W =  GSB(W)
    for j = 1:k
        C = zeros(d,j-1);
        for jj = 1:j-1
            C(:,jj) = W(:,jj)*(W(:,j)'*B*W(:,jj));
        end
        W(:,j)=W(:,j)-sum(C,2);
        W(:,j)=W(:,j)/normB(W(:,j));
    end
end

function y = normB(x)
    y = sqrt(x'*B*x);
end

function y = Nesterov(g,x0,Q,eta,T,epsilon)
x = x0;
y = x;
for m = 1:T
    y1 = x - eta*g(x);
    x = y1 + (sqrt(Q)-1)/(sqrt(Q)+1)*(y1-y);
    if norm(y1-y,inf) < epsilon;
        break;
    end
    y = y1;
end
end      
end