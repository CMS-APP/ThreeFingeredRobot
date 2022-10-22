function dq = threedee(t , x, simConfig, objConfig, timeConfig)

global f1 f2 Io r lt lm fd Kv gs gt Ks1 Ks2 nz1est0 nz2est0 % from main
global Dfi Dlxi Dlzi Dni Sn phi psi Det5 Det4 pct pcm Dpt1 Dpt2 Dwt1 Dwt2 Dpt1o Dpt2o Dwt1o Dwt2o
global t_out x_out F Lambda ptt ptm U % Out
global Poc1o Poc2o o1 o2 o3 o4 sphi Nx1 Nz1 Nx2 Nz2 Nc1 Nc2 Nx1e Nz1e Nx2e Nz2e Nc1e Nc2e Bpsi1 Bpsi2 Bphi1 Bphi2 Eul1 Eul2 K  % Out

%% definitions

qt     = x(1:4);            % 4x1
qm     = x(5:8);            % 4x1
po     = x(9:11);           % 3x1
n      = x(12:14);          % 3x1
o      = x(15:17);          % 3x1
a      = x(18:20);          % 3x1
qtdot  = x(21:24);          % 5x1                   
qmdot  = x(25:28);          % 4x1
podot  = x(29:31);          % 3x1
wo     = x(32:34);          % 3x1
phi1   = x(35);             % 1x1
psi1   = x(36);             % 1x1
phi2   = x(37);             % 1x1
psi2   = x(38);             % 1x1

xdot   = [qtdot ; qmdot ; podot ; wo];      % 14x1

if simConfig.obj == 1
    %cube
    nx1o = [1 ; 0 ; 0];
    ny1o = [0 ; 1 ; 0];
    nz1o = [0 ; 0 ; 1];
    
    nx2o = [-1 ; 0 ; 0];
    ny2o = [0 ; 1 ; 0];
    nz2o = [0 ; 0 ; -1];
    
elseif simConfig.obj == 2
    % Trapezium
    nx1o = roty(-30*pi/180)*[1 ; 0 ; 0];
    ny1o = roty(-30*pi/180)*[0 ; 1 ; 0];
    nz1o = roty(-30*pi/180)*[0 ; 0 ; 1];
    
    nx2o = roty(-165*pi/180)*[1 ; 0 ; 0];
    ny2o = roty(-165*pi/180)*[0 ; 1 ; 0];
    nz2o = roty(-165*pi/180)*[0 ; 0 ; 1];
    
elseif simConfig.obj == 3    
    % Trapezium 2
    nx1o = roty(-30*pi/180) * [1 ; 0 ; 0];
    ny1o = roty(-30*pi/180)*[0 ; 1 ; 0];
    nz1o = roty(-30*pi/180)*[0 ; 0 ; 1];

    nx2o = rotz(40*pi/180)*roty(-165*pi/180)*[1 ; 0 ; 0];
    ny2o = rotz(40*pi/180)*roty(-165*pi/180)*[0 ; 1 ; 0];
    nz2o = rotz(40*pi/180)*roty(-165*pi/180)*[0 ; 0 ; 1];
end


% false measurement
nx1oe = [1 ; 0 ; 0];    %roty(-30*pi/180)*[1 ; 0 ; 0];
ny1oe = [0 ; 1 ; 0];    %roty(-30*pi/180)*[0 ; 1 ; 0];
nz1oe = [0 ; 0 ; 1];    %roty(-30*pi/180)*[0 ; 0 ; 1];

nx2oe = [-1 ; 0 ; 0];   %roty(-165*pi/180)*[1 ; 0 ; 0];
ny2oe = [0 ; 1 ; 0];    %roty(-165*pi/180)*[0 ; 1 ; 0];
nz2oe = [0 ; 0 ; -1];   %roty(-165*pi/180)*[0 ; 0 ; 1];

Ro   = [n o a];             % 3x3
% dRo  = skew(wo)*Ro ;
[k, ~] = equiaxis(Ro);      % Convert to vector angle

%% Dynamic parameters

