function [xnew, ynew, znew] = cylinderPosition(x, y, z, rotation)
    [xSize, ySize] = size(x);
    xnew = zeros(xSize, ySize);
    ynew = zeros(xSize, ySize);
    znew = zeros(xSize, ySize);

    for i = 1 : xSize
        for j = 1 : ySize
        xyz = [x(i, j) y(i, j) z(i, j)]';
        xyzNew = rotation * roty(pi / 2) * xyz;
        xnew(i, j)=xyzNew(1);
        ynew(i, j)=xyzNew(2);
        znew(i, j)=xyzNew(3);
        end
    end
end

