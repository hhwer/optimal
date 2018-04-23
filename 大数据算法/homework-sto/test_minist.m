a =  loadMNISTImages('train-images.idx3-ubyte');
a1 = loadMNISTImages('t10k-images.idx3-ubyte');
a = [a,a1];
a = a';
b = loadMNISTLabels('train-labels.idx1-ubyte');
b1 = loadMNISTLabels('t10k-labels.idx1-ubyte');
b = [b;b1];
[n,p] = size(a);
hatx0 = zeros(1,p);
lambda = 1/n;
m = n/10;
% alpha = 1/n;
alpha = 0.01;
K = 3;
draw = 3;

 [ x1,x2,x3,t1,t2,t3,lossf1,lossf2,lossf3 ] = test( a,b,lambda,alpha,m,K );

 f1 = zeros(20,1);
 f2 = zeros(20,1);
 f3 = zeros(20,1);
  N = ceil(n/20);
 

 ite1 = 1:N:n;
 ite2 = 1:20;
 ite3 = 1:2*N:2*n;

  for i = 1:20
     f1(i) = loss(a,b,lossf1(ite1(i),:));
     f2(i) = loss(a,b,lossf2(ite2(i),:));
  end
  if draw == 3
      for i = 1:20
        f3(i) = loss(a,b,lossf3(ite3(i),:));
      end
  end
      
      
 num1 = 1:N:n;
 num2 = 1:n:20*n;
 num3 = 1:N:n;
 
 time1 = 0:t1/20:t1-0.01;
 time2 = 0:t2/20:t2-0.01;
 time3 = 0:t3/20:t3-0.01;
 
figure(1);
 subplot(1,3,1)
 plot(ite1,f1,'+',ite2,f2,'*');
 xlabel('iterations')
 ylabel('test Error')
 legend('sag','svrg')
 
  subplot(1,3,2)
 plot(num1,f1,'+',num2,f2,'*');
 xlabel('gradient evaluations')
 ylabel('test Error')
 legend('sag','svrg')
 subplot(1,3,3)
 
 plot(time1,f1,'+',time2,f2,'*');
 xlabel('times')
 ylabel('test Error')
   legend(['sag(',num2str(f1(20)),')'],    ...
                        ['svrg(',num2str(f2(20)),')']);
 
 suptitle(['MINIST lambda=',num2str(lambda)])
 
 
 figure(2);
 subplot(1,3,1)
 plot(ite1,f1,'+',ite2,f2,'*',ite3,f3,'o');
 xlabel('iterations')
 ylabel('test Error')
 legend('sag','svrg','sgBB')
 
  subplot(1,3,2)
 plot(num1,f1,'+',num2,f2,'*',num3,f3,'o');
 xlabel('gradient evaluations')
 ylabel('test Error')
 legend('sag','svrg','sgBB')
 
 subplot(1,3,3)
 
 plot(time1,f1,'+',time2,f2,'*',time3,f3,'o');
 xlabel('times')
 ylabel('test Error')
  legend(['sag(',num2str(f1(20)),')'],    ...
                        ['svrg(',num2str(f2(20)),')'],['sgBB(',num2str(f3(20)),')']);
 suptitle(['MINIST lambda=',num2str(lambda)])
     


 
 