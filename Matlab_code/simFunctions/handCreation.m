function [linkConfig, initialValues] = handCreation(simConfig, objConfig)

global Io r f1 f2 f3 l1 l2 l3 ptf10 ptf20 ptf30 p1int0 p2int0 p3int0 pt1oprev pt2oprev pt3oprev
global nx10 nx20 nx30 ny10 ny20 ny30 nz10 nz20 nz30 pc10 pc20 pc30 nz1prev nz2prev nz3prev

%% Object and link creation

I = objConfig.mass * (objConfig.length ^ 2) / 6;
Io = diag([I I I]);
r = 0.015; % fingertip radius

% Link dimensions
linkConfig = LinkConfig();
linkConfig.w = 0.0355;
linkConfig.diameter = 0.015; % Diameter of link

radius = 0.1;
x = radius * cosd(60);
y = radius * sind(60);

% 4-dof First Finger
[f1, l1, L1, L2, L3, L4] = createFingerLink(linkConfig, -30, [-x; -y; 0.0]);
linkConfig.links1 = [L1 L2 L3 L4];
f1.tool = transl(l1(3), 0, 0); 

% 4-dof Second finger
[f2, l2, L1, L2, L3, L4] = createFingerLink(linkConfig, -150, [-x; y; 0.0]);
linkConfig.links2 = [L1 L2 L3 L4];
f2.tool = transl(l2(3), 0, 0); 

% 4-dof Third finger
[f3, l3, L1, L2, L3, L4] = createFingerLink(linkConfig, 90, [radius; 0.00; 0.0]);
linkConfig.links3 = [L1 L2 L3 L4];
f3.tool = transl(l3(3), 0, 0); 

%% Initial state

initialValues = InitialValues();
% Initial angles for the first and second fingers
q0f1 = [-90 0 -20 -10]*(pi/180); 
q0f2 = [-90 0 -25 -25]*(pi/180);
q0f3 = [-90 0 -20 0]*(pi/180);

if simConfig.obj == 1
    % Cube
    
    % Position of the fingers on the object
    poc1 = [ -objConfig.length / 3; -objConfig.length / 2 ; 0];
    poc2 = [ -objConfig.length / 3; objConfig.length / 2 ; 0];
    poc3 = [ objConfig.length / 2; 0; 0];
    
    % The normal vectors from the contact point on the sensor 
    % First finger
    nx1o = [1 ; 0 ; 0];
    ny1o = [0 ; 1 ; 0];
    nz1o = [0 ; 0 ; 1];
    
    % Second finger
    nx2o = [-1 ; 0 ; 0];
    ny2o = [0 ; -1 ; 0];
    nz2o = [0 ; 0 ; 1];
    
    % Third finger
    nx3o = [0 ; 1 ; 0];
    ny3o = [-1 ; 0 ; 0];
    nz3o = [0 ; 0 ; 1];
    
elseif simConfig.obj == 2
    % Trapezium
    
    % Position of the fingers on the object
    poc1 = [ -0.002; -(objConfig.length / 2 + 0.004*tand(30)) ; 0.004];
    poc2 = [ 0.01; objConfig.length / 2 + 0.004*tand(15) ; 0.004];
    
    % The normal vectors from the contact point on the sensor 
    % First finger
    nx1o = roty(-30*pi/180)*[1 ; 0 ; 0];
    ny1o = roty(-30*pi/180)*[0 ; 1 ; 0];
    nz1o = roty(-30*pi/180)*[0 ; 0 ; 1];
    
    % Second finger
    nx2o = roty(-165*pi/180)*[1 ; 0 ; 0];
    ny2o = roty(-165*pi/180)*[0 ; 1 ; 0];
    nz2o = roty(-165*pi/180)*[0 ; 0 ; 1];
    
elseif simConfig.obj == 3
    % Trapezium 2
    
    % The normal vectors from the contact point on the sensor 
    % First finger
    nx1o = roty(-30 * pi / 180) * [1 ; 0 ; 0];
    ny1o = roty(-30 * pi / 180) * [0 ; 1 ; 0];
    nz1o = roty(-30 * pi / 180) * [0 ; 0 ; 1];

    % Second finger
    nx2o = rotz(40 * pi / 180) * roty(-165 * pi / 180) * [1 ; 0 ; 0];
    ny2o = rotz(40 * pi / 180) * roty(-165 * pi / 180) * [0 ; 1 ; 0];
    nz2o = rotz(40 * pi / 180) * roty(-165 * pi / 180) * [0 ; 0 ; 1];

    yc1 = ((- nx1o(2) * (0.002) - nx1o(3) * 0.004) / nx1o(1)) - objConfig.length/2;
    yc2 = ((- nx2o(2) * (-0.01) - nx2o(3) * 0.004) / nx2o(1)) + objConfig.length/2;

    % Position of the fingers on the object
    poc1 = [ -0.002; yc1 ; 0.004];   
    poc2 = [ 0.01; yc2 ; 0.004];
    
