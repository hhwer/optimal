function [Whole_H ] = H_seprate( Whole_H,Whole_s,Whole_y,N)
%UNTITLED ֱ�ӽ���BFGS��H�ĸ���
%   �˴���ʾ��ϸ˵��
for i = 1:N
    s = Whole_s{i};
    y = Whole_y{i};
    H = Whole_H{i};
    rho = s'*y;
    if rho == 0
        return
    end
    rho = 1/rho;
    p = H*y;
    Whole_H{i} = H + (1+rho*(y'*p))*rho*(s*s') - rho*(s*p' + p*s');
end
end

