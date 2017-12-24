function [f,g,G] = Funcs_filter(x)
%²âÊÔÎÊÌâdigital filter
%   
%intput
%           x    n_vector
%
%output
%
%           f      m_vector     [f1(x),f2(x),...,fm(x)]'
%           g     m_cell          {g1(x),g2(x),...,gm(x)}
%           G     m_cell         {G1(x),G2(x),...,Gm(x)}

m = 41;
f = zeros(2*m,1);
for i = 1:6
    phi = 0.0 + 0.01*(i-1);
    if nargout > 1
        [f0,g0,G0] = e(x,phi);
        f(2*i-1) = f0;
        g{2*i-1} = g0;
        G{2*i-1} = G0;
        f(2*i) = -f0;
        g{2*i} = -g0;
        G{2*i} = -G0;
    else
        f(2*i-1) = e(x,phi);
        f(2*i) = -e(x,phi);
    end
end



for i = 7:20
    phi = 0.07 + 0.03*(i-7);
    if nargout > 1
        [f0,g0,G0] = e(x,phi);
        f(2*i-1) = f0;
        g{2*i-1} = g0;
        G{2*i-1} = G0;
        f(2*i) = -f0;
        g{2*i} = -g0;
        G{2*i} = -G0;
    else
        f(2*i-1) = e(x,phi);
        f(2*i) = -e(x,phi);
    end
end

for i = 21:22
    phi = 0.5 + 0.04*(i-21);
    if nargout > 1
        [f0,g0,G0] = e(x,phi);
        f(2*i-1) = f0;
        g{2*i-1} = g0;
        G{2*i-1} = G0;
        f(2*i) = -f0;
        g{2*i} = -g0;
        G{2*i} = -G0;
    else
        f(2*i-1) = e(x,phi);
        f(2*i) = -e(x,phi);
    end
end


for i = 23:24
    phi = 0.57 + 0.1*(i-23);
    if nargout > 1
        [f0,g0,G0] = e(x,phi);
        f(2*i-1) = f0;
        g{2*i-1} = g0;
        G{2*i-1} = G0;
        f(2*i) = -f0;
        g{2*i} = -g0;
        G{2*i} = -G0;
    else
        f(2*i-1) = e(x,phi);
        f(2*i) = -e(x,phi);
end

for i = 25:35
    phi = 0.63 + 0.03*(i-25);
    if nargout > 1
        [f0,g0,G0] = e(x,phi);
        f(2*i-1) = f0;
        g{2*i-1} = g0;
        G{2*i-1} = G0;
        f(2*i) = -f0;
        g{2*i} = -g0;
        G{2*i} = -G0;
    else
        f(2*i-1) = e(x,phi);
        f(2*i) = -e(x,phi);
    end
end

for i = 36:41
    phi = 0.95 + 0.01*(i-36);
    if nargout > 1
        [f0,g0,G0] = e(x,phi);
        f(2*i-1) = f0;
        g{2*i-1} = g0;
        G{2*i-1} = G0;
        f(2*i) = -f0;
        g{2*i} = -g0;
        G{2*i} = -G0;
    else
        f(2*i-1) = e(x,phi);
        f(2*i) = -e(x,phi);
    end
end
end