elseif simConfig.obj == 4
    theta1 = 180*pi/180;
    phis1 = 80*pi/180;
    
    theta2 = 0*pi/180;
    phis2 = 90*pi/180;
    
    % Position of the fingers on the object
    poc1o = [ ...
        objConfig.sphereRadius*sin(phis1)*cos(theta1); ... 
        objConfig.sphereRadius*sin(phis1)*sin(theta1); ... 
        objConfig.sphereRadius*cos(phis1)];
    poc2o = [ ...
        objConfig.sphereRadius*sin(phis2)*cos(theta2); ...
        objConfig.sphereRadius*sin(phis2)*sin(theta2); ... 
        objConfig.sphereRadius*cos(phis2)];
    
    Roc1 = roty(pi/2 - phis1)*rotz(theta1 - pi);
    Roc2 = roty(pi/2 + phis2)*rotz(-theta2);  
end

% The rotation of the object with respect to the reference frame
initialValues.n0    = [ 0 ; 1 ; 0];
initialValues.o0    = [ -1 ; 0 ; 0];
initialValues.a0    = [ 0 ; 0 ; 1];
R0 = [initialValues.n0 initialValues.o0 initialValues.a0];

% The normal vectors with respect to the reference frame
if (simConfig.obj == 1) || (simConfig.obj == 2) || (simConfig.obj == 3)
    % Finger 1
    nx10 = R0*nx1o;
    ny10 = R0*ny1o;
    nz10 = R0*nz1o;
    
    % Finger 2
    nx20 = R0*nx2o;
    ny20 = R0*ny2o;
    nz20 = R0*nz2o;
    
    % Finger 3
    nx30 = R0*nx3o;
    ny30 = R0*ny3o;
    nz30 = R0*nz3o;
    
elseif simConfig.obj == 4
    poc1 = R0*poc1o;
    Rc1 = R0*Roc1;
    nx10 = Rc1(:,1);
    ny10 = Rc1(:,2);
    nz10 = Rc1(:,3);
    
    poc2 = R0*poc2o;
    Rc2 = R0*Roc2;
    nx20 = Rc2(:,1);
    ny20 = Rc2(:,2);
    nz20 = Rc2(:,3);
end

% fkine - inverse kinematics using iterative numerical method
% forward kinematics 
% ikunc - inverse kinematics using optimisation    
% inverse kinematics

%% Second finger
T_init_f2 = f2.fkine(q0f2');
qf20 = f2.ikunc(T_init_f2);
initialValues.qf20 = qf20;
T_final_f2 = f2.fkine(initialValues.qf20');

ptf20 = T_final_f2(1:3, 4);                     % position for finger joint end
pc20 = ptf20 + r*nx20;                          % position for finger tip

initialValues.p0 = pc20 - poc2;                 % find initial object position

%% First finger 
% Using the position of the object to get the first finger position
pc10 = initialValues.p0 + poc1;
ptf10 = pc10 - r*nx10;                          %  position for middle fingertip

T_init_f1 = f1.fkine(q0f1');
R05 = T_init_f1(1:3, 1:3);
T_init_f1 = [R05 ptf10; 0 0 0 1];

qf10 = f1.ikunc(T_init_f1);
initialValues.qf10 = qf10;

T_final_f1 = f1.fkine(initialValues.qf10');
ptf10 = T_final_f1(1:3,4);                      % check initial middle fingertip

%% Third finger

pc30 = initialValues.p0 + poc3;
ptf30 = pc30 - r*nx30;

T_init_f3 = f3.fkine(q0f3');
R06 = T_init_f3(1:3, 1:3);
T_init_f3 = [R06 ptf30; 0 0 0 1];

qf30 = f3.ikunc(T_init_f3);
initialValues.qf30 = qf30;

T_final_f3 = f3.fkine(initialValues.qf30');
ptf30 = T_final_f3(1:3,4);

%% Tip positions

% ptf finger tip position
p1int0 = [initialValues.a0' * ptf10 ; -nx10' * ptf10];
p2int0 = [initialValues.a0' * ptf20 ; -nx20' * ptf20];
p3int0 = [initialValues.a0' * ptf30 ; -nx30' * ptf30];

% disp('First finger manipulability =')
% disp(f1.maniplty(initialValues.qf10, 'yoshikawa','T'))
% disp('Second finger manipulability =')
% disp(f2.maniplty(initialValues.qf20, 'yoshikawa','T'))
% 
% disp('First finger manipulability =')
% disp(f1.maniplty(initialValues.qf10, 'yoshikawa','R'))
% disp('Second finger manipulability =')
% disp(f2.maniplty(initialValues.qf20, 'yoshikawa','R'))

pt1oprev = initialValues.p0 - ptf10;
pt2oprev = initialValues.p0 - ptf20;
pt3oprev = initialValues.p0 - ptf30;

nz1prev = nz10;
nz2prev = nz20;
nz3prev = nz30;

% % Frist finger
% disp('pt1(0) =')
% disp(ptf10)
% 
% % Second finger
% disp('pt2(0) =')
% disp(ptf20)
% 
% % Third finger
% disp('pt3(0) =')
% disp(ptf30)
% 
% % Object
% disp('po(0) =')
% disp(initialValues.p0)
% % Object
% disp('Ro(0) =')
% disp(R0)
% % Joints
disp('qf1(0) =')
disp(initialValues.qf10); %*180/pi)
disp('qf2(0) =')
disp(initialValues.qf20); %*180/pi)
disp('qf3(0) =')
disp(initialValues.qf30); %*180/pi)

end