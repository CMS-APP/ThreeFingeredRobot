function [Rf1, Rf2, pf2, Rf3, pf3, Rf4, pf4] = fingerPosition(finger, links, q0)
%FINGERPOSITION Summary of this function goes here
%   Detailed explanation goes here
% Create First Fingers
T1 = links(1).A(q0(1));
T2 = links(2).A(q0(2));
T3 = links(3).A(q0(3));
T4 = links(4).A(q0(4));

T2f = finger.base*T1*T2;
% Rotation and position of the first cylinder
Rf2 = T2f(1:3, 1:3);
pf2 = T2f(1:3, 4);

T3t = T2f*T3;
% Rotation and position of the second cylinder
Rf3 = T3t(1:3, 1:3);
pf3 = T3t(1:3, 4);

T14t = T3t*T4;
% Rotation and position of the third cylinder
Rf4 = T14t(1:3,1:3);
pf4 = T14t(1:3,4);

T_init = finger.fkine(q0');
Rf1 = T_init(1:3, 1:3);
pf1 = T_init(1:3, 4);
end

