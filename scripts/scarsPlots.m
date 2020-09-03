close all

figure()
[x, y, z] = sphere;
surf(x*Re,y*Re,z*Re)
axis equal
hold on
plot_r_ecef = scars_out.SatStates.X_ECEF.Data;
plot_omega_b = scars_out.SatStates.Omega_B.Data;
plot_euler = scars_out.SatStates.Euler_B.Data;
plot_v_b = scars_out.SatStates.V_B.Data;

plot3(plot_r_ecef(1,1),plot_r_ecef(1,2),plot_r_ecef(1,3), 'rx', 'LineWidth',3)
plot3(plot_r_ecef(:,1),plot_r_ecef(:,2),plot_r_ecef(:,3),'r','LineWidth',3)
plot3(plot_r_ecef(end,1),plot_r_ecef(end,2),plot_r_ecef(end,3), 'ro', 'LineWidth',3)

plot3(cube.r_ecef(1,1),cube.r_ecef(1,2),cube.r_ecef(1,3), 'gx', 'LineWidth',3)
plot3(cube.r_ecef(:,1),cube.r_ecef(:,2),cube.r_ecef(:,3),'g','LineWidth',3)
plot3(cube.r_ecef(end,1),cube.r_ecef(end,2),cube.r_ecef(end,3), 'go', 'LineWidth',3)
% div = 0.02;
% for n = 1 : 20 : length(scars_out.mag)
%     plot3([scars_out.r_ecef(n,1) scars_out.r_ecef(n,1)+scars_out.mag(n,1)/div], [scars_out.r_ecef(n,2) scars_out.r_ecef(n,2)+scars_out.mag(n,2)/div], [scars_out.r_ecef(n,3) scars_out.r_ecef(n,3)+scars_out.mag(n,3)/div], 'b-')
% end

figure()
subplot(221)
plot(scars_out.tout,scars_out.SatStates.V_ECEF.Data(:,1),scars_out.tout,scars_out.SatStates.V_ECEF.Data(:,2),scars_out.tout,scars_out.SatStates.V_ECEF.Data(:,3))
hold on
% plot(cube.tout,cube.v_ecef.Data(:,1),cube.tout,cube.v_ecef.Data(:,2),cube.tout,cube.v_ecef.Data(:,3))
% legend('S_x','S_y','S_z','C_x','C_y','C_z');
legend('S_x','S_y','S_z');
subplot(222)
plot(scars_out.tout,plot_v_b(:,1),scars_out.tout,plot_v_b(:,2),scars_out.tout,plot_v_b(:,3))
legend('Vb_x','Vb_y','Vb_z');

% figure()
subplot(223)
plot(scars_out.tout,rad2deg(plot_euler(:,1)),scars_out.tout,rad2deg(plot_euler(:,2)),scars_out.tout,rad2deg(plot_euler(:,3)))
legend('\phi','\theta','\psi');
ylabel('[deg]')
subplot(224)
plot(scars_out.tout,plot_omega_b(:,1),scars_out.tout,plot_omega_b(:,2),scars_out.tout,plot_omega_b(:,3))
legend('\omega_b_x','\omega_b_y','\omega_b_z');
ylabel('[rad/s]')