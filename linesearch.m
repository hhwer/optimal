function [stepsize,feva] = linesearch(Func, Point,f0,g0, direction, Rule)
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
% f0           scalar    f(x0)
% g0          n_vector  �ݶ�g
% Rule:       struct,�������ķ�����׼��
%    Rule.opt:1:��ȷ��������ʹ��0.618���� Ĭ��
%             2:�Ǿ�ȷ������ 1��armijo׼��
%               3:�߾�ȷ ���½���Ǿ�ȷ
%    Rule.rho:�ж�׼���е�rho  Ĭ��0.01
%    Rule.nu   ����nu          Ĭ��0.8
%             
%   
% Output
% stepsize: scalar,����P�Ľ�,��������� 
% feva:      scalar,�������ô���
%

Tercond = 1e-8;


Max = 400;   %���ѭ������
feva = 0;
if Rule.opt == 1     %�ж��������ķ�����׼��
    [stepsize,feva] = dot618(Func,Point,direction,Tercond);
    
elseif Rule.opt == 2
    if ~isfield(Rule,'rho')
        Rule.rho = 0.1;
    end
    if ~isfield(Rule,'nu')
        Rule.nu = 0.9;
    end
    u  = Rule.rho *  g0' * direction;
    t = 1;
    if u > 0
%         u = -u;
        t = -1;
    end
    i = 0;
    while 1
       x1 = Point + t*direction;
       f1 = Func(x1);
       feva = feva+1;
       if f1 <= f0 + u*t
           stepsize = t;
           break
       elseif i > Max
           stepsize = t;
           break
       end
       t = t  * Rule.nu;
       i = i + 1;
    end
    
else
    if ~isfield(Rule,'rho')
        Rule.rho = 0.01;
    end
    if ~isfield(Rule,'nu')
        Rule.nu = 0.8;
    end
    u  = Rule.rho * g0' * direction;
    t = 1;
    if u > 0
        %         u = -u;
        t = -1;
    end
    i = 0;
    while 1
        x1 = Point + t*direction;
        f1 = Func(x1);
        feva = feva+1;
        if f1 <= f0 + u*t
            stepsize = t;
            break
        elseif i > Max
            
            [stepsize,feva,situation] = dot618(Func,Point,direction,Tercond);
            if situation == 1
                return
            else
                stepsize = t;
                break
            end
        end
    t = t  * Rule.nu;
    i = i + 1;
    end
end
end




