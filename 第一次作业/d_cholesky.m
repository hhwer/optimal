function [ d ] = d_cholesky( G,g,delta )
%UNTITLED3 ͨ������chelesky�ֽ�����ķ���
%     
%input
%           G     n*n_matrix    hessen
%           g     n_vector      �ݶ�
%           delta  scalar       �����Ĳ���
%           
%output     
%           d     n_vector      �½�����

n = size(G);
n = n(1);
[l,d] = correctCholesky(G,delta);
E = l*diag(d)*l' - G;
E = diag(E);
%ͨ������cholesky�ֽ�Ѱ�Ҹ����ʷ���
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
if abs(g'*d) > 1e-12     %g��d��������ʱ,d�����½�����
    if g'*d > 0             %g'd>= 0ʱ -d���½����� ����d�����½�����
        d = -d;
    end
end
end

        
        
        


