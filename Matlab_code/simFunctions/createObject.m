function createObject(simConfig, objConfig, n, o, a, p0)
%DISPLAYOBJECT Summary of this function goes here
%   Detailed explanation goes here
% create object

Ro = [ n o a ] ;
% go = [ Ro po ; zeros(1,3) 1] ;

o0 = - objConfig.length / 2 ;
o1 = objConfig.length / 2 ;

if simConfig.obj == 1
    % Cube
    r000b = p0 + Ro*[ o0 o0 o0 ]' ;
    r100b = p0 + Ro*[ o1 o0 o0 ]' ;
    r110b = p0 + Ro*[ o1 o1 o0 ]' ;
    r010b = p0 + Ro*[ o0 o1 o0 ]' ;
    
    r001b = p0 + Ro*[ o0 o0 o1 ]' ;
    r101b = p0 + Ro*[ o1 o0 o1 ]' ;
    r111b = p0 + Ro*[ o1 o1 o1 ]' ;
    r011b = p0 + Ro*[ o0 o1 o1 ]' ;
    
elseif simConfig.obj == 2
    % Trapezium
    r000b = p0 + Ro*[ o0*(1+tand(-30)) o0 o0 ]' ;
    r100b = p0 + Ro*[ o1*(1+tand(-15)) o0 o0 ]' ;
    r110b = p0 + Ro*[ o1*(1+tand(-15)) o1 o0 ]' ;
    r010b = p0 + Ro*[ o0*(1+tand(-30)) o1 o0 ]' ;
    
    r001b = p0 + Ro*[ (1+tand(30))*o0 o0 o1 ]' ;
    r101b = p0 + Ro*[ (1+tand(15))*o1 o0 o1 ]' ;
    r111b = p0 + Ro*[ (1+tand(15))*o1 o1 o1 ]' ;
    r011b = p0 + Ro*[ (1+tand(30))*o0 o1 o1 ]' ;
    
elseif simConfig.obj == 3
    % Trapezium 2
    r000b = p0 + Ro * [ o0 * (1 + tand(-30)) o0 o0 ]' ;
    r100b = p0 + Ro * [ o1 * (1 + tand(-15 + 40)) o0 o0 ]' ;
    r110b = p0 + Ro * [ o1 * (1 + tand(-15 - 40)) o1 o0 ]' ;
    r010b = p0 + Ro * [ o0 * (1 + tand(-30)) o1 o0 ]' ;

    r001b = p0 + Ro * [ (1 + tand(30)) * o0 o0 o1 ]' ;
    r101b = p0 + Ro * [ (1 + tand(15 + 40)) * o1 o0 o1 ]' ;
    r111b = p0 + Ro * [ (1 + tand(15 - 40)) * o1 o1 o1 ]' ;
    r011b = p0 + Ro * [ (1 + tand(30)) * o0 o1 o1 ]' ;

elseif simConfig.obj == 4
    % Sphere
    [xs, ys, zs] = sphere(50);
    hSurface = surf(...
        objConfig.sphereRadius.*xs + ...
        p0(1),objConfig.sphereRadius.*ys + ... 
        p0(2),objConfig.sphereRadius.*zs + p0(3));
    
    set(hSurface,'FaceColor','c','EdgeAlpha',0.1,'FaceAlpha',simConfig.alpha1);
end

if (simConfig.obj == 1) || (simConfig.obj == 2) || (simConfig.obj == 3)
    r000 = (r000b(1:3,1))' ;
    r100 = (r100b(1:3,1))' ;
    r110 = (r110b(1:3,1))' ;
    r010 = (r010b(1:3,1))' ;
    r001 = (r001b(1:3,1))' ;
    r101 = (r101b(1:3,1))' ;
    r111 = (r111b(1:3,1))' ;
    r011 = (r011b(1:3,1))' ;
    
    vertex_matrix = [ r000 ;
        r100 ;
        r110 ;
        r010 ;
        r001 ;
        r101 ;
        r111 ;
        r011 ] ;
    
    faces_matrix= [ 1 2 6 5 ;
        2 3 7 6 ;
        3 4 8 7 ;
        4 1 5 8 ;
        1 2 3 4 ;
        5 6 7 8 ] ;
    
    patch('Vertices',vertex_matrix,'Faces',faces_matrix,...
        'FaceVertexCData',hsv(8),'FaceColor','interp','FaceAlpha',simConfig.alpha1)
end

view([70 30])
ylabel('$y$ $[m]$','Interpreter','latex','FontSize',18);
xlabel('$x$ $[m]$','Interpreter','latex','FontSize',18);
zlabel('$z$ $[m]$','Interpreter','latex','FontSize',18);
hold on
end

