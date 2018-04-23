function [x4,result] = l1_gurobi(x0, A, b, mu, opts4);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
clear model
[m,n] = size(A);
model.A = [eye(n),zeros(n);eye(n),2*eye(n);zeros(m,n),A];
model.obj = ones(2*n,1);
model.rhs = zeros(2*n,1);
model.sense = repmat('>',2*n,1);
model.blc =[zeros(2*n,1);b];
model.buc = [inf*ones(2*n,1);b];
model.vtype = 'C';
modle.modelsense='min';
clear params;
params.outputflag = 0;   
result = gurobi(model, params);
x4 = result.x(n+1:2*n);
end

