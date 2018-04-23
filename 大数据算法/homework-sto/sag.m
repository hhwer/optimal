function [ x1,lossf ] = sag( a,b,x0,lambda,alpha)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   nΪf����,pΪxά��
%   a = matrix(n,p);  �����е�x1,x2,...,xn
%   b = vevtor(n);     �����е�y1,y2,...,yn
%   

[n,p] = size(a);
E = n;
lossf = zeros(E,p);

grady = zeros(n,p);   %%recent gradient of each component f
for j = 1:n
    ex = exp(-b(j)*x0*a(j,:)');
    grady(j,:) = lambda * sign(x0) - b(j)*ex/(1+ex)*a(j,:);  %%
end
g = mean(grady);
for e = 1:E
%     lossf(e) = loss(a,b,x0);    %%ͳ��ʱ�仨��Ӧ��ȥ��f�Ļ��� ����f��ʱռ��95%
lossf(e,:) = x0;
    sk = randperm(n,1);
    ex = exp(-b(sk)*x0*a(sk,:)');
        if ex < inf
            sigma = ex/(1+ex);
        else
            sigma = 1;
        end
    gradsk = lambda * sign(x0) - b(sk)*sigma*a(sk,:);
    g = g + (gradsk - grady(sk,:))/n;
    grady(sk,:) = gradsk;
     
%     nor = norm(g-lambda*sign(x0));
%     disp(nor);
%     
%     if nor < 1e-6
%         return
%     end
    
    x1 = x0 - alpha*g;
    x0 = x1;
end
    
end