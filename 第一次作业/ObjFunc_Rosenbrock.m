function [ F,g ] = ObjFunc_Rosenbrock( x )
%UNTITLED14 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
F = Rosenbrock(x);
g = grid_Rosenbrock(x);

end

