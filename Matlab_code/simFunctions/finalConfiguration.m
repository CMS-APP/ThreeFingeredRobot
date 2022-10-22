function finalConfiguration(simConfig, objConfig, linkConfig)

global x_out ptt ptm r lt lm pct pcm
global f1 f2 Nc1 Nx1 Nz1 Nc2 Nx2 Nz2 K Eul1 Eul2

figure('Name', 'Final Configuration', 'NumberTitle', 'off')

% skin color
color = [185 124 109]./255;
colortip = [206 150 124]./255;

qt1 = x_out(end,1) ;
qt2 = x_out(end,2) ;
qt3 = x_out(end,3) ;
qt4 = x_out(end,4) ;
qt = [qt1 qt2 qt3 qt4];

qm1 = x_out(end,5) ;
qm2 = x_out(end,6) ;
qm3 = x_out(end,7) ;
qm4 = x_out(end,8) ;
qm = [qm1 qm2 qm3 qm4];

% Object position & orientation
po = x_out(end,9:11)';
n = x_out(end,12:14)';
o = x_out(end,15:17)';
a = x_out(end,18:20)';

createObject(simConfig, objConfig, n, o, a, po)

% Create fingers
T11 = linkConfig.links1(1).A(qt1);
T21 = linkConfig.links1(2).A(qt2);
T31 = linkConfig.links1(3).A(qt3);
T41 = linkConfig.links1(4).A(qt4);

T12t = T11*T21;
Rt2 = T12t(1:3,1:3);
pt2 = T12t(1:3,4);

T13t = T12t*T31;
Rt3 = T13t(1:3,1:3);
pt3 = T13t(1:3,4);

T14t = T13t*T41;
Rt4 = T14t(1:3,1:3);
pt4 = T14t(1:3,4);

