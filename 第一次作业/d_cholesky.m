function [ d ] = d_cholesky( G,g,delta )
%UNTITLED3 通过修正chelesky分解决定的方向
%     
%input
%           G     n*n_matrix    hessen
%           g     n_vector      梯度
%           delta  scalar       修正的参数
%           
%output     
%           d     n_vector      下降方向

n = size(G);
n = n(1);
[l,d] = correctCholesky(G,delta);
E = l*diag(d)*l' - G;
E = diag(E);
%通过修正cholesky分解寻找负曲率方向
x = d - E;
[xt,t] = max(x);
if xt >= 0
    y = l\g;
    y = y ./ d;
    d = l'\y;
else
    et = zeros(n,1);
    et(t) = 1;
    d = l'\et;
end
if abs(g'*d) > 1e-12     %g与d几乎正交时,d总是下降方向
    if g'*d > 0             %g'd>= 0时 -d是下降方向 否则d即是下降方向
        d = -d;
    end
end
end

        
        
        


