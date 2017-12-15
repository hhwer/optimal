n = [2,4,8,16,32];
i =4;
situation =0 ;
Rule.opt = 2;
status = 0;
Rule.delta = 0.001;
Rule.rho = 0.01;
Rule.nu = 0.9;
[x1,f1,ite,t,feva] = Solution(situation,n(i),status,Rule);
vpa(f1,4)
vpa([x1(1),x1(2),x1(n(i)-1),x1(n(i))],3)
 vpa(t,4)