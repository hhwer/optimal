function [Whole_B ] = B_seprate( Whole_B,Whole_s,Whole_y,N)
%UNTITLED ֱ�ӽ���BFGS��B�ĸ���
%   �˴���ʾ��ϸ˵��
for i = 1:N
    s = Whole_s{i};
    y = Whole_y{i};
    B = Whole_B{i};
    rho = s'*y;
    if rho <= 0;
        continue
    end
    rho = 1/rho;
    p = B*s;
    Whole_B{i} = B + rho*y*y' - 1/(s'*p)*(p*p'); 
end
end