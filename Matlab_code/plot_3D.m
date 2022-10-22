
close all

global t_out x_out F Lambda ptt ptm ptt0 ptm0 U Dfi Dlxi Dlzi Dni Sn p0 phi psi Det5 Det4 pct pcm Kd Nx1e Nz1e Nx2e Nz2e Nc1e Nc2e K
global Dpt1 Dpt2 Dwt1 Dwt2 Dpt1o Dpt2o Dwt1o Dwt2o Poc1o Poc2o o1 o2 o3 o4 sphi Nx1 Nz1 Nx2 Nz2 Nc1 Nc2 Dn1 Dn2 Bpsi1 Bpsi2 Bphi1 Bphi2

fsize = 12;

%% States
% Thumb
qt1 = x_out(:,1) ;
qt2 = x_out(:,2) ;
qt3 = x_out(:,3) ;
qt4 = x_out(:,4) ;
qt = [qt1 qt2 qt3 qt4];

dqt = x_out(:,21:24) ;


% Middle
qm1 = x_out(:,5) ;
qm2 = x_out(:,6) ;
qm3 = x_out(:,7) ;
qm4 = x_out(:,8) ;
qm = [qm1 qm2 qm3 qm4];

dqm = x_out(:,25:28);

% controller

ut = U(:,1:5);
um = U(:,6:9);

% contact forces
ft = F(1,:) ;
fm = F(2,:) ;

% tangential forces
ltx = Lambda(1,:) ;
ltz = Lambda(2,:) ;
lmx = Lambda(3,:) ;
lmz = Lambda(4,:) ;

% Object centre generalised velocity
dpo = x_out(:,29:31) ;
wo = x_out(:,32:34) ;

% Object position
po = x_out(:,9:11);

% Object orientation
n = x_out(:,12:14) ;
o = x_out(:,15:17) ;
a = x_out(:,18:20) ;

% Tangential angles
phi1 = x_out(:,35);
psi1 = x_out(:,36);
phi2 = x_out(:,37);
psi2 = x_out(:,38);

% tangential estimations
nx1est = x_out(:,39:41);
nc1est = x_out(:,42:44);
nz1est = x_out(:,45:47);
nx2est = x_out(:,48:50);
nc2est = x_out(:,51:53);
nz2est = x_out(:,54:56);

% nx1est = x_out(:,39:41);
% nz1est = x_out(:,42:44);
% nx2est = x_out(:,45:47);
% nz2est = x_out(:,48:50);


