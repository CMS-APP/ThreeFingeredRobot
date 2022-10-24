function [finger, l, L1, L2, L3, L4] = createFingerLink(linkConfig, baseRotation, basePosition)
l1 = 0.064;
l2 = 0.064;
l3 = 0.030;
l = [ l1 ; l2 ; l3];

% Finger D-H parameters
L1 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'modified');
L2 = Link('d', 0, 'a', 0,     'alpha', -pi/2, 'modified');
L3 = Link('d', 0, 'a', l(1), 'alpha', 0,     'modified');
L4 = Link('d', 0, 'a', l(2), 'alpha', 0,     'modified');

% Link mass
L1.m = 0;
L2.m = 0.02818;
L3.m = 0.01373;
L4.m = 0.04864;

% link inertias
L1.I = [   0       0       0];
L2.I = inertia_tensors(L2.m, l1, linkConfig.w, linkConfig.diameter);
L3.I = inertia_tensors(L3.m, l2, linkConfig.w, linkConfig.diameter);
L4.I = inertia_tensors(L4.m, l3, linkConfig.w, linkConfig.diameter);

% Link mass center
L1.r = [0        0    0];
L2.r = [0.005    0    0];
L3.r = [0.013    0    0];
L4.r = [0.007    0    0];

% Joint variable offset
L1.offset = 0;
L2.offset = 0;
L3.offset = 0;
L4.offset = 0;

% Joint limit
L1.qlim = [];
L2.qlim = [];
L3.qlim = [];
L4.qlim = [];

% Link viscous friction (motor referred)
L1.B = 0;
L2.B = 0;
L3.B = 0;
L4.B = 0;

% Link Coulomb friction
L1.Tc = [0 0];
L2.Tc = [0 0];
L3.Tc = [0 0];
L4.Tc = [0 0];

% Actuator gear ratio
L1.G = 1;
L2.G = 1;
L3.G = 1;
L4.G = 1;

% Actuator motor inertia
L1.Jm = 0;
L2.Jm = 0;
L3.Jm = 0;
L4.Jm = 0;

finger = SerialLink([L1 L2 L3 L4]);
% The rotation matrix for the base of the second finger
rotationbase = rotz(baseRotation*pi/180);
% Screw displacement, with a rotation about the z axis
finger.base = [rotationbase basePosition; 0 0 0 1];
end