function [ f,g,G] = Funcs2( x )
% ≤‚ ‘Œ Ã‚2
%   
%intput
%           x    n_vector
%
%output
%
%           f      m_vector     [f1(x),f2(x),...,fm(x)]'
%           g     m_cell          {g1(x),g2(x),...,gm(x)}
%           G     m_cell         {G1(x),G2(x),...,Gm(x)}

f1 = @(x)x(1)^4+x(2)^2;
f2 = @(x)(2-x(1))^2+(2-x(2))^2;
f3 = @(x)2*exp(-x(1)+x(2));
f = [f1(x),f2(x),f3(x)]';
g1 = @(x) [4*x(1)^3, 2*x(2)]';
g2 = @(x) [-2*(2-x(1)), -2*(2-x(2))]';
g3 = @(x) [-f3(x),f3(x)]';
g = {g1(x),g2(x),g3(x)};
G1 = @(x) [12*x(1)^2,0;0,2];
G2 = @(x) [2,0;0,2];
G3 = @(x) [f3(x),-f3(x);-f3(x),f3(x)];
G = {G1(x),G2(x),G3(x)};
end

