function [ Whole_g ] = g_LMS( x,A,l )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

for i = 1:l-1
    A(i+1,2:l) = x((i-1)*(l-1)+1:i*(l-1));
end
r = zeros(l);
M = l^2;
for i = 1:l
    for j = 1:l
        r(i,j) = sqrt(1+M/2*((A(i,j)-A(i+1,j+1))^2+(A(i,j+1)-A(i+1,j))^2));
    end
end
Whole_g = cell(l^2,1);

for i = 2:l-1
    for j = 2:l-1
        Whole_g{(i-1)*l+j} =  [(A(i,j)-A(i+1,j+1)),(A(i,j+1)-A(i+1,j)),(A(i+1,j+1)-A(i,j)),(A(i+1,j)-A(i,j+1))]'/2/r(i,j);
    end
 end
for i = 2:l-1
    Whole_g{i} = [A(2,i+1)-A(1,i),A(2,i)-A(1,i+1)]'/2/r(1,i);
    Whole_g{i+l*(l-1)} = [A(l,i)-A(l+1,i+1),A(l,i+1)-A(l+1,i)]'/2/r(l,i);
    Whole_g{1 + (i-1)*l} = [A(i,2)-A(i+1,1),A(i+1,2)-A(i,1)]'/2/r(i,1);
    Whole_g{i*l} = [A(i,l)-A(i+1,l+1),A(i+1,l)-A(i,l+1)]'/2/r(i,l);
end
Whole_g{1} = (A(2,2)-A(1,1))/2/r(1,1);
Whole_g{l} = (A(2,l)-A(1,l+1))/2/r(1,l);
Whole_g{l*(l-1)+1} = (A(l,2)-A(l+1,1))/2/r(l,1);
Whole_g{l^2} = (A(l,l)-A(l+1,l+1))/2/r(l,l);

end