function [ S,vectorA,vectorB,BS ] = Update_B( S,vectorA,vectorB,BS,s,y,m )
%UNTITLED3 BFGS对B的更新
% intput
%       BS(i,j) = b_{i}'s_{j}   上三角


rho = 1;   %% B_{k}^{0} = rho*I;
rho = s'*y/(y'*y);
z = s'*y;
if s'*y <= 0
    return
end
z = sqrt(z);
n = length(s);
[~,k] = size(vectorB);
if k < m
    vectorA = zeros(n,k+1);
    vectorB(1:n,k+1) = 0;
    BS(1:k+1,k+1) = [vectorB'*s];
    vectorB(:,k+1) = y/z;
    S(:,k+1) = s;
    for i = 1:k+1
        vectorA(:,i) = rho*S(:,i) + vectorB(:,1:i-1)*(vectorB(:,1:i-1)'*S(:,i)) - ...
                                                   vectorA(:,1:i-1)*(vectorA(:,1:i-1)'*S(:,i));
        vectorA(:,i) =  vectorA(:,i)/sqrt(vectorA(:,i)'*S(:,i));
    end
else
    vectorA = zeros(n,m);
    vectorB = [vectorB(:,1:m-1),y/z];
    BS(1:m-1,1:m-1) = BS(2:m,2:m);
    BS(1:m-1,m) = vectorB(:,1:m-1)'*s;
    S(:,k+1) = s;
    for i = 1:m
        vectorA(:,i) = rho*S(:,i) + vectorB(:,1:i-1)*(vectorB(:,1:i-1)'*S(:,i)) - ...
            vectorA(:,1:i-1)*(vectorA(:,1:i-1)'*S(:,i));
        vectorA(:,i) =  vectorA(:,i)/sqrt(vectorA(:,i)'*S(:,i));
    end
end

end

