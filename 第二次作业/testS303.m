% % % testS303
n = 1000;
m = 30;
Objfun = @S303;
func = @S303;
g = @g_S303;
x0 = 0.1*ones(n,1);
Rule.opt=2;
Rule.rho = 0.1;
[x0,g0,f0,feva,ite] =  L_BFGS( Objfun,func,x0,m);
%  [x0,g0,f0,feva,ite]=  L_BFGS_B( Objfun,func,x0,m,Rule);
% [x0,g0,f0,feva,ite]=  L_SR1( Objfun,func,x0,m,1,Rule);     
index = cell(n,1);
N=3;
for i = 1:3
    index{i} = 1:n;
end
% [x0,g0,f0,feva,ite]=  seprate_BFGS(func,x0,g,index,n,N ,Rule);
% [x0,g0,f0,feva,ite] =  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);
fprintf('%d & %.2e &%.2e & %d & %d\n ',m,f0,norm(g0),ite,feva)