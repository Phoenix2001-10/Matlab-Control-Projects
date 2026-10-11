%% Mass-Spring-Damper Position Control with PID
% Model: m*x_ddot + c*x_dot + k*x = F
% Input: force F [N]
% Output: displacement x [m]

clear; clc; close all;

%% Physical parameters
m = 1.0;      % kg
c = 2.0;      % N*s/m
k = 20.0;     % N/m

%% Plant transfer function X(s)/F(s)
s = tf('s');
G = 1/(m*s^2 + c*s + k);

disp('Mass-Spring-Damper plant:');
G
fprintf('Open-loop poles:\n');
disp(pole(G));

%% Open-loop step response
figure('Name','Mass-Spring-Damper Open Loop');
step(G, 10);
grid on;
title('Open-Loop Response to 1 N Step Force');
ylabel('Displacement (m)');

%% PID controller
Kp = 100;
Ki = 40;
Kd = 10;
C = pid(Kp, Ki, Kd);

T = feedback(C*G, 1);

fprintf('\nPID gains: Kp = %.2f, Ki = %.2f, Kd = %.2f\n', Kp, Ki, Kd);
fprintf('Closed-loop poles:\n');
disp(pole(T));

%% Closed-loop unit-position command
figure('Name','Mass-Spring-Damper Closed Loop');
step(T, 5);
grid on;
title('Closed-Loop Position Tracking with PID');
ylabel('Position (m)');

info = stepinfo(T);
disp('Closed-loop step-response information:');
disp(info);

%% Compare open-loop and controlled behavior
figure('Name','Mass-Spring-Damper Comparison');
step(G, T, 5);
grid on;
legend('Open loop: force to position','Closed loop: reference to position','Location','best');
title('Open-Loop vs PID-Controlled Response');

%% Save figures
if ~exist('figures','dir')
    mkdir('figures');
end
figs = findall(0,'Type','figure');
for i = 1:numel(figs)
    exportgraphics(figs(i), fullfile('figures', sprintf('figure_%d.png', figs(i).Number)));
end
