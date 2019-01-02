x = -10:0.01:10;
n = length(x);
mu = 0.1;
% huber
% f = x.^2/(2*mu).*(abs(x)<=mu)+(abs(x)-mu/2).*(abs(x)>mu);  
% plot(x,f);
% log-sum-exp
% f = mu.*log((exp(x/mu)+exp(-x/mu))./2);
% plot(x,f);
% g = (exp(x./mu)-exp(-x/mu))./(exp(x/mu)+exp(-x/mu));
% plot(x,g);
% sqrt
% f = sqrt(x.^2+mu^2)-mu;
% plot(x,f);