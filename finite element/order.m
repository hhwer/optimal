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
nabla1 = [0,-1;1,0;-1,1];
Ke{1} = lambda*([nabla1(:,1);nabla1(:,2)]*[nabla1(:,1);nabla1(:,2)]');
Ke{1}(1:3,1:3) = Ke{1}(1:3,1:3) + mu*(nabla1*nabla1');
Ke{1}(4:6,4:6) = Ke{1}(4:6,4:6) + mu*(nabla1*nabla1');
Ke{1} = Ke{1} + mu*[nabla1(:,1)*nabla1(:,1)',nabla1(:,2)*nabla1(:,1)';nabla1(:,1)*nabla1(:,2)',nabla1(:,2)*nabla1(:,2)'];
Ke{1} = Ke{1}/2;

nabla1 = [-1,0;1,-1;0,1];
Ke{2} = lambda*([nabla1(:,1);nabla1(:,2)]*[nabla1(:,1);nabla1(:,2)]');
Ke{2}(1:3,1:3) = Ke{2}(1:3,1:3) + mu*(nabla1*nabla1');
Ke{2}(4:6,4:6) = Ke{2}(4:6,4:6) + mu*(nabla1*nabla1');
Ke{2} = Ke{2} + mu*[nabla1(:,1)*nabla1(:,1)',nabla1(:,2)*nabla1(:,1)';nabla1(:,1)*nabla1(:,2)',nabla1(:,2)*nabla1(:,2)'];
Ke{2} = Ke{2}/2;
end