function [U] = fem_tri(N,ifplot)
% �����ʷ֡����
en = identifier(N);
% ���㵥Ԫ�նȾ���
Ke = ele_stiff();
% ��ϸնȾ����غ�����
[K,F] = assemble(Ke,en,N);
% �������
[U] = solve(K,F);
% ����λ��
[U1,U2] = compute_disp(U);

if ifplot == 1
    % ����Ӧ��
    [E1,E2,E12] = compute_strain(U1,U2);
    % ����Ӧ��
    [S1,S2,S12] = compute_stress(E1,E2,E12);
    % ��ͼ
    plot_result(U1,U2,E1,E2,E12,S1,S2,S12);
end

end