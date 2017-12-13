function [r] = H_bfgs (S, Y, g)
%UNTITLED 计算d_{k}=-H_{k}g_{k}
%   intput
%   S =  [s_{k-m},s_{k-m+1},...,s_{k-1}]         k>=m    
%     or  [s_{0},s_{1},...,s_{k-1}]             k<m          
%   Y =  [y_{k-m},y_{k-m+1},...,y_{k-1}]         k>=m    
%     or  [y_{0},y_{1},...,y_{k-1}]             k<m         
%   g       n_vevtor    g_{k}
%       
%   
%output
%   r   n_vector   下降方向

[~,k] = size(S);
alpha = zeros(k);
rho = zeros(k);
for i = 1:k
    rho(i) = 1/(S(:,i)'*Y(:,i));
end
q = g;
for i = k:-1:1
    alpha(i) = rho(i)*(S(:,i)'*q);
    q = q - alpha(i)*Y(:,i);
end
r = 1/rho(k)/(Y(:,k)'*Y(:,k));
r = r*q;
for i = 1:k
    beta = rho(i)*(Y(:,i)'*r);
    r = r+ (alpha(i)-beta)*S(:,i);
end
r = -r;
end
