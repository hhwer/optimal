function [ B_REAL ] = B_REAL( Whole,index ,n,N)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
B_REAL = sparse(n,n);
for i = 1:N
    B_REAL(index{i},index{i}) = B_REAL(index{i},index{i}) + Whole{i};
end
end

