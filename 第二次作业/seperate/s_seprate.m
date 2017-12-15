function [Whole_s] = s_seprate(x,x1,index,N);
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
Whole_s = cell(N,1);
for i =1:N
    Whole_s{i} = x1(index{i}) - x(index{i});
end

end

