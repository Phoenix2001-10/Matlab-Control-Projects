%% DC Motor Speed Control with PID
% Armature-controlled DC motor.
% Input: armature voltage V [V]
% Output: angular speed omega [rad/s]

clear; clc; close all;

%% Motor parameters
J = 0.01;     % rotor inertia [kg*m^2]
b = 0.10;     % viscous friction [N*m*s]
K = 0.01;     % motor torque/back-emf constant
R = 1.0;      % armature resistance [ohm]
L = 0.5;      % armature inductance [H]

%% Transfer function omega(s)/V(s)
s = tf('s');
G = K / ((J*s + b)*(L*s + R) + K^2);

disp('DC motor plant:');
G
fprintf('Open-loop poles:\n');
disp(pole(G));

%% Open-loop voltage response
figure('Name','DC Motor Open Loop');
step(G, 5);
grid on;
title('Open-Loop Motor Speed for 1 V Step');
ylabel('Angular speed (rad/s)');

%% PID speed controller
Kp = 100;
Ki = 200;
Kd = 10;
C = pid(Kp, Ki, Kd);
T = feedback(C*G, 1);

fprintf('\nPID gains: Kp = %.2f, Ki = %.2f, Kd = %.2f\n', Kp, Ki, Kd);
fprintf('Closed-loop poles:\n');
disp(pole(T));

%% Track a 1 rad/s command
figure('Name','DC Motor Closed Loop');
step(T, 3);
grid on;
title('PID-Controlled DC Motor Speed');
ylabel('Angular speed (rad/s)');

info = stepinfo(T);
disp('Closed-loop step-response information:');
disp(info);

%% Controller comparison
C_P = pid(100,0,0);
C_PI = pid(100,200,0);
T_P = feedback(C_P*G,1);
T_PI = feedback(C_PI*G,1);

figure('Name','DC Motor Controller Comparison');
step(T_P, T_PI, T, 3);
grid on;
legend('P','PI','PID','Location','best');
title('DC Motor: P vs PI vs PID');
ylabel('Angular speed (rad/s)');

%% Save figures
if ~exist('figures','dir')
    mkdir('figures');
end
figs = findall(0,'Type','figure');
for i = 1:numel(figs)
    exportgraphics(figs(i), fullfile('figures', sprintf('figure_%d.png', figs(i).Number)));
end
