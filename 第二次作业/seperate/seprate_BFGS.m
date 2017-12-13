function [x,g_REAL,f0,fevaall,k] = seprate_BFGS(func,x,g,index ,n,N,Rule)
%UNTITLED3 可分BFGS方法对H的实现
%   input   
%         x   n_vector      初始点
%         g   function_handle   分片梯度函数  返回cell(N)
%         n    int    维数
%         N   int    分片数
%         index   cell(N)   第i个片中用到的x的下标 

Whole_H = cell(N,1);
Whole_g = g(x,n);
d = zeros(n,1);
MAX = 10000; 
epsilon = 1e-8;
% Rule.opt = 2;
for i = 1:N    %%第一步用负梯度 
    d(index{i}) = d(index{i}) - Whole_g{i};
end


g_REAL = g_real( Whole_g,index,n,N );
[alpha,feva] = linesearch(func, x,func(x),g_REAL, d, Rule);
fevaall = feva;
x1 = x+alpha*d;
Whole_g1 = g(x1,n);
Whole_s = s_seprate(x,x1,index,N);    
Whole_y = y_seprate(Whole_g,Whole_g1,N);
Whole_g = Whole_g1;

for i = 1:N    %%scaleing H0
    s = Whole_s{i};
    y = Whole_y{i};
    Whole_H{i} = eye(length(index{i}));
%     Whole_H{i} = y'*y/(s'*y)*eye(length(index{i}));
if y~=0;
    Whole_H{i} = s'*y/(y'*y)*eye(length(index{i}));
end
% if s ~= 0;
%      Whole_H{i} = s'*y/(s'*s)*eye(length(index{i}));
% end

%     Whole_H{i} = (s'*s)/(s'*y)*eye(length(index{i}));
end
f0 = func(x);
for k =1:MAX
    Whole_H = H_seprate( Whole_H,Whole_s,Whole_y,N);
    d = d_seprate( Whole_H,Whole_g,index,n,N);
    g_REAL = g_real( Whole_g1,index,n,N );
    f1 = func(x1)
    [alpha,feva] = linesearch(func, x1,f1,g_REAL, d, Rule);
    fevaall = fevaall + feva;
%     alpha = 1;
    x1 = x+alpha*d;
    Whole_g1 = g(x1,n);
%     if norm(g_REAL) < epsilon
%         break
%     end
    if abs(f1-f0)<1e-8
        break
    end
    f0 = f1;
    
    Whole_s = s_seprate(x,x1,index,N);
    x = x1;
    Whole_y = y_seprate(Whole_g,Whole_g1,N);
    Whole_g = Whole_g1;
end

end

