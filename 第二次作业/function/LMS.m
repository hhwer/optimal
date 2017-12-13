function [ f,g ] = LMS( x,A,l )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1:l-1
    A(i+1,2:l) = x((i-1)*(l-1)+1:i*(l-1));
end
r = zeros(l);
M = l^2;
f = 0;
for i = 1:l
    for j = 1:l
        r(i,j) = sqrt(1+M/2*((A(i,j)-A(i+1,j+1))^2+(A(i,j+1)-A(i+1,j))^2));
        f = f+r(i,j);
    end
end
f = f/M;
if nargout > 1
    g = zeros((l-1)^2,1);
    for i = 2:l
        for j = 2:l
            g((i-2)*(l-1)+j-1) = (A(i,j)-A(i-1,j-1))/r(i-1,j-1) +  (A(i,j)-A(i-1,j+1))/r(i-1,j) + ...
                                               (A(i,j)-A(i+1,j+1))/r(i,j)  + (A(i,j)-A(i+1,j-1))/r(i,j-1);
        end
    end
    g = g/2;
end
end