%% Singularities
% 
% figure('Name','Singularities','NumberTitle','off');
% subplot(3,1,1);
% plot(t_out,Det5(:,1:2),'LineWidth', 1);
% title('Thumb','Interpreter','latex','FontSize',fsize);
% ylabel('Determinants','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('1','2');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(3,1,2);
% plot(t_out,Det4(:,1:3),'LineWidth', 1);
% title('Middle','Interpreter','latex','FontSize',fsize);
% ylabel('Determinants','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('1','2','3');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(3,1,3);
% plot(t_out,Det5(:,3),t_out,Det4(:,4),'LineWidth', 1);
% title('Cond','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('5','4');set(h21,'Interpreter','latex','FontSize',fsize);
% box on


%% Tangential estimations

figure('Name','Tangential estimations','NumberTitle','off');
subplot(3,2,1);
plot(t_out,nc1est(:,1),'b-', t_out, Nc1(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,nc1est(:,2),'g-', t_out, Nc1(:,2), 'g--','LineWidth', 1);
plot(t_out,nc1est(:,3),'r-', t_out, Nc1(:,3), 'r--','LineWidth', 1);
title('Finger 1')
ylabel('nc1','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,2);
plot(t_out,nc2est(:,1),'b-', t_out, Nc2(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,nc2est(:,2),'g-', t_out, Nc2(:,2), 'g--','LineWidth', 1);
plot(t_out,nc2est(:,3),'r-', t_out, Nc2(:,3), 'r--','LineWidth', 1);
title('Finger 2')
ylabel('nc2','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,3);
plot(t_out,nx1est(:,1),'b-', t_out, Nx1(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,nx1est(:,2),'g-', t_out, Nx1(:,2), 'g--','LineWidth', 1);
plot(t_out,nx1est(:,3),'r-', t_out, Nx1(:,3), 'r--','LineWidth', 1);
ylabel('ny1','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,4);
plot(t_out,nx2est(:,1),'b-', t_out, Nx2(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,nx2est(:,2),'g-', t_out, Nx2(:,2), 'g--','LineWidth', 1);
plot(t_out,nx2est(:,3),'r-', t_out, Nx2(:,3), 'r--','LineWidth', 1);
ylabel('ny2','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,5);
plot(t_out,nz1est(:,1),'b-', t_out, Nz1(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,nz1est(:,2),'g-', t_out, Nz1(:,2), 'g--','LineWidth', 1);
plot(t_out,nz1est(:,3),'r-', t_out, Nz1(:,3), 'r--','LineWidth', 1);
ylabel('nz1','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,6);
plot(t_out,nz2est(:,1),'b-', t_out, Nz2(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,nz2est(:,2),'g-', t_out, Nz2(:,2), 'g--','LineWidth', 1);
plot(t_out,nz2est(:,3),'r-', t_out, Nz2(:,3), 'r--','LineWidth', 1);
ylabel('nz2','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on

xtc = [ 0; nc1est(end,1) ] ;
ytc = [ 0; nc1est(end,2) ] ;
ztc = [ 0; nc1est(end,3) ] ;

xtt = [ 0; nx1est(end,1) ] ;
ytt = [ 0; nx1est(end,2) ] ;
ztt = [ 0; nx1est(end,3) ] ;

xcc = [ 0; nz1est(end,1) ] ;
ycc = [ 0; nz1est(end,2) ] ;
zcc = [ 0; nz1est(end,3) ] ;

xtcr = [ 0; Nc1(end,1) ] ;
ytcr = [ 0; Nc1(end,2) ] ;
ztcr = [ 0; Nc1(end,3) ] ;

xttr = [ 0; Nx1(end,1) ] ;
yttr = [ 0; Nx1(end,2) ] ;
zttr = [ 0; Nx1(end,3) ] ;

xccr = [ 0; Nz1(end,1) ] ;
yccr = [ 0; Nz1(end,2) ] ;
zccr = [ 0; Nz1(end,3) ] ;

figure('Name','tangential vectors','NumberTitle','off');
plot3(xtc,ytc,ztc,'b-','LineWidth', 1)
hold all
plot3(xtt,ytt,ztt,'g-','LineWidth', 1)
plot3(xcc,ycc,zcc,'r-','LineWidth', 1)
plot3(xtcr,ytcr,ztcr,'b--','LineWidth', 1)
plot3(xttr,yttr,zttr,'g--','LineWidth', 1)
plot3(xccr,yccr,zccr,'r--','LineWidth', 1)
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$nc1$ est','$ny1$ est','$nz1$ est', '$nc1$ real','$ny1$ real','$nz1$ real');set(h21,'Interpreter','latex','FontSize',fsize);
axis equal
box on

xtc2 = [ 0; nc2est(end,1) ] ;
ytc2 = [ 0; nc2est(end,2) ] ;
ztc2 = [ 0; nc2est(end,3) ] ;

xtt2 = [ 0; nx2est(end,1) ] ;
ytt2 = [ 0; nx2est(end,2) ] ;
ztt2 = [ 0; nx2est(end,3) ] ;

xcc2 = [ 0; nz2est(end,1) ] ;
ycc2 = [ 0; nz2est(end,2) ] ;
zcc2 = [ 0; nz2est(end,3) ] ;

xtcr2 = [ 0; Nc2(end,1) ] ;
ytcr2 = [ 0; Nc2(end,2) ] ;
ztcr2 = [ 0; Nc2(end,3) ] ;

xttr2 = [ 0; Nx2(end,1) ] ;
yttr2 = [ 0; Nx2(end,2) ] ;
zttr2 = [ 0; Nx2(end,3) ] ;

xccr2 = [ 0; Nz2(end,1) ] ;
yccr2 = [ 0; Nz2(end,2) ] ;
zccr2 = [ 0; Nz2(end,3) ] ;

figure('Name','tangential vectors 2','NumberTitle','off');
plot3(xtc2,ytc2,ztc2,'b-','LineWidth', 1)
hold all
plot3(xtt2,ytt2,ztt2,'g-','LineWidth', 1)
plot3(xcc2,ycc2,zcc2,'r-','LineWidth', 1)
plot3(xtcr2,ytcr2,ztcr2,'b--','LineWidth', 1)
plot3(xttr2,yttr2,zttr2,'g--','LineWidth', 1)
plot3(xccr2,yccr2,zccr2,'r--','LineWidth', 1)
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$nc2$ est','$ny2$ est','$nz2$ est', '$nc2$ real','$ny2$ real','$nz2$ real');set(h21,'Interpreter','latex','FontSize',fsize);
axis equal
box on

%% Contact surface orientation

figure('Name','Contact surface orientation','NumberTitle','off');
subplot(3,2,1);
plot(t_out,Nc1e(:,1),'b-', t_out, Nc1(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,Nc1e(:,2),'g-', t_out, Nc1(:,2), 'g--','LineWidth', 1);
plot(t_out,Nc1e(:,3),'r-', t_out, Nc1(:,3), 'r--','LineWidth', 1);
title('Finger 1')
ylabel('nc1','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,2);
plot(t_out,Nc2e(:,1),'b-', t_out, Nc2(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,Nc2e(:,2),'g-', t_out, Nc2(:,2), 'g--','LineWidth', 1);
plot(t_out,Nc2e(:,3),'r-', t_out, Nc2(:,3), 'r--','LineWidth', 1);
title('Finger 2')
ylabel('nc2','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,3);
plot(t_out,Nx1e(:,1),'b-', t_out, Nx1(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,Nx1e(:,2),'g-', t_out, Nx1(:,2), 'g--','LineWidth', 1);
plot(t_out,Nx1e(:,3),'r-', t_out, Nx1(:,3), 'r--','LineWidth', 1);
ylabel('ny1','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,4);
plot(t_out,Nx2e(:,1),'b-', t_out, Nx2(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,Nx2e(:,2),'g-', t_out, Nx2(:,2), 'g--','LineWidth', 1);
plot(t_out,Nx2e(:,3),'r-', t_out, Nx2(:,3), 'r--','LineWidth', 1);
ylabel('ny2','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,5);
plot(t_out,Nz1e(:,1),'b-', t_out, Nz1(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,Nz1e(:,2),'g-', t_out, Nz1(:,2), 'g--','LineWidth', 1);
plot(t_out,Nz1e(:,3),'r-', t_out, Nz1(:,3), 'r--','LineWidth', 1);
ylabel('nz1','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,2,6);
plot(t_out,Nz2e(:,1),'b-', t_out, Nz2(:,1), 'b--','LineWidth', 1);
hold on
plot(t_out,Nz2e(:,2),'g-', t_out, Nz2(:,2), 'g--','LineWidth', 1);
plot(t_out,Nz2e(:,3),'r-', t_out, Nz2(:,3), 'r--','LineWidth', 1);
ylabel('nz2','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('est','real');set(h21,'Interpreter','latex','FontSize',fsize);
box on

xtc = [ 0; Nc1e(end,1) ] ;
ytc = [ 0; Nc1e(end,2) ] ;
ztc = [ 0; Nc1e(end,3) ] ;

xtt = [ 0; Nx1e(end,1) ] ;
ytt = [ 0; Nx1e(end,2) ] ;
ztt = [ 0; Nx1e(end,3) ] ;

xcc = [ 0; Nz1e(end,1) ] ;
ycc = [ 0; Nz1e(end,2) ] ;
zcc = [ 0; Nz1e(end,3) ] ;

xtcr = [ 0; Nc1(end,1) ] ;
ytcr = [ 0; Nc1(end,2) ] ;
ztcr = [ 0; Nc1(end,3) ] ;

xttr = [ 0; Nx1(end,1) ] ;
yttr = [ 0; Nx1(end,2) ] ;
zttr = [ 0; Nx1(end,3) ] ;

xccr = [ 0; Nz1(end,1) ] ;
yccr = [ 0; Nz1(end,2) ] ;
zccr = [ 0; Nz1(end,3) ] ;

figure('Name','Contact vectors','NumberTitle','off');
plot3(xtc,ytc,ztc,'b-','LineWidth', 1)
hold all
plot3(xtt,ytt,ztt,'g-','LineWidth', 1)
plot3(xcc,ycc,zcc,'r-','LineWidth', 1)
plot3(xtcr,ytcr,ztcr,'b--','LineWidth', 1)
plot3(xttr,yttr,zttr,'g--','LineWidth', 1)
plot3(xccr,yccr,zccr,'r--','LineWidth', 1)
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$nc1$ est','$ny1$ est','$nz1$ est', '$nc1$ real','$ny1$ real','$nz1$ real');set(h21,'Interpreter','latex','FontSize',fsize);
axis equal
box on

xtc2 = [ 0; Nc2e(end,1) ] ;
ytc2 = [ 0; Nc2e(end,2) ] ;
ztc2 = [ 0; Nc2e(end,3) ] ;

xtt2 = [ 0; Nx2e(end,1) ] ;
ytt2 = [ 0; Nx2e(end,2) ] ;
ztt2 = [ 0; Nx2e(end,3) ] ;

xcc2 = [ 0; Nz2e(end,1) ] ;
ycc2 = [ 0; Nz2e(end,2) ] ;
zcc2 = [ 0; Nz2e(end,3) ] ;

xtcr2 = [ 0; Nc2(end,1) ] ;
ytcr2 = [ 0; Nc2(end,2) ] ;
ztcr2 = [ 0; Nc2(end,3) ] ;

xttr2 = [ 0; Nx2(end,1) ] ;
yttr2 = [ 0; Nx2(end,2) ] ;
zttr2 = [ 0; Nx2(end,3) ] ;

xccr2 = [ 0; Nz2(end,1) ] ;
yccr2 = [ 0; Nz2(end,2) ] ;
zccr2 = [ 0; Nz2(end,3) ] ;

figure('Name','Contact vectors','NumberTitle','off');
plot3(xtc2,ytc2,ztc2,'b-','LineWidth', 1)
hold all
plot3(xtt2,ytt2,ztt2,'g-','LineWidth', 1)
plot3(xcc2,ycc2,zcc2,'r-','LineWidth', 1)
plot3(xtcr2,ytcr2,ztcr2,'b--','LineWidth', 1)
plot3(xttr2,yttr2,zttr2,'g--','LineWidth', 1)
plot3(xccr2,yccr2,zccr2,'r--','LineWidth', 1)
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$nc2$ est','$ny2$ est','$nz2$ est', '$nc2$ real','$ny2$ real','$nz2$ real');set(h21,'Interpreter','latex','FontSize',fsize);
axis equal
box on


%% tangential angles

figure('Name','tangential angles','NumberTitle','off');
subplot(2,2,1);
plot(t_out,rad2deg(phi1),t_out, rad2deg(psi1), 'LineWidth', 1);
title('Thumb','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\phi_1$','$\psi_1$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,2,2);
plot(t_out,rad2deg(phi2), t_out, rad2deg(psi2),'LineWidth', 1);
title('Middle','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\phi_2$','$\psi_2$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,2,3);
hold all
plot(t_out,rad2deg(phi2-phi1),'LineWidth', 1);
plot(t_out, rad2deg(Bphi1), t_out, rad2deg(Bphi2), 'LineWidth', 1);
title('Relative angle','Interpreter','latex','FontSize',fsize);
ylabel('$\phi_2 - \phi_1$ $[deg]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
box on
subplot(2,2,4);
hold all
plot(t_out,rad2deg(psi1-psi2),'LineWidth', 1);
plot(t_out, rad2deg(Bpsi1)-90, t_out, rad2deg(Bpsi2)-90, 'LineWidth', 1);
title('Relative angle','Interpreter','latex','FontSize',fsize);
ylabel('$\psi_1 - \psi_2$ $[deg]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
box on




%% vectors

xtt = [ ptt(end,1); ptm(end,1) ] ;
ytt = [ ptt(end,2); ptm(end,2) ] ;
ztt = [ ptt(end,3); ptm(end,3) ] ;

xcc = [ pct(end,1); pcm(end,1) ] ;
ycc = [ pct(end,2); pcm(end,2) ] ;
zcc = [ pct(end,3); pcm(end,3) ] ;
% 
% xk = [ po(end,1); po(end,1)+Kd(end,1) ];
% yk = [ po(end,2); po(end,2)+Kd(end,2) ];
% zk = [ po(end,3); po(end,3)+Kd(end,3) ];
% 
figure('Name','Vectors','NumberTitle','off');
plot3(xtt,ytt,ztt,'LineWidth', 1)
hold all
plot3(xcc,ycc,zcc,'LineWidth', 1)
% plot3(xk,yk,zk,'LineWidth',1)
plot3(0,0,0)
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$t_1 t_2$','$c_1 c_2$','$k_d$');set(h21,'Interpreter','latex','FontSize',fsize);
box on

%% spinning

xw = [ po(end,1); po(end,1)+wo(end,1) ];
yw = [ po(end,2); po(end,2)+wo(end,2) ];
zw = [ po(end,3); po(end,3)+wo(end,3) ];

% figure('Name','Spinning','NumberTitle','off');
% plot3(xtt,ytt,ztt,'LineWidth', 1)
% hold all
% plot3(xw,yw,zw,'LineWidth',1)
% plot3(0,0,0)
% ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
% zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$t_1 t_2$','$w_o$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on



%% Poc 

% figure('Name','poc','NumberTitle','off');
% subplot(2,1,1);
% plot(t_out,Poc1o,'LineWidth', 1);
% ylabel('$p_{oc1}$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,1,2);
% plot(t_out,Poc2o,'LineWidth', 1);
% ylabel('$p_{oc2}$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on


%% Contact point trajectory

figure('Name','Contact point trajectory','NumberTitle','off');
plot3(Poc1o(:,1),Poc1o(:,2),Poc1o(:,3),'LineWidth', 1)
hold all
plot3(Poc2o(:,1),Poc2o(:,2),Poc2o(:,3),'LineWidth', 1)
plot3(Poc1o(1,1),Poc1o(1,2),Poc1o(1,3),'rx','LineWidth', 1)
plot3(Poc1o(end,1),Poc1o(end,2),Poc1o(end,3),'r>','LineWidth', 1)
plot3(Poc2o(1,1),Poc2o(1,2),Poc2o(1,3),'rx','LineWidth', 1)
plot3(Poc2o(end,1),Poc2o(end,2),Poc2o(end,3),'r>','LineWidth', 1)
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$thumb$','$middle$');set(h21,'Interpreter','latex','FontSize',fsize);
box on

%% Object equation 

% figure('Name','Object equation','NumberTitle','off');
% subplot(5,1,1);
% plot(t_out,o1,'LineWidth', 1);
% ylabel('$O_1$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$','$wx$','$wy$','$wz$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(5,1,2);
% plot(t_out,o2,'LineWidth', 1);
% ylabel('$O_2$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$','$wx$','$wy$','$wz$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(5,1,3);
% plot(t_out,o3,'LineWidth', 1);
% ylabel('$O_3$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$','$wx$','$wy$','$wz$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(5,1,4);
% plot(t_out,o4,'LineWidth', 1);
% ylabel('$O_4$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$','$wx$','$wy$','$wz$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(5,1,5);
% plot(t_out,o1+o2+o3+o4,'LineWidth', 1);
% ylabel('$all$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$','$wx$','$wy$','$wz$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on



%% Constraints

figure('Name','Constraints','NumberTitle','off');
subplot(2,1,1);
plot(t_out,phi,'LineWidth', 1);
title('Contact constraints','Interpreter','latex','FontSize',fsize);
ylabel('$\Phi_i$ $[deg]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\Phi_1$','$\Phi_2$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,1,2);
plot(t_out,psi,'LineWidth', 1);
title('Rolling constraints','Interpreter','latex','FontSize',fsize);
ylabel('$\Psi_i$ $[deg]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\Psi_{1x}$','$\Psi_{1z}$','$\Psi_{2x}$','$\Psi_{2z}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on


%% Joint angles time response

% figure('Name','Joints angles','NumberTitle','off');
% subplot(2,1,1);
% plot(t_out,rad2deg(qt),'LineWidth', 1);
% title('Thumb','Interpreter','latex','FontSize',fsize);
% ylabel('$q_t$ $[deg]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$q_{t1}$','$q_{t2}$','$q_{t3}$','$q_{t4}$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,1,2);
% plot(t_out,rad2deg(qm),'LineWidth', 1);
% title('Middle','Interpreter','latex','FontSize',fsize);
% ylabel('$q_m$ $[deg]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$q_{m1}$','$q_{m2}$','$q_{m3}$','$q_{m4}$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on


%% Joint velocity time response

figure('Name','Joints velocities','NumberTitle','off')
subplot(2,1,1)
plot(t_out,rad2deg(dqt),'LineWidth', 1)
% title('Thumb','Interpreter','latex','FontSize',fsize);
ylabel('$\dot{q}_1$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\dot{q}_{11}$','$\dot{q}_{12}$','$\dot{q}_{13}$','$\dot{q}_{14}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on;
subplot(2,1,2)
plot(t_out,rad2deg(dqm),'LineWidth', 1)
% title('Middle','Interpreter','latex','FontSize',fsize);
ylabel('$\dot{q}_2$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\dot{q}_{21}$','$\dot{q}_{22}$','$\dot{q}_{23}$','$\dot{q}_{24}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on;


%% Object's velocity time response

figure('Name','Object velocity','NumberTitle','off')
subplot(2,1,1)
plot(t_out,dpo,'LineWidth', 1)
title('Linear velocity','Interpreter','latex','FontSize',fsize);
ylabel('$\dot{p}_o$ $[m/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on;
subplot(2,1,2)
plot(t_out,rad2deg(wo),'LineWidth', 1)
title('Angular velocity','Interpreter','latex','FontSize',fsize);
ylabel('$\omega_o$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on;

%% Object's position

figure('Name','Object position','NumberTitle','off')
plot(t_out,po,'LineWidth', 1)
ylabel('$p_o$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on;

%% Object's orientation

figure('Name','Object orientation','NumberTitle','off')
plot(t_out,n, 'Color', [0 0.4470 0.7410], 'LineWidth', 1)
hold on
plot(t_out, o, 'Color', [0.85 0.325 0.098], 'LineWidth', 1)
plot(t_out, a, 'Color', [0.929 0.694 0.125], 'LineWidth', 1)
ylabel('$R_o$ $[m]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$n_x$','$n_y$','$n_z$','$o_x$','$o_y$','$o_z$','$a_x$','$a_y$','$a_z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on;

%% Object's center trajectory

% figure('Name','Object trajectory','NumberTitle','off')
% plot3(po(:,1), po(:,2), po(:,3) ,'LineWidth', 1)
% hold on
% plot3(p0(1),p0(2),p0(3),'rx','LineWidth', 1)
% plot3(po(end,1), po(end,2), po(end,3) ,'r>','LineWidth', 1)
% ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
% zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
% box on;



%% Fingertips position time response

% figure('Name','Fingertips position','NumberTitle','off');
% subplot(2,1,1)
% plot(t_out,ptt,'LineWidth', 1);
% title('Thumb','Interpreter','latex','FontSize',fsize); 
% ylabel('$p_{t1}$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,1,2)
% plot(t_out,ptm,'LineWidth', 1)
% title('Middle','Interpreter','latex','FontSize',fsize); 
% ylabel('$p_{t2}$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% 
%% Fingertips velocity time response

figure('Name','Fingertips velocity','NumberTitle','off');
subplot(2,2,1)
plot(t_out,Dpt1,'LineWidth', 1);
title('Thumb','Interpreter','latex','FontSize',fsize); 
ylabel('$\dot{p}_{t1}$ $[m/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,2,2)
plot(t_out,Dpt2,'LineWidth', 1)
title('Middle','Interpreter','latex','FontSize',fsize); 
ylabel('$\dot{p}_{t2}$ $[m/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,2,3)
plot(t_out,rad2deg(Dwt1),'LineWidth', 1);
title('Thumb','Interpreter','latex','FontSize',fsize); 
ylabel('$w_{t1}$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,2,4)
plot(t_out,rad2deg(Dwt2),'LineWidth', 1)
title('Middle','Interpreter','latex','FontSize',fsize); 
ylabel('$w_{t2}$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
% 
% %% Fingertips velocity with respect to object time response
% 
% figure('Name','Fingertips velocity with respect to object','NumberTitle','off');
% subplot(2,2,1)
% plot(t_out,Dpt1o,'LineWidth', 1);
% title('Thumb','Interpreter','latex','FontSize',fsize); 
% ylabel('$\dot{p}_{t1}$ $[m/s]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,2,2)
% plot(t_out,Dpt2o,'LineWidth', 1)
% title('Middle','Interpreter','latex','FontSize',fsize); 
% ylabel('$\dot{p}_{t2}$ $[m/s]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,2,3)
% plot(t_out,rad2deg(Dwt1o),'LineWidth', 1);
% title('Thumb','Interpreter','latex','FontSize',fsize); 
% ylabel('$w_{t1}$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,2,4)
% plot(t_out,rad2deg(Dwt2o),'LineWidth', 1)
% title('Middle','Interpreter','latex','FontSize',fsize); 
% ylabel('$w_{t2}$ $[deg/s]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$x$','$y$','$z$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% 
% 
% 
% %% Tip trajectory
% 
% figure('Name','Fingertips trajectory','NumberTitle','off');
% plot3(ptt(:,1),ptt(:,2),ptt(:,3),'LineWidth', 1)
% hold all
% plot3(ptm(:,1),ptm(:,2),ptm(:,3),'LineWidth', 1)
% plot3(ptt0(1),ptt0(2),ptt0(3),'rx','LineWidth', 1)
% plot3(ptt(end,1),ptt(end,2),ptt(end,3),'r>','LineWidth', 1)
% plot3(ptm0(1),ptm0(2),ptm0(3),'rx','LineWidth', 1)
% plot3(ptm(end,1),ptm(end,2),ptm(end,3),'r>','LineWidth', 1)
% ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
% zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$thumb$','$middle$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% 
% 
% %% Contact point trajectory
% 
% figure('Name','Contact point trajectory','NumberTitle','off');
% plot3(pct(:,1),pct(:,2),pct(:,3),'LineWidth', 1)
% hold all
% plot3(pcm(:,1),pcm(:,2),pcm(:,3),'LineWidth', 1)
% plot3(pct(1,1),pct(1,2),pct(1,3),'rx','LineWidth', 1)
% plot3(pct(end,1),pct(end,2),pct(end,3),'r>','LineWidth', 1)
% plot3(pcm(1,1),pcm(1,2),pcm(1,3),'rx','LineWidth', 1)
% plot3(pcm(end,1),pcm(end,2),pcm(end,3),'r>','LineWidth', 1)
% ylabel('$y$ $[m]$','Interpreter','latex','FontSize',fsize);
% xlabel('$x$ $[m]$','Interpreter','latex','FontSize',fsize);
% zlabel('$z$ $[m]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$thumb$','$middle$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on


%% % Controllers

figure('Name','Input torques','NumberTitle','off');
subplot(2,1,1)
plot(t_out,ut,'LineWidth', 1)
title('Thumb','Interpreter','latex','FontSize',fsize) ;
ylabel('$u_t$ $[Nm]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$u_{t1}$','$u_{t2}$','$u_{t3}$','$u_{t4}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,1,2)
plot(t_out,um,'LineWidth', 1)
title('Middle','Interpreter','latex','FontSize',fsize) ;
ylabel('$u_m$ $[Nm]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$u_{m1}$','$u_{m2}$','$u_{m3}$','$u_{m4}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on


%% Force time response

figure('Name','Contact normal forces','NumberTitle','off')
plot(t_out,F,'LineWidth', 1)
ylabel('$f_i$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$f_{1}$','$f_{2}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on

figure('Name','Contact tangential forces','NumberTitle','off')
plot(t_out,Lambda,'LineWidth', 1)
ylabel('$\lambda_i$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\lambda_{x1}$','$\lambda_{z1}$','$\lambda_{x2}$','$\lambda_{z2}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on

w=[rad2deg(atan2(sqrt(Lambda(:,1).^2+Lambda(:,2).^2),F(:,1)))   rad2deg(atan2(sqrt(Lambda(:,3).^2+Lambda(:,4).^2),F(:,2)))];


figure('Name','Force angles','NumberTitle','off')
plot(t_out,w,'LineWidth', 1)
ylabel('$\tan^{-1}(\frac{\sqrt{\lambda_{yi} + \lambda_{zi}}}{f_i})$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$i=1$','$i=2$');set(h21,'Interpreter','latex','FontSize',fsize);
box on

fc = [sqrt(Lambda(:,1).^2+Lambda(:,2).^2 + F(:,1).^2) sqrt(Lambda(:,3).^2+Lambda(:,4).^2 + F(:,2).^2)];

figure('Name','Grasping force','NumberTitle','off')
plot(t_out,fc,'LineWidth', 1)
ylabel('$f_{ci}$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$f_{c1}$','$f_{c2}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on


%% Force errors

figure('Name','Force errors','NumberTitle','off');
subplot(3,1,1)
plot(t_out,Dfi,'LineWidth', 1)
ylabel('$\Delta f_i$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\Delta f_1$','$\Delta f_2$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,1,2)
plot(t_out,Dlxi,'LineWidth', 1)
ylabel('$\Delta \lambda_{yi}$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\Delta \lambda_{y1}$','$\Delta \lambda_{y2}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(3,1,3)
plot(t_out,Dlzi,'LineWidth', 1)
ylabel('$\Delta \lambda_{zi}$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\Delta \lambda_{z1}$','$\Delta \lambda_{z2}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on


%% Torque errors

figure('Name','Torque errors','NumberTitle','off');
subplot(2,1,1)
plot(t_out,Dni,'LineWidth', 1)
ylabel('$\Delta N_{i}$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$\Delta N_{1x}$','$\Delta N_{1y}$','$\Delta N_{1z}$','$\Delta N_{2x}$','$\Delta N_{2y}$','$\Delta N_{2z}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on
subplot(2,1,2)
plot(t_out,Sn,'LineWidth', 1)
ylabel('$S_N$ $[N]$','Interpreter','latex','FontSize',fsize);
xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
h21 = legend('$S_{Nx}$','$S_{Ny}$','$S_{Nz}$');set(h21,'Interpreter','latex','FontSize',fsize);
box on


% %% DN
% 
% figure('Name','Dn','NumberTitle','off');
% subplot(2,1,1)
% plot(t_out,Dn1,'LineWidth', 1)
% ylabel('$\Delta N_{i}$ $[N]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$\Delta N_{1x}$','$\Delta N_{1y}$','$\Delta N_{1z}$','$\Delta N_{2x}$','$\Delta N_{2y}$','$\Delta N_{2z}$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on
% subplot(2,1,2)
% plot(t_out,Dn2,'LineWidth', 1)
% ylabel('$\Delta N_{i}$ $[N]$','Interpreter','latex','FontSize',fsize);
% xlabel('$t$ $[sec]$','Interpreter','latex','FontSize',fsize);
% h21 = legend('$\Delta N_{1x}$','$\Delta N_{1y}$','$\Delta N_{1z}$','$\Delta N_{2x}$','$\Delta N_{2y}$','$\Delta N_{2z}$');set(h21,'Interpreter','latex','FontSize',fsize);
% box on


%% animation


% animation;

