function [y] = B_bfgs (vectorA, vectorB, g)
%UNTITLED 计算B_{k}d_{k} =-g_{k}
%   intput
%   vectorA =  [a_{k-m},a_{k-m+1},...,a_{k-1}]         k>=m    
%     or  [a_{0},a_{1},...,a_{k-1}]             k<m          
%   vectorB =  [b_{k-m},b_{k-m+1},...,b_{k-1}]         k>=m    
%     or  [b_{0},b_{1},...,b_{k-1}]             k<m         
%   g       n_vevtor    g_{k}
%       
%   
%output
%   r   n_vector   下降方向

f = @(x)Br_bfgs(vectorA,vectorB,x);
[y,flag] = pcg(f,-g,1e-8,800);
if flag==4
    y = -g;
    return 
end

end
