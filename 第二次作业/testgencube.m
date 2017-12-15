Objfun = @gencube;
func = @gencube;
m  = 	30;
n =1000;
Rule.opt = 2;
x0 = -ones(n,1);
for i = 1:2:n-1
    x0(i) = -3;
end
[x0,g0,f0,feva,ite]=  L_BFGS( Objfun,func,x0,m);
%  [x0,g0,f0,feva,ite]=  L_BFGS_B( Objfun,func,x0,m,Rule);
% [x0,g0,f0,feva,ite]=  L_SR1( Objfun,func,x0,m,1,Rule);    
% 
g = @g_gencube;
N = n;
index = cell(n,1);
index{1} = 1;
for i = 2:n
    index{i} = i-1:i;
end
% [x0,g0,f0,feva,ite]=  seprate_BFGS(func,x0,g,index,n,N,Rule)  ;
% [x0,g0,f0,feva,ite]=  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);      %%²»¼Óscarling

fprintf('%d & %.2e &%.2e & %d & %d\n ',m,f0,norm(g0),ite,feva)