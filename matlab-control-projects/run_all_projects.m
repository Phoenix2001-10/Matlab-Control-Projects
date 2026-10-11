%% Run All MATLAB Control & Dynamics Projects
% Execute this script from the repository root.

clear; clc; close all;
rootDir = fileparts(mfilename('fullpath'));

projects = {
    '01_mass_spring_damper', 'mass_spring_damper_pid.m';
    '02_dc_motor_pid',       'dc_motor_pid.m';
    '03_cruise_control',     'cruise_control_pi.m';
    '04_inverted_pendulum',  'inverted_pendulum_pd.m'
};

for i = 1:size(projects,1)
    projectDir = fullfile(rootDir, projects{i,1});
    fprintf('\n=====================================================\n');
    fprintf('Running %s\n', projects{i,1});
    fprintf('=====================================================\n');
    oldDir = pwd;
    cleanupObj = onCleanup(@() cd(oldDir)); %#ok<NASGU>
    cd(projectDir);
    run(projects{i,2});
    close all;
    cd(oldDir);
    clear cleanupObj;
end

fprintf('\nAll four projects completed.\n');
