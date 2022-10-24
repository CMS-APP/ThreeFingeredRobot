function createJoints(R, xs, ys, zs, jointPositions2, jointPositions3, jointPositions4, tipPosition, color, simConfig)
    hSurface = surf(R.*xs + jointPositions2(1), ... 
        R.*ys + jointPositions2(2), R.*zs + jointPositions2(3));
    set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
    hSurface = surf(R.*xs + jointPositions3(1), ... 
        R.*ys + jointPositions3(2), R.*zs + jointPositions3(3));
    set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
    hSurface = surf(R.*xs + jointPositions4(1), ... 
        R.*ys + jointPositions4(2),R.*zs + jointPositions4(3));
    set(hSurface,'FaceColor',color,'EdgeAlpha',0.1);
    hSurface = surf(R.*xs + tipPosition(1), .... 
        R.*ys + tipPosition(2), R.*zs + tipPosition(3));
    set(hSurface,'FaceColor',color,'EdgeAlpha',0.1,'FaceAlpha',simConfig.alpha);
end