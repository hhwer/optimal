function [x1, f0,k,t,ite,output] = Newton ( func, Objfun, x0, epi,status,Rule)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   intput
%   func    Function_handle  [F] = func(x);    Ŀ�꺯��
%   Objfun  Function_handle  [F,g,G] = func(x); Ŀ�꺯����һ���׵�
%   x       n_vevtor    ��ʼ��
%   epi     scalar      ��ֹ����
%   status  int   method 
%             status = 0 ������ţ��
%             status = 1 ����ţ��
%             status = 2 ��������
%   Rule    ���linesearch�Լ�d_cholesky
%   
%output
%   x1    n_vector   ��ֹ��
%   f0    scalar     ���պ���ֵ
%   k     scalar     ��������
%   t     scalar     ����½���
%   ite   scalar     ��������
%   output  k_vector ��ʷ����ֵ

k = 0;
[f0,g0,G0] = Objfun(x0);
output(:,1) = f0;
ite = 1;
while k < 50000
    if status == 0
        d = -G0\g0;
        [al,feva] = linesearch(func, x0,g0 ,d, Rule);
        x1 = x0 + al*d;
    elseif status == 1
        d = d_cholesky(G0,g0,Rule.delta);
        [al,feva] = linesearch(func, x0,g0, d, Rule);
        x1 = x0 + al*d;
    else
        [x1,feva] = armijo(func,x0, G0,g0,Rule);
    end
    ite = ite + feva;
    [f1,g0,G0] = Objfun(x1);
    t = f1-f0;
    if abs(t) < epi
        break
    end
    x0 = x1;
    f0 = f1;
    k = k+1;
    output(k) = f0;
end
   
end

