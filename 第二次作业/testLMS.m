%%test LMS
l = 100;
n = (l-1)^2;
m = 12;
Rule.opt = 2;
Rule.rho = 0.5;
Rule.nu = 0.9;
x0 = zeros(n,1);
square = zeros(l+1);
for i = 1:l+1
    square(1,i) = 9 + 4*(i-1)/l; 
    square(l+1,i) = 1 + 4*(i-1)/l;
    square(i,1) = 9 - 8*(i-1)/l;
    square(i,l+1) = 13 - 8*(i-1)/l;
end
Objfun = @(x)LMS(x,square,l);
func = @(x)LMS(x,square,l);
[x0,g0,f0,feva,ite] =  L_BFGS( Objfun,func,x0,m,Rule);
%  [x0,g0,f0,feva,ite]  =  L_BFGS_B( Objfun,func,x0,m,Rule);
% [x0,g0,f0,feva,ite] =  L_SR1( Objfun,func,x0,m,1,Rule);        

g = @(x,n)g_LMS(x,square,l);
N = l^2;
index = cell(N,1);
for i = 2:l-1
    for j = 2:l-1
        index{(i-1)*l+j} = [((i-2)*(l-1)+j-1),((i-2)*(l-1)+j),((i-1)*(l-1)+j),((i-1)*(l-1)+j-1)];
    end
end
for i = 2:l-1
    index{i} = [(i),(i-1)];
    index{i+l*(l-1)} = [((l-1)*(l-2)+i-1),((l-1)*(l-2)+i)];
    index{1 + (i-1)*l} = [((i-2)*(l-1)+1),((i-1)*(l-1)+1)];
    index{i*l} = [((i-2)*(l-1)+l-1),((i-1)*(l-1)+l-1)];
end
index{1} = [1];
index{l} = [l-1];
index{l*(l-1)+1} = [(l-1)*(l-2)+1];
index{l^2} = [(l-1)^2];
% [x0,g0,f0,feva,ite] =  seprate_BFGS(func,x0,g,index,n,N,Rule );
% [x0,g0,f0,feva,ite] =  Bseprate_BFGS(func,x0,g,index,n,N ,Rule);      %%≤ªº”scaleƒ‹À„


fprintf('%d & %.2e &%.2e & %d & %d\n ',m,f0-9,norm(g0),ite,feva)

% for i = 1:l-1
%     square(i+1,2:l) = x0((i-1)*(l-1)+1:i*(l-1));
% end
% x = 0:1/l:1;
% y = x;
% [X,Y] = meshgrid(x,y);
% mesh(X,Y,square)