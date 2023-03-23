function initialConfiguration(simConfig, objConfig, linkConfig, initialValues)

global r ptf10 ptf20 ptf30 l1 l2 l3 pc10 pc20 pc30
global f1 f2 f3 nx10 nx20 nx30 ny10 ny20 ny30 nz10 nz20 nz30

f = figure('Name','Initial And Final Configuration','NumberTitle','off');
set(gcf,'position',[0,0,1500,500])

subplot(1,2,1)

% Skin color
color = [185 124 109]./255;
colortip = [206 150 124]./255;

% Object orientation
n  = [ 0 ; 1 ; 0];
o  = [ -1 ; 0 ; 0];
a  = [ 0 ; 0 ; 1];

% Create cube, trapezium or sphere
createObject(simConfig, objConfig, n, o, a, initialValues.p0)

view([70 30])
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',18);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',18);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',18);
hold on

%% Finger positions
[Rtf1, Rf12, pf12, Rf13, pf13, Rf14, pf14] = fingerPosition(f1, linkConfig.links1, initialValues.qf10);
[Rtf2, Rf22, pf22, Rf23, pf23, Rf24, pf24] = fingerPosition(f2, linkConfig.links2, initialValues.qf20);
[Rtf3, Rf32, pf32, Rf33, pf33, Rf34, pf34] = fingerPosition(f3, linkConfig.links3, initialValues.qf30);

%% Display finger joints 

% Frist Finger Joints 
R = 0.015/2;
tipf1 = ptf10 + Rtf1*[r - R ; 0 ; 0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs + pf12(1), R.*ys + pf12(2), R.*zs + pf12(3));
set(hSurface,'FaceColor',color,'EdgeAlpha', 1);
createJoints(R, xs, ys, zs, pf12, pf13, pf14, tipf1, color, simConfig)

% Second Finger Joints
R = 0.015/2;
tipf2 = ptf20 + Rtf2 * [r - R ; 0 ; 0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs + pf22(1), R.*ys + pf22(2), R.*zs + pf22(3));
set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
createJoints(R, xs, ys, zs, pf22, pf23, pf24, tipf2, color, simConfig)

% Third Finger Joints
R = 0.015/2;
tipf3 = ptf30 + Rtf3 * [r - R ; 0 ; 0];
[xs,ys,zs] = sphere(50);
hSurface = surf(R.*xs + pf32(1), R.*ys + pf32(2), R.*zs);
set(hSurface,'FaceColor', color, 'EdgeAlpha', 0.1);
createJoints(R, xs, ys, zs, pf32, pf33, pf34, tipf3, color, simConfig)

%% Display finger links 

% First Finger Links
[xf12, yf12, zf12] = cylinder(R);
zf12 = l1(1).*zf12;
[xnewt2, ynewt2, znewt2] = cylinderPosition(xf12, yf12, zf12, Rf12);
hSurface = surf(xnewt2 + pf12(1), ynewt2 + pf12(2), znewt2 + pf12(3));
set(hSurface,'FaceColor', color, 'EdgeAlpha', 1);

[xf13, yf13, zf13] = cylinder(R);
zf13 = l1(2).*zf13;
[xnewt3, ynewt3, znewt3] = cylinderPosition(xf13, yf13, zf13, Rf13);
hSurface = surf(xnewt3 + pf13(1), ynewt3 + pf13(2), znewt3 + pf13(3));
set(hSurface,'FaceColor',color,'EdgeAlpha', 1);