T4 = f1.fkine(qt');
Rtt = T4(1:3,1:3);

T12 = linkConfig.links2(1).A(qm1);
T22 = linkConfig.links2(2).A(qm2);
T32 = linkConfig.links2(3).A(qm3);
T42 = linkConfig.links2(4).A(qm4);

T12m = f2.base*T12*T22;
Rm2 = T12m(1:3,1:3);
pm2 = T12m(1:3,4); %+ pbase;

T13m = T12m*T32;
Rm3 = T13m(1:3,1:3);
pm3 = T13m(1:3,4); %+ pbase;

T14m = T13m*T42;
Rm4 = T14m(1:3,1:3);
pm4 = T14m(1:3,4); %+ pbase;

T4 = f2.fkine(qm');
Rtm = T4(1:3,1:3);

% thumb joint spheres

R = 0.015/2;
tipt = ptt(end,:)' + Rtt*[r-R ;0 ;0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs,R.*ys,R.*zs);
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + pt2(1),R.*ys + pt2(2),R.*zs + pt2(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + pt3(1),R.*ys + pt3(2),R.*zs + pt3(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + pt4(1),R.*ys + pt4(2),R.*zs + pt4(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + tipt(1),R.*ys + tipt(2),R.*zs + tipt(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1,'FaceAlpha',simConfig.alpha);

% middle joint spheres
R = 0.015/2;
tipm = ptm(end, :)' + Rtm*[r - R ;0 ;0];
[xs, ys, zs] = sphere(50);

basePosY = f2.base(2, 4);
hSurface = surf(R.*xs,R.*ys + basePosY,R.*zs);
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + pm2(1), R.*ys + pm2(2), R.*zs + pm2(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + pm3(1), R.*ys + pm3(2), R.*zs + pm3(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + pm4(1), R.*ys + pm4(2), R.*zs + pm4(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
hSurface = surf(R.*xs + tipm(1),R.*ys + tipm(2),R.*zs + tipm(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1, 'FaceAlpha', simConfig.alpha);

% First Finger Links
[xt2, yt2, zt2] = cylinder(R);
zt2 = lt(1).*zt2;
[xnewt2, ynewt2, znewt2] = cylinderPosition(xt2, yt2, zt2, Rt2);
hSurface = surf(xnewt2, ynewt2, znewt2);
set(hSurface,'FaceColor', color, 'EdgeAlpha', 0.1);

[xt3, yt3, zt3] = cylinder(R);
zt3 = lt(2).*zt3;
[xnewt3, ynewt3, znewt3] = cylinderPosition(xt3, yt3, zt3, Rt3);
hSurface = surf(xnewt3 + pt3(1), ynewt3 + pt3(2), znewt3 + pt3(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xt4, yt4, zt4] = cylinder(R);
zt4 = (lt(3)+r/2).*zt4;
[xnewt4, ynewt4, znewt4] = cylinderPosition(xt4, yt4, zt4, Rt4);
hSurface = surf(xnewt4 + pt4(1), ynewt4 + pt4(2), znewt4 + pt4(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1, 'FaceAlpha', simConfig.alpha);

% Second Finger Links
[xm2, ym2, zm2] = cylinder(R);
zm2 = lm(1).*zm2;
[xnewm2, ynewm2, znewm2] = cylinderPosition(xm2, ym2, zm2, Rm2);
hSurface = surf(xnewm2, ynewm2 + basePosY,znewm2);
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xm3, ym3, zm3] = cylinder(R);
zm3 = lm(2).*zm3;
[xnewm3, ynewm3, znewm3] = cylinderPosition(xm3, ym3, zm3, Rm3);
hSurface = surf(xnewm3 + pm3(1), ynewm3 + pm3(2), znewm3 + pm3(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1);

[xm4, ym4, zm4] = cylinder(R);
zm4 = (lm(3)+r/2).*zm4;
[xnewm4, ynewm4, znewm4] = cylinderPosition(xm4, ym4, zm4, Rm4);
hSurface = surf(xnewm4 + pm4(1), ynewm4 + pm4(2), znewm4 + pm4(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha',0.1, 'FaceAlpha', simConfig.alpha);

% First Fingertip
[xnewt, ynewt, znewt] = fingertipPosition(Rtt, -pi/2);
hSurface = surf(r.*xnewt + ptt(end,1), r.*ynewt + ptt(end,2), r.*znewt + ptt(end,3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

% Second Fingertip
[xnewm, ynewm, znewm] = fingertipPosition(Rtm, pi/2);
hSurface = surf(r.*xnewm + ptm(end,1), r.*ynewm + ptm(end,2), r.*znewm + ptm(end,3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

if simConfig.test == 1
%     xtt = Rtt(:,1);
%     ytt = Rtt(:,2);
%     ztt = Rtt(:,3);
%     quiver3(ptt(end,1),ptt(end,2),ptt(end,3),0.02*xtt(1),0.02*xtt(2),0.02*xtt(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(ptt(end,1),ptt(end,2),ptt(end,3),0.02*ytt(1),0.02*ytt(2),0.02*ytt(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(ptt(end,1),ptt(end,2),ptt(end,3),0.02*ztt(1),0.02*ztt(2),0.02*ztt(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
% 
%     xtm = Rtm(:,1);
%     ytm = Rtm(:,2);
%     ztm = Rtm(:,3);
%     quiver3(ptm(end,1),ptm(end,2),ptm(end,3),0.02*xtm(1),0.02*xtm(2),0.02*xtm(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(ptm(end,1),ptm(end,2),ptm(end,3),0.02*ytm(1),0.02*ytm(2),0.02*ytm(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(ptm(end,1),ptm(end,2),ptm(end,3),0.02*ztm(1),0.02*ztm(2),0.02*ztm(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)

    % Contact frames
    ty1 = [0; cos(Eul1(end,3)); -sin(Eul1(end,3))];
    tz1 = [0; sin(Eul1(end,3))/cos(Eul1(end,2)); cos(Eul1(end,3))/cos(Eul1(end,2))];
    ty2 = [0; cos(Eul2(end,3)); -sin(Eul2(end,3))];
    tz2 = [0; sin(Eul2(end,3))/cos(Eul2(end,2)); cos(Eul2(end,3))/cos(Eul2(end,2))];
    
    quiver3(pct(end,1), pct(end,2), pct(end,3), 0.01*ty1(1), 0.01*ty1(2), 0.01*ty1(3), 0,'r','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pct(end,1), pct(end,2), pct(end,3), 0.01*tz1(1), 0.01*tz1(2), 0.01*tz1(3), 0,'r','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pcm(end,1), pcm(end,2), pcm(end,3), 0.01*ty2(1), 0.01*ty2(2), 0.01*ty2(3), 0,'r','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pcm(end,1), pcm(end,2), pcm(end,3), 0.01*tz2(1), 0.01*tz2(2), 0.01*tz2(3), 0,'r','LineWidth', 2, 'MaxHeadSize',1)
    
    quiver3(pct(end,1), pct(end,2), pct(end,3), 0.02*Nc1(end,1), 0.02*Nc1(end,2), 0.02*Nc1(end,3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pct(end,1), pct(end,2), pct(end,3), 0.02*Nx1(end,1), 0.02*Nx1(end,2), 0.02*Nx1(end,3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pct(end,1), pct(end,2), pct(end,3), -0.02*Nz1(end,1), -0.02*Nz1(end,2), -0.02*Nz1(end,3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    quiver3(pcm(end,1),pcm(end,2),pcm(end,3),0.02*Nc2(end,1),0.02*Nc2(end,2),0.02*Nc2(end,3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pcm(end,1),pcm(end,2),pcm(end,3),-0.02*Nx2(end,1),-0.02*Nx2(end,2),-0.02*Nx2(end,3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pcm(end,1),pcm(end,2),pcm(end,3),0.02*Nz2(end,1),0.02*Nz2(end,2),0.02*Nz2(end,3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     
%     % t1t2 & c1c2
%     xtt = [ ptt(end,1); ptm(end,1) ] ;
%     ytt = [ ptt(end,2); ptm(end,2) ] ;
%     ztt = [ ptt(end,3); ptm(end,3) ] ;
%     
%     xcc = [ pct(end,1); pcm(end,1) ] ;
%     ycc = [ pct(end,2); pcm(end,2) ] ;
%     zcc = [ pct(end,3); pcm(end,3) ] ;
%     
%     plot3(xtt,ytt,ztt,'k','LineWidth', 2)
%     plot3(xcc,ycc,zcc,'k','LineWidth', 2)
%     
%     plot3([po(1); po(1)+0.02*K(end,1)],[po(2); po(2)+ 0.02*K(end,2)],[po(3) ; po(3) + 0.02*K(end,3)],'r','LineWidth', 2);
%     plot3([po(1); po(1)-0.02*K(end,1)],[po(2); po(2)- 0.02*K(end,2)],[po(3) ; po(3) - 0.02*K(end,3)],'r','LineWidth', 2);

end

% Manipulability
box on
axis equal
hold off

end