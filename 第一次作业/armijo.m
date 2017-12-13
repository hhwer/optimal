function [ x1,i ] = armijo(F,x0, G,g,Rule)
%UNTITLED2 2��armijo׼����������
%
%call    [X1,i] = armijo(F,x0,G,g,Rule)

%input
%   F:    Function [F] = Func(x)
%   x0    n_vector ��ʼ��x0
%   G     n*n matrix ��ʼ��hessen
%   g     n_vector ��ʼ���ݶ�
%   Rule    Rule.rho  ׼�����rho Ĭ��0.2
%           Rule.nu   ����nu    Ĭ��0.5

%output
%   x1   n_vector  �µĵ�����
%    i   scalar    �������ô���
n = size(G);
n = n(1);
if ~isfield(Rule,'rho')
    Rule.rho = 0.2;
end
if ~isfield(Rule, 'nu')
    Rule.nu = 0.5;
end
[V,D] = eig(G);
D = diag(D);
[dt,t] = min(D);
if dt < 0;  %�½��Ե�����
    s = -g;
    d = V(:,t);
    
else
    s = -g;
    d = zeros(n,1);
end
u = g'*s + 1/2*d'*G*d;
u = Rule.rho*u;
i = 0;
f0 = F(x0);
while 1
    t = Rule.nu^i;
    x1 = x0 + t^2*s + t*d;
    f1 = F(x1);
    if f1 <= f0 + u*t^2
        break
    end
    i = i + 1;
end

