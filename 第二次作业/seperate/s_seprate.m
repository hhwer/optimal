function [Whole_s] = s_seprate(x,x1,index,N);
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Whole_s = cell(N,1);
for i =1:N
    Whole_s{i} = x1(index{i}) - x(index{i});
end

end

