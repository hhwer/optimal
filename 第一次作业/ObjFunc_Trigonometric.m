function [ F,g,G ] = ObjFunc_Trigonometric( x )
%UNTITLED14 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
F = Trigonometric(x);
g = grid_Trigonometric(x);
G = Hessen_Trigonometric(x);
end