% % testwood
Objfun = @ex_wood;
func = @func_exwood;
m  = 	30;
n =500;
Rule.opt = 2;
Rule.rho = 0.1;
Rule.nu = 0.9;
x0 = -ones(n,1);
for i = 1:2:n-1
    x0(i) = -3;
end

[x0,g0,f0,feva,ite] =  L_BFGS( Objfun,func,x0,m);
%  [x0,g0,f0,feva,ite] =  L_BFGS_B( Objfun,func,x0,m,Rule);
% [x0,g0,f0,feva,ite] =  L_SR1( Objfun,func,x0,m,1,Rule);     


g = @g_wood;
N = n/2 - 1;
index = cell(N,1);
for i = 1:N
    index{i} = 2*i-1:2*i+2;
end
% [x0,g0,f0,feva,ite] =  seprate_BFGS(func,x0,g,index,n,N,Rule );
% [x0,g0,f0,feva,ite] =  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);
fprintf('%d & %.2e &%.2e & %d & %d\n ',m,f0,norm(g0),ite,feva)