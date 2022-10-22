function initialConfiguration(simConfig, objConfig, linkConfig, initialValues)

global r ptt0 ptm0 lt lm pc10 pc20
global f1 f2 nx10 ny10 nz10 nx20 ny20 nz20

figure('Name','Initial Configuration','NumberTitle','off')

% Skin color
color = [185 124 109]./255;
colortip = [206 150 124]./255;

% Object orientation
n  = [ 0 ; 1 ; 0];
o  = [ -1 ; 0 ; 0];
a  = [ 0 ; 0 ; 1];

% Create cube, trapezium or sphere
createObject(simConfig, objConfig, n, o, a, initialValues.p0)

% Create First Fingers
T11 = linkConfig.links1(1).A(initialValues.qt0(1));
T21 = linkConfig.links1(2).A(initialValues.qt0(2));
T31 = linkConfig.links1(3).A(initialValues.qt0(3));
T41 = linkConfig.links1(4).A(initialValues.qt0(4));

T12f = T11*T21;
% Rotation and position of the first finger first cylinder
Rf2 = T12f(1:3, 1:3);
pf2 = T12f(1:3, 4);

T13t = T12f*T31;
% Rotation and position of the first finger second cylinder
Rf3 = T13t(1:3, 1:3);
pf3 = T13t(1:3, 4);

T14t = T13t*T41;
% Rotation and position of the first finger third cylinder
Rf4 = T14t(1:3,1:3);
pf4 = T14t(1:3,4);

T_init4t = f1.fkine(initialValues.qt0');
Rtt = T_init4t(1:3,1:3);

% Create Second Fingers
T12 = linkConfig.links2(1).A(initialValues.qm0(1));
T22 = linkConfig.links2(2).A(initialValues.qm0(2));
T32 = linkConfig.links2(3).A(initialValues.qm0(3));
T42 = linkConfig.links2(4).A(initialValues.qm0(4));

T12s = f2.base*T12*T22;
% Rotation and position of the first finger first cylinder
Rs2 = T12s(1:3,1:3);
ps2 = T12s(1:3,4); %+ pbase;

T13s = T12s*T32;
% Rotation and position of the first finger second cylinder
Rs3 = T13s(1:3,1:3);
ps3 = T13s(1:3,4); %+ pbase;

T14s = T13s*T42;
% Rotation and position of the first finger third cylinder
Rs4 = T14s(1:3,1:3);
ps4 = T14s(1:3,4); %+ pbase;

T_init4s = f2.fkine(initialValues.qm0');
Rtm = T_init4s(1:3,1:3);

% Frist Finger Joints 
R = 0.015/2;
tipt = ptt0 + Rtt*[r - R ; 0 ; 0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs, R.*ys, R.*zs);
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
createJoints(R, xs, ys, zs, pf2, pf3, pf4, tipt, color, simConfig)

% Second Finger Joints
R = 0.015/2;
tipm = ptm0 + Rtm*[r - R ; 0 ; 0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs, R.*ys + pf2(2), R.*zs);
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
createJoints(R, xs, ys, zs, ps2, ps3, ps4, tipm, color, simConfig)

% First Finger Links
[xt2, yt2, zt2] = cylinder(R);
zt2 = lt(1).*zt2;
[xnewt2, ynewt2, znewt2] = cylinderPosition(xt2, yt2, zt2, Rf2);
hSurface = surf(xnewt2, ynewt2, znewt2);
set(hSurface,'FaceColor', color, 'EdgeAlpha', 0.1);

[xt3, yt3, zt3] = cylinder(R);
zt3 = lt(2).*zt3;
[xnewt3, ynewt3, znewt3] = cylinderPosition(xt3, yt3, zt3, Rf3);
hSurface = surf(xnewt3 + pf3(1), ynewt3 + pf3(2), znewt3 + pf3(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xt4, yt4, zt4] = cylinder(R);
zt4 = (lt(3) + r / 2).*zt4;
[xnewt4, ynewt4, znewt4] = cylinderPosition(xt4, yt4, zt4, Rf4);
hSurface = surf(xnewt4 + pf4(1), ynewt4 + pf4(2), znewt4 + pf4(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1, 'FaceAlpha', simConfig.alpha);

% Second Finger Links
[xm2, ym2, zm2] = cylinder(R);
zm2 = lm(1).*zm2;
[xnewm2, ynewm2, znewm2] = cylinderPosition(xm2, ym2, zm2, Rs2);
hSurface = surf(xnewm2, ynewm2 + ps2(2),znewm2);
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xm3, ym3, zm3] = cylinder(R);
zm3 = lm(2).*zm3;
[xnewm3, ynewm3, znewm3] = cylinderPosition(xm3, ym3, zm3, Rs3);
hSurface = surf(xnewm3 + ps3(1), ynewm3 + ps3(2), znewm3 + ps3(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1);

[xm4, ym4, zm4] = cylinder(R);
zm4 = (lm(3) + r / 2).*zm4;
[xnewm4, ynewm4, znewm4] = cylinderPosition(xm4, ym4, zm4, Rs4);
hSurface = surf(xnewm4 + ps4(1), ynewm4 + ps4(2), znewm4 + ps4(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha',0.1, 'FaceAlpha', simConfig.alpha);

% First Finger Fingertip
[xnewt, ynewt, znewt] = fingertipPosition(Rtt, -pi/2);
hSurface = surf(r.*xnewt + ptt0(1), r.*ynewt + ptt0(2), r.*znewt + ptt0(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

% Second Finger Fingertip
[xnewm, ynewm, znewm] = fingertipPosition(Rtm, pi/2);
hSurface = surf(r.*xnewm + ptm0(1), r.*ynewm + ptm0(2), r.*znewm + ptm0(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

if simConfig.test == 1
    % Contact Frames
    
    quiver3(pc10(1),pc10(2),pc10(3),0.02*nx10(1),0.02*nx10(2),0.02*nx10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc10(1),pc10(2),pc10(3),0.02*ny10(1),0.02*ny10(2),0.02*ny10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc10(1),pc10(2),pc10(3),0.02*nz10(1),0.02*nz10(2),0.02*nz10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc20(1),pc20(2),pc20(3),0.02*nx20(1),0.02*nx20(2),0.02*nx20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc20(1),pc20(2),pc20(3),0.02*ny20(1),0.02*ny20(2),0.02*ny20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc20(1),pc20(2),pc20(3),0.02*nz20(1),0.02*nz20(2),0.02*nz20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    % t1t2 & c1c2
    xtt = [ ptt0(1); ptm0(1) ] ;
    ytt = [ ptt0(2); ptm0(2) ] ;
    ztt = [ ptt0(3); ptm0(3) ] ;
    xcc = [ pc10(1); pc20(1) ] ;
    ycc = [ pc10(2); pc20(2) ] ;
    zcc = [ pc10(3); pc20(3) ] ;
    
    plot3(xtt,ytt,ztt,'b','LineWidth', 2)
    plot3(xcc,ycc,zcc,'g','LineWidth', 2)
end
box on
axis equal
hold off

end