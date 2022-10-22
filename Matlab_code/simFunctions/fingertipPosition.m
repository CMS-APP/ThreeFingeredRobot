function [xnew, ynew, znew] = fingertipPosition(Rt, rotation)
    [xi,yi,zi] = sphere(50);     %# Makes a 51-by-51 point sphere
    xi = xi(1:25,:);              %# Keep half bottom sphere
    yi = yi(1:25,:);
    zi = zi(1:25,:);
    
    [xsize, ysize] = size(xi);
    xnew = zeros(xsize, ysize);
    ynew = zeros(xsize, ysize);
    znew = zeros(xsize, ysize);

    for i = 1:xsize
        for j = 1:ysize
            xyz = [xi(i,j) yi(i,j) zi(i,j)]';
            xyzNew = Rt * rotx(rotation) * xyz;         %Rotate sphere
            xnew(i,j) = xyzNew(1);
            ynew(i,j) = xyzNew(2);
            znew(i,j) = xyzNew(3);
        end
    end
end

