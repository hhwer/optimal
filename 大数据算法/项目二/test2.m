[x1,lossf1] = saga( a,b,hatx0,lambda,alpha);
f1 = zeros(100,1);
  N = ceil(2*n/100);
 


 ite1 = 1:N:2*n;
tic
  for i = 1:100
     f1(i) = loss(a,b,lossf1(ite1(i),:));
  end
  t = toc;
  
   



 plot(ite1,f1);
 xlabel('iterations')
 ylabel('test Error')

 



 