function [Whole_y] = y_seprate(Whole_g,Whole_g1,N);
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
for i =1:N
    Whole_y{i} = Whole_g1{i} - Whole_g{i};
end

end

