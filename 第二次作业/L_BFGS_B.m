function [ x0,g0,f0,fevaall,k ] = L_BFGS_B( Objfun,func,x0,m,Rule,epi)
%UNTITLED2 ����L_BFGS������NEWTON���� ����B
%   input
%   Objfun      Function_handle  [f,g,G]=Objfun(x) Ϊ�ݶ��Լ�hessen����
%   grid          Function_handle   [g] = grid(x)    �ݶ�
%   func          Fucnction_handle  [f]  = func(x)  ����ֵ
%   x0             n_vector     ��ʼ��
%   m              int              �洢����
%   epi            scalar         ��ֹ����
if nargin < 6
    epi = 1e-8;
end
% Rule.opt = 2; %%������׼��Ϊarmijo
if ~isfield(Rule,'rho')
     Rule.rho = 0.1;
end
MAX = 100000;
[f0,g0] = Objfun(x0);
d = -g0;
% alpha = 1;
[alpha,feva] = linesearch(func, x0,f0,g0, d, Rule);
fevaall = feva;
x1 = x0+alpha*d;
[f1,g1] = Objfun(x1);
s = x1 - x0;
y = g1 - g0;
x0  = x1;
g0 = g1;
vectorA =[];
vectorB = [];
BS = [];
S = [];

for k = 1:MAX 
    [ S,vectorA,vectorB,BS ] = Update_B( S,vectorA,vectorB,BS,s,y,m );
    d = B_bfgs (vectorA, vectorB, g1);
    [alpha,feva] = linesearch(func, x0,f0,g0, d, Rule);
    fevaall = fevaall + feva;
    x1 = x0 + alpha  * d;
    [f1,g1] = Objfun(x1);
    if abs(f1-f0)<1e-8;
        break;
    end
    s = x1 - x0;
    y = g1 - g0;
    x0 = x1;
    f0 = f1;
    g0 = g1;
    disp(f1)
end
disp(f1-f0);
end