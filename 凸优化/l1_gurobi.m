function [x4,result] = l1_gurobi(x0, A, b, mu, opts4);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
clear model
[~,n] = size(A);
model.Q = sparse(0.5*[A'*A,-A'*A;-A'*A,A'*A]);
model.A = sparse(eye(2*n));
model.obj = [-A'*b+mu*ones(n,1);A'*b+mu*ones(n,1)];
model.rhs = zeros(2*n,1);
model.sense = repmat('>',2*n,1);
model.lb =zeros(2*n,1);
model.vtype = 'C';
modle.modelsense='min';
clear params;
params.outputflag = 0;   
result = gurobi(model, params);
x4 = result.x(1:n)-result.x(n+1:2*n);
end