Mt = f1.inertia(qt');             % 4x4
Mm = f2.inertia(qm');             % 4x4
Ct = f1.coriolis(qt', qtdot');    % 4x4
Cm = f2.coriolis(qm', qmdot');    % 4x4

mass = [objConfig.mass 0 0;
        0 objConfig.mass 0;
        0 0 objConfig.mass];

Mo = [mass zeros(3,3); zeros(3,3) Io];

M = [Mt          zeros(4,4)   zeros(4,6);
     zeros(4,4)      Mm       zeros(4,6);         % 14x14
     zeros(6,4)  zeros(6,4)      Mo     ];

C = [Ct          zeros(4,4)   zeros(4,6);
     zeros(4,4)      Cm       zeros(4,6);         % 14x14
     zeros(6,4)  zeros(6,4)   zeros(6,6)];

%% Kinematic parameters
% Maps joint velocities to finger tip velocities - rotational and
% translational

% Jacobian for both fingers
J1  = f1.jacob0(qt');                                           % 6x4
J2  = f2.jacob0(qm');                                           % 6x4

% Split up the tranlational and rotational
Jv1 = J1(1:3,:);                                                % 3x4 - tranlational
Jw1 = J1(4:6,:);                                                % 3x4 - rotational

Jv2 = J2(1:3,:);                                                % 3x4
Jw2 = J2(4:6,:);                                                % 3x4

Jv = [-Jv1  Jv2  zeros(3,6)];                                   % 3x14
Jw = [-Jw1  Jw2  zeros(3,6)];                                   % 3x14

% Derivative of the jacobian - big one
dJ1 = four_dof_finger_JacobianDerivative(lt,[qt qtdot]) ;       % 6x4
% Split up the tranlational and rotational
dJv1 = dJ1(1:3,:);                                              % 3x4
dJw1 = dJ1(4:6,:);                                              % 3x4

dJ2 = four_dof_finger_JacobianDerivative(lm,[qm qmdot]) ;       % 6x4
dJv2 = dJ2(1:3,:);                                              % 3x4
dJw2 = dJ2(4:6,:);                                              % 3x4

% Using jacobian to map joint velocities to fingertip velocities
dpt1 = Jv1*qtdot;
dpt2 = Jv2*qmdot;
dwt1 = Jw1*qtdot;
dwt2 = Jw2*qmdot;

% The velocities of the finger tips in relation to the object
dpt1o = Ro'*Jv1*qtdot;
dpt2o = Ro'*Jv2*qmdot;
dwt1o = Ro'*Jw1*qtdot;
dwt2o = Ro'*Jw2*qmdot;

% Position of first and second fingers
T1  = f1.fkine(qt');                                            % 4x4
Rt1 = T1(1:3,1:3);                                              % 3x3
pt1 = T1(1:3,4);                                                % 3x1

T2  = f2.fkine(qm');                                            % 4x4
Rt2 = T2(1:3,1:3);                                              % 3x3
pt2 = T2(1:3,4);                                                % 3x1

% Convert rotation to euler angles
eul1 = rotm2eul(Rt1);
eul2 = rotm2eul(Rt2);

if (simConfig.obj == 1) || (simConfig.obj == 2) || (simConfig.obj == 3)
    % Translation into the reference frame from from object frame
    nx1 =   Ro * nx1o;
    ny1 =   Ro * ny1o;
    nz1 =   Ro * nz1o;
    nx1e =  Ro * nx1oe;
    ny1e =  Ro * ny1oe;
    nz1e =  Ro * nz1oe;
    nx2 =   Ro * nx2o;
    ny2 =   Ro * ny2o;
    nz2 =   Ro * nz2o;
    nx2e =  Ro * nx2oe;
    ny2e =  Ro * ny2oe;
    nz2e =  Ro * nz2oe;
    
    [poc1, dpoc1, poc2, dpoc2, pc1, pc2, poc1o, poc2o] = calcContactPntPos(pt1, r, nx1, po, dpt1, wo, podot, pt2, nx2, dpt2, Ro);
    
elseif simConfig.obj == 4
    pt1o  = po - pt1;
    nx1   = pt1o / norm(pt1o);
    pt2o  = po - pt2;
    nx2   = pt2o / norm(pt2o);
    
    [poc1, dpoc1, poc2, dpoc2, pc1, pc2, poc1o, poc2o] = calcContactPntPos(pt1, r, nx1, po, dpt1, wo, podot, pt2, nx2, dpt2, Ro);
    
    theta1 = atan2(poc1o(2),poc1o(1));
    phis1 = atan2(sqrt(poc1o(1)^2 + poc1o(2)^2),poc1o(3));
    
    theta2 = atan2(poc2o(2),poc2o(1));
    phis2 = atan2(sqrt(poc2o(1)^2 + poc2o(2)^2),poc2o(3));
    
    Roc1 = roty(pi/2 - phis1)*rotz(theta1 - pi);
    Roc2 = roty(pi/2 + phis2)*rotz(-theta2);
    
    Rc1 = Ro*Roc1;
    Rc2 = Ro*Roc2;
    
    ny1 = Rc1(:,2);
    ny2 = Rc2(:,2);
    nz1 = Rc1(:,3);
    nz2 = Rc2(:,3);
    
    nx1e = Ro*nx1oe;
    ny1e = Ro*ny1oe;
    nz1e = Ro*nz1oe;
    nx2e = Ro*nx2oe;
    ny2e = Ro*ny2oe;
    nz2e = Ro*nz2oe;
end

dnx1 = -skew(nx1) * wo;
dny1 = -skew(ny1) * wo;
dnz1 = -skew(nz1) * wo;

dnx2 = -skew(nx2) * wo;
dny2 = -skew(ny2) * wo;
dnz2 = -skew(nz2) * wo;


%% constraints

alpha = 4.16*10^3;
beta = 4.16*10^3;
gamma = 100000;

% Delta matrix from paper
D11  = nx1'*Jv1;                                            % 1x4
dD11 = dnx1'*Jv1 + nx1'*dJv1;
D22  = nx2'*Jv2;                                            % 1x4
dD22 = dnx2'*Jv2 + nx2'*dJv2;

D13  = [ -nx1'   nx1' * skew(poc1)];                          % 1x6
dD13 = [ -dnx1'  dnx1' * skew(poc1) + nx1' * skew(dpoc1)];

D23  = [ -nx2'   nx2' * skew(poc2)];
dD23 = [ -dnx2'  dnx2' * skew(poc2) + nx2' * skew(dpoc2)];

D    = [    D11     zeros(1,4)  D13;                        % 2x14 - 3x18
         zeros(1,4)     D22      D23];
% 
% D    = [    D11     zeros(1,4)  zeros(1,4)    D14; 
%          zeros(1,4)     D22      zeros(1,4)   D24;     % 2x14 - 3x18
%          zeros(1,4)    zeros(1,4)   D33       D34];
     
     
Ddot = [   dD11     zeros(1,4)  dD13;                       % 2x14
        zeros(1,4)      dD22    dD23];
    
% Rolling constraints
A11  = [ny1' * Jv1 + r * nz1' * Jw1;                              % 2x4
        nz1' * Jv1 - r * ny1' * Jw1];
dA11 = [dny1' * Jv1 + ny1' * dJv1 + r * dnz1' * Jw1 + r * nz1' * dJw1;  % 2x4
        dnz1' * Jv1 + nz1' * dJv1 - r * dny1' * Jw1 - r * ny1' * dJw1];
   
A22  = [ny2' * Jv2 + r * nz2' * Jw2;                              % 2x4
       nz2' * Jv2 - r * ny2' * Jw2];
dA22 = [dny2' * Jv2 + ny2' * dJv2 + r * dnz2' * Jw2 + r * nz2' * dJw2;
        dnz2' * Jv2 + nz2' * dJv2 - r * dny2' * Jw2 - r * ny2' * dJw2];
   
A13  = [-ny1' ny1' * skew(poc1);                          % 2x6
        -nz1' nz1' * skew(poc1)];
dA13 = [-dny1' dny1' * skew(poc1) + ny1' * skew(dpoc1);
        -dnz1' dnz1' * skew(poc1) + nz1' * skew(dpoc1)];

A23  = [-ny2' ny2' * skew(poc2);                          % 2x6
        -nz2' nz2' * skew(poc2)];
dA23 = [-dny2' dny2' * skew(poc2) + ny2' * skew(dpoc2);
        -dnz2' dnz2' * skew(poc2) + nz2' * skew(dpoc2)];

A    = [   A11       zeros(2,4) A13;                        % 4x14
         zeros(2,4)     A22     A23];

Adot = [   dA11       zeros(2,4) dA13;                      % 4x14
         zeros(2,4)     dA22     dA23];
  
Phi1 = nx1' * pt1 + nx1' * r * nx1 - nx1' * po  - nx1' * poc1;        % 1x1
Phi2 = nx2' * pt2 + nx2' * r * nx2 - nx2' * po  - nx2' * poc2;        % 1x1
Phi = [Phi1 ; Phi2];                                        % 2x1

%% Controller

% error in tangential directions
nz1est = angvec2r(5 * pi/180, ny1) * nz1;
nx1est = angvec2r(5 * pi/180, nz1)* ny1;
nz2est = angvec2r(5 * pi/180, ny2)* nz2;
nx2est = angvec2r(5 * pi/180, nz2)* ny2;

% estimation of tangential directions
% nx1est = x(39:41);
nc1est = x(42:44);
% nz1est = x(45:47);
% nx2est = x(48:50);
nc2est = x(51:53);
% nz2est = x(54:56);

g1 = [1 0 0;
      0  1 0;
      0  0  1];
  
g2 = [1 0 0;
      0  1 0;
      0  0  1];
  
I = [1 0 0;
    0 1 0;
    0 0 1];

Qs1 = I - (nc1est*nc1est')/(norm(nc1est)^2);
Qs2 = I - (nc2est*nc2est')/(norm(nc2est)^2);

dnest = [
    -(cross(nx1est, nz1est0)/(nz1est' * nz1est0)) * ... 
    (nx1est'*Qs1*(-g1*Qs1*dpt1));
    -g1*Qs1*dpt1;
    -((nc1est * nz1est') + ... 
    ((nc1est' * nz1est0) / (nz1est' * nz1est0)) * ... 
    (nx1est * nx1est')) * Qs1 *(-g1 * Qs1 * dpt1);
    -(cross(nx2est, nz2est0)/(nz2est' * nz2est0)) * ...
    (nx2est' * Qs2 * (-g2 * Qs2 * dpt2));
    -g2 * Qs2 * dpt2;
    -((nc2est * nz2est') + ... 
    ((nc2est' * nz2est0) / (nz2est' * nz2est0)) * ... 
    (nx2est * nx2est')) * Qs2 * (-g2*Qs2*dpt2)
];

% if t > 7
%     gt = -45;
% else
%     gt = 0;
% end

% finger shaping - how much the finger tips have moved on the surface of
% the object.
% dwt - angular velocity
% pint - the rolling distance of each of the finger
p1int = [nz1'*dwt1 ; ny1'*dwt1];
p2int = [-nz2'*dwt2 ; ny2'*dwt2];

% Controlling how much the fingers move on the contact
Nar = [r*fd*Jw1'*[-nz1 ny1]*[ sin(phi2 - phi1 - gt*pi/180) ; sin(psi1 - psi2 - gs*pi/180)];
       r*fd*Jw2'*[-nz2 -ny2]*[ sin(phi2 - phi1 - gt*pi/180) ; sin(psi1 - psi2 - gs*pi/180)];
       0;
       0;
       0;
       0;
       0;
       0];
 
Nardn = [fd*[-nz1 ny1]*[ sin(phi2 - phi1 - gt*pi/180) ; sin(psi1 - psi2 - gs*pi/180)]; 
   fd*[-nz2 -ny2]*[ sin(phi2 - phi1 - gt*pi/180) ; sin(psi1 - psi2 - gs*pi/180)]];

% % only one shaping
% Nar = [r*fd*Jw1'*nx1*sin(psi1 - psi2 - gs*pi/180);
%        -r*fd*Jw2'*nx2*sin(psi1 - psi2 - gs*pi/180);
%        0;
%        0;
%        0;
%        0;
%        0;
%        0];
%    
% Nardn = [fd*Jw1'*nx1*sin(psi1 - psi2 - gs*pi/180); 
%    -fd*Jw2'*nx2*sin(psi1 - psi2 - gs*pi/180)];

% % second shaping
% Nar = [-r*fd*Jw1'*nz1*sin(phi2 - phi1 - gt*pi/180);
%        -r*fd*Jw2'*nz2*sin(phi2 - phi1 - gt*pi/180);
%        0;
%        0;
%        0;
%        0;
%        0;
%        0];
%    
% Nardn = [-fd*Jw1'*nz1*sin(phi2 - phi1 - gt*pi/180); 
%          -fd*Jw2'*nz2*sin(phi2 - phi1 - gt*pi/180)];

% Controller!!!! yay
u = -Kv * xdot - fd * Jv' * (pt2 - pt1) / norm(pt2 - pt1) - Nar;

bpsi1 = asin(nz1' * (pt2 - pt1) / norm(pt2 - pt1));
bpsi2 = asin(nz2' * (pt2 - pt1) / norm(pt2 - pt1));
bphi1 = asin(ny1' * (pt2 - pt1) / norm(pt2 - pt1));
bphi2 = asin(-ny2' * (pt2 - pt1) / norm(pt2 - pt1));

%% Friction for spin

% b = 0.1;
% ws = Ro*Ro'*wo;
% Fr = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; b*ws(2); 0];           % 14x1

% Qspin1 = nc1*nc1';
% Qspin2 = nc2*nc2';

Qspin1 = (pc1-pc2)*(pc1-pc2)'/norm(pc1-pc2);
Qspin2 = (pc1-pc2)*(pc1-pc2)'/norm(pc1-pc2);

wrel1 = dwt1 - wo;
wrel2 = dwt2 - wo;

I3 = [1 0 0;
      0 1 0;
      0 0 1];

Bjw = [Jw1'        zeros(4,3);
       zeros(4,3)  Jw2';
       zeros(3,3)  zeros(3,3);
       -I3         -I3        ];
   
Q = [Ks1*Qspin1     zeros(3,3);
     zeros(3,3)     Ks2*Qspin2];
 
wrel = [wrel1'  wrel2']';


%% System

sys1 = [M     D'         A'    ;                                                    % 20x20
        D zeros(2,2) zeros(2,4);
        A zeros(4,2) zeros(4,4)];
    
sys2 = [u-C*xdot-Bjw*Q*wrel;                                                        % 20x1
        -(Ddot + 2*alpha*D)*xdot-beta^2*Phi;
        -(Adot + 2*gamma*A)*xdot];

qddot = sys1\sys2;                                                                  % 20x1

Rodot = [ -skew(n)*wo;
          -skew(o)*wo;
          -skew(a)*wo ];

f      = qddot(15:16);                                                              % 2x1
lambda = qddot(17:20);                                                              % 4x1

O1 = D13'*f(1);
O2 = D23'*f(2);
O3 = A13'*lambda(1:2);
O4 = A23'*lambda(3:4);

dfi     = [ f(1) - fd*nx1'*(pt2 - pt1)/norm(pt2-pt1);                               % 2x1
            f(2) + fd*nx2'*(pt2 - pt1)/norm(pt2-pt1)];
dlxi    = [ lambda(1) - fd*ny1'*(pt2 - pt1)/norm(pt2-pt1);                          % 2x1
            lambda(3) + fd*ny2'*(pt2 - pt1)/norm(pt2-pt1)];
dlzi    = [ lambda(2) - fd*nz1'*(pt2 - pt1)/norm(pt2-pt1);                          % 2x1
            lambda(4) + fd*nz2'*(pt2 - pt1)/norm(pt2-pt1)];
dni     = [  fd*(-ny1*nz1' + nz1*ny1')*(pt2 - pt1)/norm(pt2-pt1) + Nardn(1:3);      % 6x1
            -fd*(-ny2*nz2' + nz2*ny2')*(pt2 - pt1)/norm(pt2-pt1) + Nardn(4:6)]; 
sn      = fd*(skew(poc1)' - skew(poc2)')*(pt2 - pt1)/norm(pt2-pt1);                 % 3x1
Psi     = A*xdot;                                                                   % 4x1
det5 = [det(J1(1:4,:)) det(J1(2:5,:)) det(J1(3:6,:)) cond(J1)];
det4 = [det(J2(1:4,:)) det(J2(2:5,:)) det(J2(3:6,:)) cond(J2)];

dq = [ qtdot ; qmdot ; podot ; Rodot ; qddot(1:14) ; p1int ; p2int; dnest];         % 38x1

timeConfig.t                = timeConfig.t + 1;
t_out(timeConfig.t,:)       = t(1);
x_out(timeConfig.t,:)       = x;
F(timeConfig.t,:)           = f;
Lambda(timeConfig.t,:)      = lambda;
ptt(timeConfig.t,:)         = pt1;
ptm(timeConfig.t,:)         = pt2;
U(timeConfig.t,:)           = u;
Dfi(timeConfig.t,:)         = dfi;
Dlxi(timeConfig.t,:)        = dlxi;
Dlzi(timeConfig.t,:)        = dlzi;
Dni(timeConfig.t,:)         = dni;
Sn(timeConfig.t,:)          = sn;
phi(timeConfig.t,:)         = Phi;
psi(timeConfig.t,:)         = Psi;
Det5(timeConfig.t,:)        = det5;
Det4(timeConfig.t,:)        = det4;
pct(timeConfig.t,:)         = pc1;
pcm(timeConfig.t,:)         = pc2;
Dpt1(timeConfig.t,:)        = dpt1;
Dpt2(timeConfig.t,:)        = dpt2;
Dwt1(timeConfig.t,:)        = dwt1;
Dwt2(timeConfig.t,:)        = dwt2;
Dpt1o(timeConfig.t,:)       = dpt1o;
Dpt2o(timeConfig.t,:)       = dpt2o;
Dwt1o(timeConfig.t,:)       = dwt1o;
Dwt2o(timeConfig.t,:)       = dwt2o;
Poc1o(timeConfig.t,:)       = poc1o;
Poc2o(timeConfig.t,:)       = poc2o;
o1(timeConfig.t,:)          = O1;
o2(timeConfig.t,:)          = O2;
o3(timeConfig.t,:)          = O3;
o4(timeConfig.t,:)          = O4;
sphi(timeConfig.t,:)        = Nar;
Nx1(timeConfig.t,:)         = ny1;
Nz1(timeConfig.t,:)         = nz1;
Nx2(timeConfig.t,:)         = ny2;
Nz2(timeConfig.t,:)         = nz2;
Nc1(timeConfig.t,:)         = nx1;
Nc2(timeConfig.t,:)         = nx2;
Nx1e(timeConfig.t,:)        = ny1e;
Nz1e(timeConfig.t,:)        = nz1e;
Nx2e(timeConfig.t,:)        = ny2e;
Nz2e(timeConfig.t,:)        = nz2e;
Nc1e(timeConfig.t,:)        = nx1e;
Nc2e(timeConfig.t,:)        = nx2e;
Bpsi1(timeConfig.t,:)       = bpsi1;
Bpsi2(timeConfig.t,:)       = bpsi2;
Bphi1(timeConfig.t,:)       = bphi1;
Bphi2(timeConfig.t,:)       = bphi2;
Eul1(timeConfig.t,:)        = eul1;
Eul2(timeConfig.t,:)        = eul2;
K(timeConfig.t,:)           = k;

waitbar(t / timeConfig.tEnd, timeConfig.barHandle, sprintf('%.3f / %.3f', t, timeConfig.tEnd));
end

function [poc1, dpoc1, poc2, dpoc2, pc1, pc2, poc1o, poc2o] = calcContactPntPos(pt1, r, nc1, po, dpt1, wo, podot, pt2, nc2, dpt2, Ro)
    poc1  = pt1 + r * nc1 - po;
    % skew - changes a vector to a skew matrix 
    dpoc1 = dpt1 - r * skew(nc1) * wo - podot;
    poc2  = pt2 + r * nc2 - po;
    dpoc2 = dpt2 - r * skew(nc2) * wo - podot;
    pc1 = pt1 + r * nc1;
    pc2 = pt2 + r * nc2;
    
    % Calculating object frame from reference frame
    poc1o = Ro' * poc1;
    poc2o = Ro' * poc2;
    
end