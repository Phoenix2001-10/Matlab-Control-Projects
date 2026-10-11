%% Vehicle Cruise Control with PI and Disturbance Rejection
% Model: m*v_dot + b*v = u + d
% u: traction force [N]
% d: external disturbance force [N]
% v: vehicle speed [m/s]

clear; clc; close all;

%% Vehicle parameters
m = 1000;     % kg
b = 50;       % N*s/m

%% Plant V(s)/F(s)
s = tf('s');
G = 1/(m*s + b);

disp('Cruise-control plant:');
G

%% Open-loop response to traction force
figure('Name','Cruise Control Open Loop');
step(1000*G, 60); % response to a 1000 N step force
grid on;
title('Open-Loop Vehicle Speed for 1000 N Step Force');
ylabel('Speed (m/s)');

%% PI controller
Kp = 800;
Ki = 40;
C = pid(Kp, Ki, 0);

Tref = feedback(C*G, 1);  % reference speed -> actual speed
Td   = feedback(G, C);    % disturbance force -> actual speed

fprintf('\nPI gains: Kp = %.2f, Ki = %.2f\n', Kp, Ki);
fprintf('Closed-loop poles:\n');
disp(pole(Tref));

%% Track 20 m/s target speed
referenceSpeed = 20;
t = 0:0.1:80;
r = referenceSpeed*ones(size(t));
y_ref = lsim(Tref, r, t);

figure('Name','Cruise Control Tracking');
plot(t, y_ref, 'LineWidth', 1.5);
hold on;
plot(t, r, '--', 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Vehicle speed','Reference','Location','best');
title('PI Cruise-Control Speed Tracking');

%% Add an uphill-like disturbance at t = 30 s
% Negative force represents increased resistance.
d = zeros(size(t));
d(t >= 30) = -500;
y_dist = lsim(Td, d, t);
y_total = y_ref + y_dist;

figure('Name','Cruise Control Disturbance');
plot(t, y_total, 'LineWidth', 1.5);
hold on;
plot(t, r, '--', 'LineWidth', 1.2);
xline(30, ':', 'Disturbance begins');
grid on;
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Vehicle speed','Reference','Location','best');
title('Cruise Control with -500 N Disturbance');

%% Unit-step performance data
info = stepinfo(Tref);
disp('Closed-loop unit-step information:');
disp(info);

%% Save figures
if ~exist('figures','dir')
    mkdir('figures');
end
figs = findall(0,'Type','figure');
for i = 1:numel(figs)
    exportgraphics(figs(i), fullfile('figures', sprintf('figure_%d.png', figs(i).Number)));
end
