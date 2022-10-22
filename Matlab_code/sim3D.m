close all
clear all
clc

global fd Kv gs gt th Ks1 Ks2 p1int0 p2int0 nest

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
qtdot0 = [ 0 ; 0 ; 0 ; 0 ];
qmdot0 = [ 0 ; 0 ; 0 ; 0 ];
p0dot0 = [ 0 ; 0 ; 0 ; 0 ; 0 ; 0 ];

%% Control gains

% The controller parameters 
% Only in one direction
th = 0 * pi/180;

% gs - x direction for reverence frame
gs = 0;
% gs - y direction for reverence frame
gt = 0;

% Desired grasping force (N)
fd  = 4;

% Damping gain velocities - makes the system smoother
% 4 Joints, so 4 damping values for each finger
Kv1 = diag([7 7 7 7]*10^(-2)); % diag([0.9 0.8 0.7 0.7 0.7]);
Kv2 = diag([7 7 7 7]*10^(-2)); % diag([0.8 0.8 0.8 0.8]);

% Combined matrix
Kv  = [    Kv1     zeros(4,4)  zeros(4,6);          % 
       zeros(4,4)      Kv2     zeros(4,6);          % 14x14 - 18x18 for 3 fingered - remember to add another row and column for each finger
       zeros(6,4)  zeros(6,4)  zeros(6,6)];         %

% Spinging damping - ignore with 3 fingers
Ks1 = diag([0.2 0.2 0.2]);
Ks2 = diag([0.2 0.2 0.2]);

%% Simulation

timeConfig = TimeConfig();
timeConfig.t = 0;
timeConfig.tEnd = 7;
timeConfig.barHandle = waitbar(0.0, sprintf('%.3f / %.3f', 0.0, timeConfig.tEnd));

options = odeset('AbsTol',10^(-5) ,'RelTol',10^(-5));
x0 = [ initialValues.qt0' ; initialValues.qm0' ; ... 
    initialValues.p0 ;
    initialValues.n0 ; initialValues.o0 ; initialValues.a0 ; ... 
    qtdot0 ; qmdot0 ; p0dot0 ; p1int0 ; p2int0 ; nest];

tic
[t, q] = ode15s(@(t, x) threedee(t , x, simConfig, objConfig, timeConfig), [0 timeConfig.tEnd] , x0 , options);
toc
close(timeConfig.barHandle);

%% Plotting

initialConfiguration(simConfig, objConfig, linkConfig, initialValues);
finalConfiguration(simConfig, objConfig, linkConfig);
% plot3D;