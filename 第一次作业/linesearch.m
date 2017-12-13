function [stepsize,feva] = linesearch(Func, Point,g0, direction, Rule)
% linesearch ������Ż����� P: a = argmin f(x+a*d)
%
% �����������ѡ��ʹ�þ�ȷ��Ǿ�ȷ��������������⡣
% ��ȷ��������ʹ��0.618�������;
% �Ǿ�ȷ������������ѡ��Goldstein, Wolfe, ǿWolfe��������׼��
% ʹ��������β�ֵ����
%
% Call
% [StepSize,err,feva] = linesearch(Func, Point, direction)
% [StepSize,err,feva] = linesearch(Func, Point, direction, Rule)
% 
% Input 
% Func:    function_handle, [F,g]=Func(x)
%                                       or   [F] = Func(x)
%                            F:����ֵ g:�ݶ�����
% Point:      n-vector, ��ʼ��x
% direction:  n-vector, ����d
% g0          n_vector  �ݶ�g
% Rule:       struct,�������ķ�����׼��
%    Rule.opt:1:��ȷ��������ʹ��0.618���� Ĭ��
%             2:�Ǿ�ȷ������ 1��armijo׼��
%    Rule.rho:�ж�׼���е�rho  Ĭ��0.2
%    Rule.nu   ����nu          Ĭ��0.5
%             
%   
% Output
% stepsize: scalar,����P�Ľ�,��������� 
% feva:      scalar,�������ô���
%

Tercond = 1e-8;


Max = 500;   %���ѭ������
feva = 0;
if Rule.opt ~= 2     %�ж��������ķ�����׼��
    [stepsize,feva] = dot618(Func,Point,direction,Tercond);
elseif Rule.opt == 2
    if ~isfield(Rule,'rho')
        Rule.rho = 0.2;
    end
    if ~isfield(Rule,'nu')
        Rule.nu = 0.5;
    end
    f0=Func(Point);
    feva = feva+1;
    u  = Rule.rho * g0' * direction;
    i = 0;
    t = 1;
    while 1
       x1 = Point + t*direction;
       f1 = Func(x1);
       if f1 <= f0 + u*t^2
           stepsize = t;
           break
       elseif i > Max
           stepsize = t;
           break
       end
       t = t  * Rule.nu;
       i = i + 1;
    end

end