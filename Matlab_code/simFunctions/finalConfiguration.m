function finalConfiguration(simConfig, objConfig, linkConfig)

global x_out Pt1 Pt2 Pt3 r l1 l2 l3 Pc1 Pc2 Pc3
global f1 f2 f3 Nx1 Ny1 Nz1 Nx2 Ny2 Nz2 Nx3 Ny3 Nz3 K Eul1 Eul2 Poc1o Poc2o Poc3o

subplot(1,2,2)

% skin color
color = [185 124 109]./255;
colortip = [206 150 124]./255;

qf1 = x_out(:, 1:4);
qf2 = x_out(:, 5:8);
qf3 = x_out(:, 9:12);

% Object position & orientation
po = x_out(end,13:15)';
n = x_out(end,16:18)';
o = x_out(end,19:21)';
a = x_out(end,22:24)';

createObject(simConfig, objConfig, n, o, a, po)

%% Finger positions
[Rtf1, Rf12, pf12, Rf13, pf13, Rf14, pf14] = fingerPosition(f1, linkConfig.links1, qf1);
[Rtf2, Rf22, pf22, Rf23, pf23, Rf24, pf24] = fingerPosition(f2, linkConfig.links2, qf2);
[Rtf3, Rf32, pf32, Rf33, pf33, Rf34, pf34] = fingerPosition(f3, linkConfig.links3, qf3);

%% Display finger joints 

% Frist Finger Joints 
R = 0.015/2;
tip1 = Pt1(end,:)' + Rf14 * [r - R ; 0 ;0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs + pf12(1), R.*ys + pf12(2), R.*zs + pf12(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
createJoints(R, xs, ys, zs, pf12, pf13, pf14, tip1, color, simConfig)

% Second Finger Joints
R = 0.015/2;
tip2 = Pt2(end,:)' + Rf24 * [r - R ; 0 ;0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs + pf22(1), R.*ys + pf22(2), R.*zs + pf22(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
createJoints(R, xs, ys, zs, pf22, pf23, pf24, tip2, color, simConfig)

% Third Finger Joints
R = 0.015/2;
tip3 = Pt3(end,:)' + Rf34 * [r - R ; 0 ;0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs + pf32(1), R.*ys + pf32(2), R.*zs + pf32(3));
set(hSurface,'FaceColor', color, 'EdgeAlpha', 0.1);
createJoints(R, xs, ys, zs, pf32, pf33, pf34, tip3, color, simConfig)

%% Display finger links 

% First Finger Links
[xf12, yf12, zf12] = cylinder(R);
zf12 = l1(1).*zf12;
[xnewt2, ynewt2, znewt2] = cylinderPosition(xf12, yf12, zf12, Rf12);
hSurface = surf(xnewt2 + pf12(1), ynewt2 + pf12(2), znewt2 + pf12(3));
set(hSurface,'FaceColor', color, 'EdgeAlpha', 0.1);

