function [g ] = g_real( Whole_g,index,n,N )
%UNTITLED6  �����ݶȵķ���
%   �˴���ʾ��ϸ˵��
g = zeros(n,1);
for i =1:N
    g(index{i}) = g(index{i})+Whole_g{i};
end
end

