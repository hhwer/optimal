function [K,F] = getGlobalK(N,Ke,en,f)
%get  globla matrix and right item
%
%input    
%       N           int                            question scalar
%       Ke         1*2 cell                    unit matrix
%       en         2*N^2,6matrix        global number of node
%       f            scalar                       parameter
%
%output
%       K          sparse matrix           global matrix
%       F           sparse vector           right item
M = 2*N^2; 
n0 = 2*(N+1)^2;
h = 0.1/N;
K = spalloc(n0 ,n0,18*n0);
F = spalloc(n0 ,1,4);
for k = 1:M
    for i = 1:6
        for j = 1:6
            K(en(k,i),en(k,j)) = K(en(k,i),en(k,j))+Ke{2-mod(k,2)}(i,j);
        end
    end
end
n0 = 2*N*(N-1)+1;
c = sqrt(2)*h/4*f;
F(en(n0,1)) = c;
F(en(n0,3)) = c;
F(en(n0,5)) = -c;
F(en(n0,6)) = -c;
n0 = (N+1)^2;
i = 1:N+1;
K(i,:)=0;
K(:,i)=0;
K(i+n0,:)=0;
K(:,i+n0)=0;
for i=1:N+1
    K(i,i)=1;
    K(i+(N+1)^2,i+(N+1)^2)=1;
end
end