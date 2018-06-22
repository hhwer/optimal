g = 500;
[x4,lossf4] = msvrg( a,b,hatx0,lambda,g*alpha,K);
v = exp(-x4'*a.*b');
 norm(mean(v./(1+v).*a.*b',2))
 disp(g)
