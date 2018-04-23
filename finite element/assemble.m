function [K,F] = assemble(Ke,en,N)
M = 2*N*N;
g = 1;
h = 0.1/N;
K = sparse((N+1)*(N+1)*2,(N+1)*(N+1)*2);
F = sparse((N+1)*(N+1)*2,1);
for e = 1:M
    for alpha = 1:6
        for beta = 1:6
            K(en(alpha,e),en(beta,e)) =...
                K(en(alpha,e),en(beta,e))+...
                Ke{2-mod(e,2)}(alpha,beta);
        end
    end
end
F(en(1,2*N*(N-1)+1)) = sqrt(2)*h/4*g;
F(en(3,2*N*(N-1)+1)) = sqrt(2)*h/4*g;
F(en(5,2*N*(N-1)+1)) = -sqrt(2)*h/4*g;
F(en(6,2*N*(N-1)+1)) = -sqrt(2)*h/4*g;
for i=1:N+1
    K(i,:)=0;
    K(:,i)=0;
    K(i+(N+1)^2,:)=0;
    K(:,i+(N+1)^2)=0;
    K(i,i)=1;
    K(i+(N+1)^2,i+(N+1)^2)=1;
end
end