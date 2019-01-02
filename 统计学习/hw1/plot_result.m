function plot_result(is_correct)
global test;
each_corr_rate = zeros(1,10);
for i=1:10
    indx = test(1,:)==i-1;
    each_corr = is_correct(1,indx);
    each_corr_rate(i) = sum(each_corr)/length(each_corr);
end
bar(0:9,each_corr_rate);
xlabel('类别','fontsize',15);
ylabel('准确率','fontsize',15);
end