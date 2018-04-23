function [ x1,lossf  ] =  sgBB(  a,b,x0,lambda,alpha1 )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   nΪf����,pΪxά��
%   a = matrix(n,p);  �����е�x1,x2,...,xn
%   b = vevtor(n);     �����е�y1,y2,...,yn
%   

[n,p] = size(a);
E = 2*n;
lossf = zeros(E,p);


for e = 1:E
%     lossf(e) = loss(a,b,x0);    %%ͳ��ʱ�仨��Ӧ��ȥ�� f �Ļ��� ����f��ʱռ��95%
lossf(e,:) = x0;
    s = randperm(n,1);
    ex = exp(-b(s)*x0*a(s,:)');
        if ex < inf
            sigma = ex/(1+ex);
        else
            sigma = 1;
        end
    gradsk = lambda * sign(x0) - b(s)*sigma*a(s,:);
%     disp(norm(gradsk))
    if e == 1
        alpha = alpha1;
    else
        yk = gradsk - gradsk0;
        alpha = (sk*yk')/(yk*yk');
        if isnan(alpha) || alpha == inf
            alpha = alpha1;
        end
    end
    sk = - alpha*gradsk;
    x1 = x0 +sk;
    x0 = x1;
    gradsk0 = gradsk;
end
end

