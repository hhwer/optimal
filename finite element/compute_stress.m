function [S1,S2,S12] = compute_stress(E1,E2,E12)
lambda = 3.65e04;
mu = 1.5250e04;
nu = lambda/2/(lambda+mu);
E3 = -nu/(1-nu)*(E1+E2);
S1 = lambda*(E1+E2+E3)+2*mu*E1;
S2 = lambda*(E1+E2+E3)+2*mu*E2;
S12 = 2*mu*E12;
end