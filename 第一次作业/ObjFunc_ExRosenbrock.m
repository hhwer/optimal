function [ F,g ] = ObjFunc_ExRosenbrock( x )
%UNTITLED14 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
F = ExRosenbrock(x);
g = grid_ExRosenbrock(x);

end