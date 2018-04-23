function [en,Ke] =  order(N,lambda,mu)
%get global number and unit matrix
%
%input
%       N                    int                             question scale
%       lambda,mu     scalar                        parameter
%
%output
%       en                   2*N^2,6matrix         global number of node
%       Ke                   1*2 cell                     unit matrix 
M = 2*N^2;
en = zeros(M,6);
n0 = (N+1)^2;

for i = 1:N
    for j = 1:N
        K = (2*i-1) + (j-1)*(2*N);
        num = (j-1)*(N+1) + i;
        en(K,1)=num;
        en(K,2)=num + N+2;
        en(K,3)=num + N+1;
        en(K,4:6) = en(K,1:3) + n0;
        en(K+1,1)=num;
        en(K+1,2)=num + 1;
        en(K+1,3)=num + N+2;
        en(K+1,4:6) = en(K+1,1:3) + n0;
    end
end
Ke = cell(2,1);
nabla = [0,1,-1;-1,0,1];
temp = [nabla(1,:),nabla(2,:)];
Ke{1} = lambda*(temp'*temp);
temp = mu*(nabla'*nabla);
Ke{1}(1:3,1:3) = Ke{1}(1:3,1:3) + temp;
Ke{1}(4:6,4:6) = Ke{1}(4:6,4:6) + temp;
Ke{1} = Ke{1} + mu*[nabla(1,:)'*nabla(1,:),nabla(2,:)'*nabla(1,:);nabla(1,:)'*nabla(2,:),nabla(2,:)'*nabla(2,:)];
Ke{1} = Ke{1}/2;
nabla = [-1,1,0;0,-1,1];
temp = [nabla(1,:),nabla(2,:)];
Ke{2} = lambda*(temp'*temp);
temp = mu*(nabla'*nabla);
Ke{2}(1:3,1:3) = Ke{2}(1:3,1:3) + temp;
Ke{2}(4:6,4:6) = Ke{2}(4:6,4:6) + temp;
Ke{2} = Ke{2} + mu*[nabla(1,:)'*nabla(1,:),nabla(2,:)'*nabla(1,:);nabla(1,:)'*nabla(2,:),nabla(2,:)'*nabla(2,:)];
Ke{2} = Ke{2}/2;
end