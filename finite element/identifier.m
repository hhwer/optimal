function en = identifier(N)
M = 2*N*N;
en = zeros(6,M);% ��Ԫe�ڵ������ڵ�����
for i = 1:N
    for j = 1:N
        To = (2*i-1)+(j-1)*(2*N);% (i,j)��Ӧ��������Ԫ
        Te = To+1;% (i,j)��Ӧ��ż����Ԫ
        en(1,To)=(i)+(j-1)*(N+1);
        en(2,To)=en(1,To)+N+2;
        en(3,To)=en(2,To)-1;
        en(4,To)=en(1,To)+(N+1)*(N+1);
        en(5,To)=en(2,To)+(N+1)*(N+1);
        en(6,To)=en(3,To)+(N+1)*(N+1);
        en(1,Te)=en(1,To);
        en(2,Te)=en(1,Te)+1;
        en(3,Te)=en(2,Te)+N+1;
        en(4,Te)=en(1,Te)+(N+1)*(N+1);
        en(5,Te)=en(2,Te)+(N+1)*(N+1);
        en(6,Te)=en(3,Te)+(N+1)*(N+1);
    end
end
end