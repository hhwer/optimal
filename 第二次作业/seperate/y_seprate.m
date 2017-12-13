function [Whole_y] = y_seprate(Whole_g,Whole_g1,N);
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
for i =1:N
    Whole_y{i} = Whole_g1{i} - Whole_g{i};
end

end