[xf14, yf14, zf14] = cylinder(R);
zf14 = (l1(3) + r / 2).*zf14;
[xnewt4, ynewt4, znewt4] = cylinderPosition(xf14, yf14, zf14, Rf14);
hSurface = surf(xnewt4 + pf14(1), ynewt4 + pf14(2), znewt4 + pf14(3));
set(hSurface, 'FaceColor', color, 'EdgeAlpha', 0.1);

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
hSurface = surf(xnewm2 + pf32(1), ynewm2 + pf32(2), znewm2);
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
hSurface = surf(r.*xnewf1 + ptf10(1), r.*ynewf1 + ptf10(2), r.*znewf1 + ptf10(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0 );

% Second Finger Fingertip
[xnewf2, ynewf2, znewf2] = fingertipPosition(Rtf2, -pi/2);
hSurface = surf(r.*xnewf2 + ptf20(1), r.*ynewf2 + ptf20(2), r.*znewf2 + ptf20(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0 );
% 
% % Third Finger Fingertip
[xnewf3, ynewf3, znewf3] = fingertipPosition(Rtf3, -pi/2);
hSurface = surf(r.*xnewf3 + ptf30(1), r.*ynewf3 + ptf30(2), r.*znewf3 + ptf30(3));  %# Plot the surface
set(hSurface,'FaceColor',colortip,'EdgeAlpha',0 );

if simConfig.test == 1
    % Contact Frames
    
    quiver3(pc10(1),pc10(2),pc10(3),0.02*nx10(1),0.02*nx10(2),0.02*nx10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc10(1),pc10(2),pc10(3),0.02*ny10(1),0.02*ny10(2),0.02*ny10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc10(1),pc10(2),pc10(3),0.02*nz10(1),0.02*nz10(2),0.02*nz10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    quiver3(pc20(1),pc20(2),pc20(3),0.02*nx20(1),0.02*nx20(2),0.02*nx20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc20(1),pc20(2),pc20(3),0.02*ny20(1),0.02*ny20(2),0.02*ny20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc20(1),pc20(2),pc20(3),0.02*nz20(1),0.02*nz20(2),0.02*nz20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    
    quiver3(pc30(1),pc30(2),pc30(3),0.02*nx30(1),0.02*nx30(2),0.02*nx30(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc30(1),pc30(2),pc30(3),0.02*ny30(1),0.02*ny30(2),0.02*ny30(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
    quiver3(pc30(1),pc30(2),pc30(3),0.02*nz30(1),0.02*nz30(2),0.02*nz30(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)

%     plot3(0, 0, 0, 'bo','LineWidth', 2)
% 
%     quiver3(pf12(1),pf12(2),pf12(3), 0.02, 0, 0 , 0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pf12(1),pf12(2),pf12(3), 0.02 * sind(30), 0.02 * cosd(30), 0, 'b','LineWidth', 2, 'MaxHeadSize',1)
%     
%     quiver3(pf22(1),pf22(2),pf22(3), 0.02, 0, 0 , 0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pf22(1),pf22(2),pf22(3), 0.02 * sind(30), -0.02 * cosd(30), 0,'b','LineWidth', 2, 'MaxHeadSize',1)
%     
%     quiver3(pf32(1),pf32(2),pf32(3), 0.02, 0, 0 , 0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pf32(1),pf32(2),pf32(3), -0.02, 0, 0 , 0,'b','LineWidth', 2, 'MaxHeadSize',1)
%     
%     plot3DAngleSemiCircle(pf12, 0.01, 0, 60)
%     plot3DAngleSemiCircle(pf22, 0.01, 0, -60)
%     plot3DAngleSemiCircle(pf32, 0.01, 0, 180)
%     
%     quiver3(pc10(1),pc10(2),pc10(3),0.02*ny10(1),0.02*ny10(2),0.02*ny10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pc10(1),pc10(2),pc10(3),0.02*nz10(1),0.02*nz10(2),0.02*nz10(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     
%     quiver3(pc20(1),pc20(2),pc20(3),0.02*nx20(1),0.02*nx20(2),0.02*nx20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pc20(1),pc20(2),pc20(3),0.02*ny20(1),0.02*ny20(2),0.02*ny20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pc20(1),pc20(2),pc20(3),0.02*nz20(1),0.02*nz20(2),0.02*nz20(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     
%     quiver3(pc30(1),pc30(2),pc30(3),0.02*nx30(1),0.02*nx30(2),0.02*nx30(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pc30(1),pc30(2),pc30(3),0.02*ny30(1),0.02*ny30(2),0.02*ny30(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)
%     quiver3(pc30(1),pc30(2),pc30(3),0.02*nz30(1),0.02*nz30(2),0.02*nz30(3),0,'k','LineWidth', 2, 'MaxHeadSize',1)

    
% %     t1t2 & c1c2
%     xtt = [ ptf10(1); ptf20(1) ] ;
%     ytt = [ ptf10(2); ptf20(2) ] ;
%     ztt = [ ptf10(3); ptf20(3) ] ;
%     xcc = [ pc10(1); pc20(1) ] ;
%     ycc = [ pc10(2); pc20(2) ] ;
%     zcc = [ pc10(3); pc20(3) ] ;
%     
%     plot3(xtt,ytt,ztt,'b','LineWidth', 2)
%     plot3(xcc,ycc,zcc,'g','LineWidth', 2)
%     
%     pt1 = Rtf1;
%     pt2 = Rtf2;
%     pt3 = Rtf3;
%     
%     plotLineBetweenPoints(tipf1, tipf2)
%     plotLineBetweenPoints(tipf2, tipf3)
%     plotLineBetweenPoints(tipf3, tipf1)
%     
%     middlePos = (tipf1 + tipf2 + tipf3) / 3;
%     plot3(middlePos(1), middlePos(2), middlePos(3), 'bo','LineWidth', 2);
%     
%     plotLineBetweenPoints(tipf1, middlePos)
%     plotLineBetweenPoints(tipf2, middlePos)
%     plotLineBetweenPoints(tipf3, middlePos)
%     
%     plot3(tipf1(1), tipf1(2), tipf1(3), 'bo','LineWidth', 2);
%     plot3(tipf2(1), tipf2(2), tipf2(3), 'bo','LineWidth', 2);
%     plot3(tipf3(1), tipf3(2), tipf3(3), 'bo','LineWidth', 2);
    
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

function plot3DAngleSemiCircle(center, radius, angleStart, angleEnd)
    xCenter = center(1);
    yCenter = center(2); 
    % Define the angle theta as going from 30 to 150 degrees in 100 steps.
    theta = linspace(angleStart, angleEnd, 100);
    % Define x and y using "Degrees" version of sin and cos.
    x = radius * cosd(theta) + xCenter; 
    y = radius * sind(theta) + yCenter; 
    z = zeros(size(x));
   
    % Now plot the points.
    plot3(x, y, z, 'r-', 'LineWidth', 2); 
end