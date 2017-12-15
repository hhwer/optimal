function [ B_REAL ] = B_REAL( Whole,index ,n,N)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
B_REAL = sparse(n,n);
for i = 1:N
    B_REAL(index{i},index{i}) = B_REAL(index{i},index{i}) + Whole{i};
end
end

