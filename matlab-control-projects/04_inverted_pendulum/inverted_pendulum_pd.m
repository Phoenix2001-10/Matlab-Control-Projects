%% Simplified Inverted Pendulum Angle Stabilization with PD Control
% Linearized near the upright equilibrium.
% Equation: m*l^2*theta_ddot - m*g*l*theta = tau
% Input: control torque tau [N*m]
% Output: small angular deviation theta [rad]

clear; clc; close all;

%% Physical parameters
m = 0.5;       % kg
l = 0.5;       % m
g = 9.81;      % m/s^2

%% Unstable linearized plant theta(s)/tau(s)
s = tf('s');
G = 1/(m*l^2*s^2 - m*g*l);

disp('Linearized inverted-pendulum plant:');
G
fprintf('Open-loop poles:\n');
disp(pole(G));

%% Show open-loop instability for a small torque step
figure('Name','Inverted Pendulum Open Loop');
step(0.05*G, 3);
grid on;
title('Open-Loop Inverted Pendulum (Unstable)');
ylabel('Angular deviation (rad)');

%% PD controller
Kp = 20;
Kd = 2;
C = pid(Kp, 0, Kd);
T = feedback(C*G, 1);

fprintf('\nPD gains: Kp = %.2f, Kd = %.2f\n', Kp, Kd);
fprintf('Closed-loop poles:\n');
disp(pole(T));

%% Small-angle reference tracking
referenceAngleDeg = 5;
referenceAngleRad = deg2rad(referenceAngleDeg);
t = 0:0.005:3;
r = referenceAngleRad*ones(size(t));
y = lsim(T, r, t);

figure('Name','Inverted Pendulum Closed Loop');
plot(t, rad2deg(y), 'LineWidth', 1.5);
hold on;
plot(t, referenceAngleDeg*ones(size(t)), '--', 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Angle deviation (deg)');
legend('Pendulum angle','Reference','Location','best');
title('PD-Stabilized Inverted Pendulum');

%% Step-response metrics
info = stepinfo(T);
disp('Closed-loop unit-step information:');
disp(info);

%% Stability margin view of the loop transfer function
figure('Name','Inverted Pendulum Root Locus');
rlocus(C*G);
grid on;
title('Root Locus of PD-Controlled Pendulum Loop');

%% Save figures
if ~exist('figures','dir')
    mkdir('figures');
end
figs = findall(0,'Type','figure');
for i = 1:numel(figs)
    exportgraphics(figs(i), fullfile('figures', sprintf('figure_%d.png', figs(i).Number)));
end
