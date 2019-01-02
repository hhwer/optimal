function ret = test()
% rand('seed',0);

n = 100;
d1 = 20;
d2 = 15;
k = 5;
x = rand(n, d1);
y = rand(n, d2);
max_iters = 10000;
sep_iters = 1000;
% Nesterov²ÎÊı
max_inner_iters = 1000;
epsilon = 5e-6;

test_CCALin(x, y, k, max_iters, sep_iters, max_inner_iters, epsilon);

end