[xf13, yf13, zf13] = cylinder(R);
zf13 = l1(2).*zf13;
[xnewt3, ynewt3, znewt3] = cylinderPosition(xf13, yf13, zf13, Rf13);
hSurface = surf(xnewt3 + pf13(1), ynewt3 + pf13(2), znewt3 + pf13(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xf14, yf14, zf14] = cylinder(R);
zf14 = (l1(3) + r / 2).*zf14;
[xnewt4, ynewt4, znewt4] = cylinderPosition(xf14, yf14, zf14, Rf14);
hSurface = surf(xnewt4 + pf14(1), ynewt4 + pf14(2), znewt4 + pf14(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1, 'FaceAlpha', simConfig.alpha);

% Second Finger Links
[xf22, yf22, zf22] = cylinder(R);
zf22 = l2(1).*zf22;
[xnewm2, ynewm2, znewm2] = cylinderPosition(xf22, yf22, zf22, Rf22);
hSurface = surf(xnewm2 + pf22(1), ynewm2 + pf22(2), znewm2 + pf22(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xf23, yf23, zf23] = cylinder(R);
zf23 = l2(2).*zf23;
[xnewm3, ynewm3, znewm3] = cylinderPosition(xf23, yf23, zf23, Rf23);
hSurface = surf(xnewm3 + pf23(1), ynewm3 + pf23(2), znewm3 + pf23(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1);

[xf24, yf24, zf24] = cylinder(R);
zf24 = (l2(3) + r / 2).*zf24;
[xnewm4, ynewm4, znewm4] = cylinderPosition(xf24, yf24, zf24, Rf24);
hSurface = surf(xnewm4 + pf24(1), ynewm4 + pf24(2), znewm4 + pf24(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha',0.1, 'FaceAlpha', simConfig.alpha);

% Third Finger Links
[xf32, yf32, zf32] = cylinder(R);
zf32 = l3(1).*zf32;
[xnewm2, ynewm2, znewm2] = cylinderPosition(xf32, yf32, zf32, Rf32);
hSurface = surf(xnewm2 + pf32(1), ynewm2 + pf32(2), znewm2+  + pf32(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);

[xf33, yf33, zf33] = cylinder(R);
zf33 = l3(2).*zf33;
[xnewm3, ynewm3, znewm3] = cylinderPosition(xf33, yf33, zf33, Rf33);
hSurface = surf(xnewm3 + pf33(1), ynewm3 + pf33(2), znewm3 + pf33(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1);

[xf34, yf34, zf34] = cylinder(R);
zf34 = (l3(3) + r / 2).*zf34;
[xnewm4, ynewm4, znewm4] = cylinderPosition(xf34, yf34, zf34, Rf34);
hSurface = surf(xnewm4 + pf34(1), ynewm4 + pf34(2), znewm4 + pf34(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha',0.1, 'FaceAlpha', simConfig.alpha);

%% Display finger fingertips 

% First Finger Fingertip
[xnewf1, ynewf1, znewf1] = fingertipPosition(Rtf1, -pi/2);
hSurface = surf(r.*xnewf1 + Pt1(1), r.*ynewf1 + Pt1(2), r.*znewf1 + Pt1(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

% Second Finger Fingertip
[xnewf2, ynewf2, znewf2] = fingertipPosition(Rtf2, pi/2);
hSurface = surf(r.*xnewf2 + Pt2(1), r.*ynewf2 + Pt2(2), r.*znewf2 + Pt2(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

% Third Finger Fingertip
[xnewf3, ynewf3, znewf3] = fingertipPosition(Rtf3, pi/2);
hSurface = surf(r.*xnewf3 + Pt3(1), r.*ynewf3 + Pt3(2), r.*znewf3 + Pt3(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0,'FaceAlpha', simConfig.alpha);

if simConfig.test == 1
    % Contact Frames
%     
    quiver3(Pc1(1),Pc1(2),Pc1(3),0.02*Nx1(1),0.02*Nx1(2),0.02*Nx1(3),0,'b','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(Pc1(1),Pc1(2),Pc1(3),0.02*Ny1(1),0.02*Ny1(2),0.02*Ny1(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(Pc1(1),Pc1(2),Pc1(3),0.02*Nz1(1),0.02*Nz1(2),0.02*Nz1(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    quiver3(Pc2(1),Pc2(2),Pc2(3),0.02*Nx2(1),0.02*Nx2(2),0.02*Nx2(3),0,'b','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(Pc2(1),Pc2(2),Pc2(3),0.02*Ny2(1),0.02*Ny2(2),0.02*Ny2(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(Pc2(1),Pc2(2),Pc2(3),0.02*Nz2(1),0.02*Nz2(2),0.02*Nz2(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    quiver3(Pc3(1),Pc3(2),Pc3(3),0.02*Nx3(1),0.02*Nx3(2),0.02*Nx3(3),0,'b','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(Pc3(1),Pc3(2),Pc3(3),0.02*Ny3(1),0.02*Ny3(2),0.02*Ny3(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(Pc3(1),Pc3(2),Pc3(3),0.02*Nz3(1),0.02*Nz3(2),0.02*Nz3(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    % t1t2 & c1c2
%     xtt = [ ptf10(1); ptf20(1) ] ;
%     ytt = [ ptf10(2); ptf20(2) ] ;
%     ztt = [ ptf10(3); ptf20(3) ] ;
%     xcc = [ Pc1(1); Pc2(1) ] ;
%     ycc = [ Pc1(2); Pc2(2) ] ;
%     zcc = [ Pc1(3); Pc2(3) ] ;
    
%     plot3(xtt,ytt,ztt,'b','LineWidth', 2)
%     plot3(xcc,ycc,zcc,'g','LineWidth', 2)
%     
    pt1 = tip1;
    pt2 = tip2;
    pt3 = tip3;
    
    plotLineBetweenPoints(pt1, pt2)
    plotLineBetweenPoints(pt2, pt3)
    plotLineBetweenPoints(pt3, pt1)
    
    middlePos = (pt1 + pt2 + pt3) / 3;
    plot3(middlePos(1), middlePos(2), middlePos(3), 'bo','LineWidth', 2);
    
    plotLineBetweenPoints(pt1, middlePos)
    plotLineBetweenPoints(pt2, middlePos)
    plotLineBetweenPoints(pt3, middlePos)
    
    plot3(pt1(1), pt1(2), pt1(3), 'bo','LineWidth', 2);
    plot3(pt2(1), pt2(2), pt2(3), 'ro','LineWidth', 2);
    plot3(pt3(1), pt3(2), pt3(3), 'go','LineWidth', 2);

end
box on
axis equal
hold off

end

function plotLineBetweenPoints(point1, point2)
    v1=[point1(1), point1(2), point1(3)];
    v2=[point2(1), point2(2), point2(3)];
    v=[v2; v1];
    plot3(v(:,1), v(:,2), v(:,3), 'r', 'LineWidth', 2)
end