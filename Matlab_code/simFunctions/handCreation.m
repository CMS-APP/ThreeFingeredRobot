function [linkConfig, initialValues] = handCreation(simConfig, objConfig)

global f1 f2 Io r lt lm ptt0 ptm0 p1int0 p2int0 nest nz1est0 nz2est0 pt1oprev pt2oprev
global nx10 nx20 ny10 ny20 nz10 nz20 pc10 pc20 nz1prev nz2prev

%% Object dimensions

I = objConfig.mass * (objConfig.length ^ 2) / 6;
Io = diag([I I I]);
r = 0.015; % fingertip radius

%% 4-dof First Finger

% Link dimensions
linkConfig = LinkConfig();
linkConfig.w = 0.0355; % What is this?
linkConfig.diameter = 0.015; % Diameter of link

% link lenghts
l1 = 0.064;
l2 = 0.064;
l3 = 0.030;
lt = [l1 ; l2 ; l3];

% First finger D-H parameters
L11 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'modified');
L21 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'modified');
L31 = Link('d', 0, 'a', lt(1), 'alpha', 0,     'modified');
L41 = Link('d', 0, 'a', lt(2), 'alpha', 0,     'modified');

% link mass
L11.m = 0;
L21.m = 0.02818;
L31.m = 0.01373;
L41.m = 0.04864;

% link inertias
L11.I = [   0      0      0];
L21.I = inertia_tensors(L21.m, lt(1), linkConfig.w, linkConfig.diameter);
L31.I = inertia_tensors(L31.m, lt(2), linkConfig.w, linkConfig.diameter);
L41.I = inertia_tensors(L41.m, lt(3), linkConfig.w, linkConfig.diameter);

% link mass center
L11.r = [0       0   0];
L21.r = [0.005   0   0];
L31.r = [0.013   0   0];
L41.r = [0.007   0   0];

% joint variable offset
L11.offset = 0;
L21.offset = 0;
L31.offset = 0;
L41.offset = 0;

% joint limit
L11.qlim = [];
L21.qlim = [];
L31.qlim = [];
L41.qlim = [];

% link viscous friction (motor referred)
L11.B = 0;
L21.B = 0;
L31.B = 0;
L41.B = 0;

% link Coulomb friction
L11.Tc = [0 0];
L21.Tc = [0 0];
L31.Tc = [0 0];
L41.Tc = [0 0];

% actuator gear ratio
L11.G = 1;
L21.G = 1;
L31.G = 1;
L41.G = 1;

% actuator motor inertia
L11.Jm = 0;
L21.Jm = 0;
L31.Jm = 0;
L41.Jm = 0;


linkConfig.links1 = [L11 L21 L31 L41];
f1 = SerialLink([L11 L21 L31 L41], 'name', 'thumb');
f1.tool = transl(lt(3), 0, 0);

% The rotation matrix for the base of the first finger
Rbase = rotz(-00*pi/180);
% The base position of the first finger from the origin
pbase = [0.00; 0.0; 0.0];
f1.base = [Rbase pbase; 0 0 0 1];

%% 4-dof Second finger

l1 = 0.064;
l2 = 0.064;
l3 = 0.030;
lm = [ l1 ; l2 ; l3];

% Second finger D-H parameters
L12 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'modified');
L22 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'modified');
L32 = Link('d', 0, 'a', lm(1), 'alpha', 0,     'modified');
L42 = Link('d', 0, 'a', lm(2), 'alpha', 0,     'modified');

% L12 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'standard');
% L22 = Link('d', 0, 'a', lm(1), 'alpha', 0,     'standard');
% L32 = Link('d', 0, 'a', lm(2), 'alpha', 0,     'standard');
% L42 = Link('d', 0, 'a', lm(3), 'alpha', 0,     'standard');

% link mass
L12.m = 0;
L22.m = 0.02818;
L32.m = 0.01373;
L42.m = 0.04864;

% link inertias
L12.I = [   0       0       0];
L22.I = inertia_tensors(L22.m, lm(1), linkConfig.w, linkConfig.diameter);
L32.I = inertia_tensors(L32.m, lm(2), linkConfig.w, linkConfig.diameter);
L42.I = inertia_tensors(L42.m, lm(3), linkConfig.w, linkConfig.diameter);

% link mass center
L12.r = [0        0    0];
L22.r = [0.005    0    0];
L32.r = [0.013    0    0];
L42.r = [0.007    0    0];

% joint variable offset
L12.offset = 0;
L22.offset = 0;
L32.offset = 0;
L42.offset = 0;

% joint limit
L12.qlim = [];
L22.qlim = [];
L32.qlim = [];
L42.qlim = [];

% link viscous friction (motor referred)
L12.B = 0;
L22.B = 0;
L32.B = 0;
L42.B = 0;

% link Coulomb friction
L12.Tc = [0 0];
L22.Tc = [0 0];
L32.Tc = [0 0];
L42.Tc = [0 0];

% actuator gear ratio
L12.G = 1;
L22.G = 1;
L32.G = 1;
L42.G = 1;

