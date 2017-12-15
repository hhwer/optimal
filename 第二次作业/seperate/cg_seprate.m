function [ x ] = cg_seprate( Whole_B,g_REAL,d,n,N,index)
%UNTITLED5 cg method for seprate Bx = -g_REAL
%   此处显示详细说明
epi = 1e-8;
x = d;  %initial
if nargin < 6
    r0 = g_REAL - Whole_B*x;
else
    r0 = g_REAL - Br_seperate( Whole_B,x,index,n,N );
end
p0 = r0;
k = 0;
while norm(r0) > epi
    if nargin < 6
        z = Whole_B *p0;
    else
        z = Br_seperate( Whole_B,p0,index,n,N );   %B*p0
    end
    alpha = (r0'*r0)/(p0'*z);
    x = x + alpha*p0;
    r1 = r0 -alpha*z;
    beta = (r1'*r1)/(r0'*r0);
    p0 = r1+beta*p0;
    r0 = r1;
    k = k+1;
%     disp(norm(r0));
end
    
x=-x;
end

