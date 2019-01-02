function [A,b,c] = getAbc(Model)
m = size(Model.A,1);
num1 = 0;
num2 = 0;
a1 = [];
a2 = [];
for i = 1:m
    if Model.rhs(i) < inf
        num1 = num1 + 1; 
        a1(num1) = i;
    end
    if Model.lhs(i) > -inf
        num2 = num2 + 1; 
        a2(num2) = i;
    end
end
A1 = Model.A(a1,:);
A2 = Model.A(a2,:);
b = [Model.rhs(a1);Model.lhs(a2)];
A = [A1,eye(num1),zeros(num1,num2);...
        A2,zeros(num2,num1),-eye(num2)];
c = [Model.obj;zeros(num1+num2,1)];
end
