function [ x,g_REAL,f0,fevaall,k ] = Bseprate_BFGS(func,x,g,index ,n,N,Rule)
%UNTITLED3 �ɷ�BFGS������B��ʵ��
%   input   
%         x   n_vector      ��ʼ��
%         g   function_handle   ��Ƭ�ݶȺ���  ����cell(N)
%         n    int    ά��
%         N   int    ��Ƭ��
%         index   cell(N)   ��i��Ƭ���õ���x���±� 

Whole_B = cell(N,1);
Whole_g = g(x,n);
MAX = 10000; 
epsilon = 1e-10;
% Rule.opt = 3;
% for i = 1:N    %%��һ���ø��ݶ� 
%     d(index{i}) = d(index{i}) - Whole_g{i};
% end


g_REAL = g_real( Whole_g,index,n,N );
d = -g_REAL;
% alpha = 1;
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
%     Whole_B{i} = y'*y/(s'*y)*eye(length(index{i}));
%     Whole_B{i} = s'*y/(y'*y)*eye(length(index{i}));
%     Whole_B{i} = s'*y/(s'*s)*eye(length(index{i}));
    Whole_B{i} = eye(length(index{i}));
end
f0 = func(x);

for k =1:MAX
    Whole_B = B_seprate( Whole_B,Whole_s,Whole_y,N);
    g_REAL = g_real( Whole_g1,index,n,N );
%     d = cg_seprate( Whole_B,g_REAL,d,n,N,index);
%     d = -B_REAL(Whole_B,index,n,N)\g_REAL;
    B_real = B_REAL(Whole_B,index,n,N);
    M = abs(diag(B_real)).^-(1/2);
    [d,flag] = pcg(B_real,-g_REAL,1e-6,800,diag(M));
    if flag ==4;
        d = -g_REAL;
    end
%         d = -M.*((M.*B_real.*M')\(M.*g_REAL));
%     d = cg_seprate( B_real,g_REAL,d);
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