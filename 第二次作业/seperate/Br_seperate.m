function [ y ] = Br_seperate( Whole_B,r,index,n,N )
%UNTITLED   compute  B'*r
%   �˴���ʾ��ϸ˵��
y = zeros(n,1);
for i =1:N
    y(index{i}) = y(index{i}) + Whole_B{i} * r(index{i});
end

end

