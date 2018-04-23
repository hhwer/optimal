function [U] = fem_tri(N,ifplot)
% 网格剖分、编号
en = identifier(N);
% 计算单元刚度矩阵
Ke = ele_stiff();
% 组合刚度矩阵、载荷向量
[K,F] = assemble(Ke,en,N);
% 矩阵求解
[U] = solve(K,F);
% 生成位移
[U1,U2] = compute_disp(U);

if ifplot == 1
    % 计算应变
    [E1,E2,E12] = compute_strain(U1,U2);
    % 计算应力
    [S1,S2,S12] = compute_stress(E1,E2,E12);
    % 绘图
    plot_result(U1,U2,E1,E2,E12,S1,S2,S12);
end

end