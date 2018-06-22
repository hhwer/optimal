% a =  loadMNISTImages('train-images.idx3-ubyte');
% a1 = loadMNISTImages('t10k-images.idx3-ubyte');
% a = [a,a1];
% b = loadMNISTLabels('train-labels.idx1-ubyte');
% b1 = loadMNISTLabels('t10k-labels.idx1-ubyte');
% b = [b;b1];
lambda = 1e-4;
alpha = 0.0001;

[ x1,x2,x3,x4,x5,t1,t2,t3,t4,t5,lossf1,lossf2,lossf3,lossf4,lossf5 ] = test( a,b,lambda,alpha,2);

 f1 = zeros(100,1);
 f2 = zeros(100,1);
 f3 = zeros(10,1);
 f4 = zeros(10,1);
 f5 = zeros(10,1);
 

 ite1 = 1:100;
 ite2 = ite1;
 ite3 = 1:10;
 ite4 = ite3;
 ite5 = ite3;

 tic
  for i = 1:100
%      f1(i) = loss(a,b,lossf1(:,ite1(i)));
%    f2(i) = loss(a,b,lossf2(:,ite2(i)));
     v = exp(-lossf1(:,ite1(i))'*a.*b');
     f1(i) = norm(mean(v./(1+v).*a.*b',2));
     v = exp(-lossf2(:,ite2(i))'*a.*b');
     f2(i) = norm(mean(v./(1+v).*a.*b',2));
     
  end
  for i = 1:10
%      f3(i) = loss(a,b,lossf3(:,ite3(i)));
%      f4(i) = loss(a,b,lossf4(:,ite4(i)));
%      f5(i) = loss(a,b,lossf5(:,ite5(i)));
     v = exp(-lossf3(:,ite3(i))'*a.*b');
     f3(i) = norm(mean(v./(1+v).*a.*b',2));
          v = exp(-lossf4(:,ite4(i))'*a.*b');
     f4(i) = norm(mean(v./(1+v).*a.*b',2));
          v = exp(-lossf5(:,ite5(i))'*a.*b');
     f5(i) = norm(mean(v./(1+v).*a.*b',2));
  end
  t = toc;
  f = min([min(f1),min(f2),min(f3),min(f4),min(f5)]);
  f = f-1e-10;
f = 0;
  
%  plot(ite1,f1,ite2,f2,ite3,f3,ite4,f4,ite5,f5);
plot(ite1,log10(f1-f),ite2,log10(f2-f),ite3,log10(f3-f),ite4,log10(f4-f),ite5,log10(f5-f));
 xlabel('times')
 ylabel('test Error')
  legend(['sag(',num2str(f1(100)),')'],    ...
                        ['saga(',num2str(f2(100)),')'],['svrg(',num2str(f3(10)),')'] ...
                        ,['msvrg(',num2str(f4(10)),')'],['scsg(',num2str(f5(10)),')']);
 suptitle(['MINIST lambda=',num2str(lambda)])
      
      
%  num1 = 1:N:n;
%  num2 = 1:n:20*n;
%  num3 = 1:N:n;
%  
%  time1 = 0:t1/20:t1-0.01;
%  time2 = 0:t2/20:t2-0.01;
%  time3 = 0:t3/20:t3-0.01;
 




% figure(1);
%  subplot(1,3,1)
%  plot(ite1,f1,'+',ite2,f2,'*');
%  xlabel('iterations')
%  ylabel('test Error')
%  legend('sag','svrg')
%  
%   subplot(1,3,2)
%  plot(num1,f1,'+',num2,f2,'*');
%  xlabel('gradient evaluations')
%  ylabel('test Error')
%  legend('sag','svrg')
%  subplot(1,3,3)
%  
%  plot(time1,f1,'+',time2,f2,'*');
%  xlabel('times')
%  ylabel('test Error')
%    legend(['sag(',num2str(f1(20)),')'],    ...
%                         ['svrg(',num2str(f2(20)),')']);
%  
%  suptitle(['MINIST lambda=',num2str(lambda)])
 
 
%  figure(2);
%  subplot(1,3,1)
%  plot(ite1,f1,'+',ite2,f2,'*',ite3,f3,'o');
%  xlabel('iterations')
%  ylabel('test Error')
%  legend('sag','svrg','saga')
 
%   subplot(1,3,2)
%  plot(num1,f1,'+',num2,f2,'*',num3,f3,'o');
%  xlabel('gradient evaluations')
%  ylabel('test Error')
%  legend('sag','svrg','saga')
%  
%  subplot(1,3,3)
 
%  plot(time1,f1,'+',time2,f2,'*',time3,f3,'o');
%  xlabel('times')
%  ylabel('test Error')
%   legend(['sag(',num2str(f1(80)),')'],    ...
%                         ['svrg(',num2str(f2(80)),')'],['saga(',num2str(f3(80)),')']);
%  suptitle(['MINIST lambda=',num2str(lambda)])
     


 
 