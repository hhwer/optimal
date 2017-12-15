function [r] = H_sr1 (Q,L,U,g,rho)
%UNTITLED 计算d_{k}=-H_{k}g_{k}
%   intput
%   Q =  [q_{k-m},q_{k-m+1},...,q_{k-1}]         k>=m    
%     or  [q_{0},q_{1},...,q_{k-1}]             k<m          
%                   q_{i} = s_{i} - y_{i}   
%  LU = M     m*m or k*k  matrix    
%   g       n_vevtor    g_{k}
%        
%   
%   output
%   r   n_vector   下降方向
p = Q'*g;
% p = U\(L\p);
p = L\(U\p);
g = Q*p + rho*g;
r = -g;
end

