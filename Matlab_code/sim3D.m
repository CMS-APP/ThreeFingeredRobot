close all
clear all
clc

global fd Kv gs gt th p1int0 p2int0 p3int0 nest
global Dpt1 Dpt2 Dpt3
global angz1s angz2s angz3s angy1s angy2s angy3s
global pmtm1
global tm1

%% Robot and Object creation

simConfig = SimConfig();
simConfig.obj = 1; % $ 1 for cube $ 2/3 for trapezoid $ 4 for sphere
simConfig.test = 1; % $ 1 for testing $ 0 for final plots

if simConfig.test == 1
    simConfig.alpha = 0.5;
    simConfig.alpha1 = 0.3;
else 
    simConfig.alpha = 1;
    simConfig.alpha1 = 1;
end

objConfig = ObjConfig();
objConfig.mass = 0.0021; % Object mass
objConfig.length = 0.048; % Object length
objConfig.sphereRadius = 0.024; % Radius of sphere if used

[linkConfig, initialValues] = handCreation(simConfig, objConfig);

%% Initial state

%------------------------------%
% set poc1 in creation_of_hand %
%------------------------------%

% Velocities of the system - all zero
qf1dot0 = [ 0 ; 0 ; 0 ; 0 ];
qf2dot0 = [ 0 ; 0 ; 0 ; 0 ];
qf3dot0 = [ 0 ; 0 ; 0 ; 0 ];
p0dot0 = [ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ];

%% Control gains

% The controller parameters 
% Only in one direction
th = 0 * pi/180;

% gs - x direction for reverence frame
gs = 0;
% gt - y direction for reverence frame
gt = 0;

% Desired grasping force (N)
fd  = 6.0;

pmtm1 = [];
tm1 = 0;

dpt = [];
dwt = [];

%% Simulation

initialConfiguration(simConfig, objConfig, linkConfig, initialValues);

timeConfig = TimeConfig();
timeConfig.t = 0;
timeConfig.tEnd = 3.5;
timeConfig.barHandle = waitbar(0.0, sprintf('%.3f / %.3f', 0.0, timeConfig.tEnd));

options = odeset('AbsTol',10^(-5) ,'RelTol',10^(-5), 'OutputFcn', 'threedee_out');
x0 = [ initialValues.qf10'; initialValues.qf20'; initialValues.qf30'; ... 
    initialValues.p0 ; initialValues.n0 ; initialValues.o0 ; initialValues.a0 ; ... 
    qf1dot0; qf2dot0; qf3dot0; p0dot0; p1int0 ; p2int0; p3int0];

tic
[t, q] = ode15s(@(t, x) threedee(t , x, initialValues, simConfig, objConfig, timeConfig), [0 timeConfig.tEnd] , x0 , options);
toc
close(timeConfig.barHandle);

%% Plotting

finalConfiguration(simConfig, objConfig, linkConfig);
% plot3D;

% size(dpt)

t = 1: size(Dpt1(:,1));
f = figure();
set(gcf,'position',[0, 0, 1500, 500])

% Finger 1
subplot(1,3,1)
hold on
plot(t, Dpt1(:, 1), 'b');
plot(t, Dpt1(:, 2), 'r');
plot(t, Dpt1(:, 3), 'g');
hold off
title('Finger 1 tip velocities')

% Finger 2
subplot(1,3,2)
hold on
plot(t, Dpt2(:, 1), 'b');
plot(t, Dpt2(:, 2), 'r');
plot(t, Dpt2(:, 3), 'g');

title('Finger 2 tip velocities')
hold off
% Finger 3
subplot(1,3,3)
hold on
plot(t, Dpt3(:, 1), 'b');
plot(t, Dpt3(:, 2), 'r');
plot(t, Dpt3(:, 3), 'g');
hold off
title('Finger 3 tip velocities')

% figure();
% % Angle x
% hold on
% plot(t, angz1s, 'b');
% plot(t, angz2s, 'r');
% plot(t, angz3s, 'g');
% title('Fingers x angle')
% hold off
% 
% % Angle y
% figure();
% hold on
% plot(t, angy1s, 'b');
% plot(t, angy2s, 'r');
% plot(t, angy3s, 'g');

% title('Fingers y angle')
hold off