% actuator motor inertia
L12.Jm = 0;
L22.Jm = 0;
L32.Jm = 0;
L42.Jm = 0;

linkConfig.links2 = [L12 L22 L32 L42];
f2 = SerialLink([L12 L22 L32 L42], 'name', 'middle');

% The rotation matrix for the base of the second finger
Rbase = rotz(-0*pi/180);

% The base position of the second finger
pbase = [0.00; 0.14; 0.0];

% Screw displacement, with a rotation about the z axis
f2.base = [Rbase pbase; 0 0 0 1];

f2.tool = transl(lm(3), 0, 0); 
% Translation of the second finger along the finger from the center of the last link
% For some reason it's translation is in (Z, Y, X) and not (X, Y, Z)

%% 4-dof index finger

% f3 = SerialLink([L12 L22 L32 L42], 'name', 'index');
% f3.tool = transl(l3, 0, 0);
% f3.base = transl(0.09, 0.045, 0);

% q0i    =  [0 ; -50 ; -70 ; -10 ]*pi/180;

%% Initial state

initialValues = InitialValues();
% Initial angles for the first and second fingers
q0t = [-90 -15 0 0 ]*(pi/180); 
q0m = [-90 15 0 0 ]*(pi/180);

if simConfig.obj == 1
    % Cube
    
    % Position of the fingers on the object
    poc1 = [ 0.002; -objConfig.length / 2 ; 0.01];
    poc2 = [ -0.01; objConfig.length / 2 ; 0.004];
    
    % The normal vectors from the contact point on the sensor 
    % First finger
    nx1o = [1 ; 0 ; 0];
    ny1o = [0 ; 1 ; 0];
    nz1o = [0 ; 0 ; 1];
    
    % Second finger
    nx2o = [-1 ; 0 ; 0];
    ny2o = [0 ; 1 ; 0];
    nz2o = [0 ; 0 ; -1];
    
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
    Rc1 = [nx10 ny10 nz10];
    
    % Finger 2
    nx20 = R0*nx2o;
    ny20 = R0*ny2o;
    nz20 = R0*nz2o;
    Rc2 = [nx20 ny20 nz20];
    
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

% Estimate values for something 
Rc1est = Rc1 * rotz(0 * pi / 180) * roty(0 * pi / 180)
Rc2est = Rc2 * rotz(0 * pi / 180) * roty(0 * pi / 180)

% Estimate values for something else
nest = [
    Rc1est(:,2);
    Rc1est(:,1);
    Rc1est(:,3);
    Rc2est(:,2);
    Rc2est(:,1);
    Rc2est(:,3)];

% fkine - inverse kinematics using iterative numerical method
% forward kinematics 
% ikunc - inverse kinematics using optimisation    
% inverse kinematics

% Second finger - forward kinematics to get the rotatin and position of 
% the finger
T_init4 = f2.fkine(q0m');
qm0 = f2.ikunc(T_init4);
initialValues.qm0 = qm0;
T_final4 = f2.fkine(initialValues.qm0');

ptm0 = T_final4(1:3,4);                         % position for finger joint end
pc20 = ptm0 + r*nx20;                           % position for finger tip

initialValues.p0 = pc20 - poc2;                 % find initial object position

% Using the position of the object to get the first finger position
pc10 = initialValues.p0 + poc1;
ptt0 = pc10 - r*nx10;                           %  position for middle fingertip

% First finger 
T_init5 = f1.fkine(q0t');
R05 = T_init5(1:3, 1:3);
Tinit_5 = [R05 ptt0; 0 0 0 1];

qt0 = f1.ikunc(Tinit_5);
initialValues.qt0 = qt0;

T_final5 = f1.fkine(initialValues.qt0);
ptt0 = T_final5(1:3,4);                          % check initial middle fingertip

% ptt finger tip position
p1int0 = [initialValues.a0' * ptt0 ; -nx10' * ptt0];
p2int0 = [initialValues.a0' * ptm0 ; -nx20' * ptm0];

nz1est0 = nest(7:9);
nz2est0 = nest(16:18);

disp('thumb manipulability =')
disp(f1.maniplty(initialValues.qt0, 'yoshikawa','T'))
disp('middle manipulability =')
disp(f2.maniplty(initialValues.qm0, 'yoshikawa','T'))

disp('thumb manipulability =')
disp(f1.maniplty(initialValues.qt0, 'yoshikawa','R'))
disp('middle manipulability =')
disp(f2.maniplty(initialValues.qm0, 'yoshikawa','R'))

pt1oprev = initialValues.p0 - ptt0;
pt2oprev = initialValues.p0 - ptm0;

nz1prev = nz10;
nz2prev = nz20;

% Thumb
disp('pt1(0) =')
disp(ptt0)
% Middle
disp('pt2(0) =')
disp(ptm0)
% Object
disp('po(0) =')
disp(initialValues.p0)
% Object
disp('Ro(0) =')
disp(R0)
% Joints
disp('qt(0) =')
disp(initialValues.qt0*180/pi)
disp('qm(0) =')
disp(initialValues.qm0*180/pi)

end