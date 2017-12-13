Objfun = @ex_wood;
func = @func_exwood;
% Objfun = @gencube;
% func = @gencube;
% Objfun = @S303;
% func = @S303;
m  = 	10;
n =500;
Rule.opt = 2;
x0 = -ones(n,1);
for i = 1:2:n-1
    x0(i) = -3;
end

[x0,g0] =  L_BFGS( Objfun,func,x0,m);
%  [x0,g0] =  L_BFGS_B( Objfun,func,x0,m,Rule);
% [x0] =  L_SR1( Objfun,func,x0,m,1,Rule);        
% % % % 
% % wood
% g = @g_wood;
% N = n/2 - 1;
% index = cell(N,1);
% for i = 1:N
%     index{i} = 2*i-1:2*i+2;
% end
% % % [x0] =  seprate_BFGS(func,x0,g,index,n,N,Rule );
% [x0,g0] =  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);

%%gencube
% g = @g_gencube;
% N = n;
% x0 = 1:n;
% x0 = x0';
% index = cell(n,1);
% index{1} = 1;
% for i = 2:n
%     index{i} = i-1:i;
% end
% % % [x0] =  seprate_BFGS(func,x0,g,index,n,N,Rule)
% [x0,g0] =  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);
% 
% % % S303
% g = @g_S303;
% x0 = 0.1*ones(n,1);
% index = cell(n,1);
% N=3;
% for i = 1:3
%     index{i} = 1:n;
% end
% [x0] =  seprate_BFGS(func,x0,g,index,n,N ,Rule);
% % % % % % [x0,g0] =  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);
