function [a,feva,situation] = dot618(Func,Point,Direction,Tercond)
%dot618�ǻ��ڽ��˷���0.618�������������P��a = argmin f(x+ad)
% Call
% [a,feva] = dot618(Func,Point,Direction,Tercond)
%
% Input
% Func:         function_handle ����P��Ŀ�꺯�� f = Func(x)
% Point:        n-vector ����P�г�ʼ��x
% Direction:    n-vector ����P�з���d
% Tercond       ��ֹ����
%
% Output
% a:    0.618������õ�����P�Ľ��ƾ�ȷ����������
%feva:  �������ô���
%situation   int  1Ϊ�ɹ�
%                          0Ϊʧ��
%tic
situation = 0;
tau = 0.618;
alpha = 1;    %alpha,gamma��������Ҫ���ݾ����������趨,������С����Ӱ��������� 
gamma = 1e-3;
t = 1.1;
Point=Point(:);
Direction=Direction(:);  
count=0;
m=0;
feva = 0;
%���˷�����������
while 1
  flag = 3;
  alpha1 = alpha + gamma;
  if Func(Point + alpha1*Direction) >= Func(Point + alpha*Direction)
      if gamma < 0
          m = m+1;
      end
      flag = 4;
      feva = feva + 2;
  end
  if flag == 3
      gamma = gamma*t;
      alpha_star = alpha;
      m = m+1;
      alpha = alpha1;
  end
  if flag == 4 
      if m == 0
          gamma = - t*gamma;
          alpha_star = alpha1;
      else
          c = min([alpha_star;alpha1]);
          d = max([alpha_star;alpha1]);
          break;
      end
  end
end
%0.618������ȷ����������
while abs(d-c) >= Tercond 
    count = count+1;
    alpha_l = Point + (c+(1-tau)*(d-c)).*Direction;
    alpha_r = Point + (c+tau*(d-c)).*Direction; 
    F_l = Func(alpha_l);
    F_r = Func(alpha_r);
    feva = feva + 2;
    if F_l < F_r
        d = c+tau*(d-c);
    else
        c = c+(1-tau)*(d-c);
    end
end
a = (c+d)/2;
if F_l < Func(Point)
    situation =1;
end
end
