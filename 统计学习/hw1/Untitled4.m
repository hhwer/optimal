% train = load('zip.train');
% X1 = train(:, 2:end);
% K = 10;
% lambda = 40;
% type = 0;
% [N, p] = size(X1);
% test = load('zip.test');
% X2 =test(:, 2:end);
% K = 10;
% lambda = 14;
% type = 0;
% [N, p] = size(X2);
% y = train(:, 1);
% y = test(:, 1);
% X = cell(K,1);
% y_out = zeros(N,1);
% for i = 1:K
%     X{i} = X1((y==i-1), :);
% end

correct = 0;
tic
for n = 1:200
    x0 = X1(n, :);
    y1 = likeli(x0, X ,  N, p, K, lambda, type);
     y_out(n)=y1;
     z = y(n)==y1;
     correct = correct + z;
     disp(correct/n)
end
t2 = toc;