function [a,feva,situation] = dot618(Func,Point,Direction,Tercond)
%dot618是基于进退法的0.618方法，求解问题P：a = argmin f(x+ad)
% Call
% [a,feva] = dot618(Func,Point,Direction,Tercond)
%
% Input
% Func:         function_handle 问题P中目标函数 f = Func(x)
% Point:        n-vector 问题P中初始点x
% Direction:    n-vector 问题P中方向d
% Tercond       终止条件
%
% Output
% a:    0.618方法求得的问题P的近似精确线搜索步长
%feva:  函数调用次数
%situation   int  1为成功
%                          0为失败
%tic
situation = 0;
tau = 0.618;
alpha = 1;    %alpha,gamma的设置需要根据具体问题来设定,过大或过小都会影响程序性能 
gamma = 1e-3;
t = 1.1;
Point=Point(:);
Direction=Direction(:);  
count=0;
m=0;
feva = 0;
%进退法求搜索区间
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
%0.618方法求精确线搜索步长
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
