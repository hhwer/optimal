function [ out ] = Q( x,y,y_inverse,zeta,S )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
out = -log(det(y)) + trace(S*y)+trace((x-y)*(S-y_inverse)) + 1/2/zeta*norm(x-y,'fro')^2;
end

