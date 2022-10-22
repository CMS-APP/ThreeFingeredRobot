function M = four_dof_finger_Mmatrix(l,q)

global L22 L32 L42

%% Links length

l1 = l(1) ;
r1 = L22.r(1);
l2 = l(2) ;
r2 = L32.r(1);
l3 = l(3) ;
r3 = L42.r(1);

%% Link masses
m1 = L22.m;
m2 = L32.m;
m3 = L42.m;

%% Inertia tensors
Ix1 = L22.I(1);
Iy1 = L22.I(2);
Iz1 = L22.I(3);

Ix2 = L32.I(1);
Iy2 = L32.I(2);
Iz2 = L32.I(3);

Ix3 = L42.I(1);
Iy3 = L42.I(2);
Iz3 = L42.I(3);

%% Joint variables
q2 = q(2);
q3 = q(3);
q4 = q(4);

%% Trigonometric abbreviations
c2 = cos(q2);
c3 = cos(q3);
c4 = cos(q4);
c23 = cos(q2+q3);
c34 = cos(q3+q4);
c234 = cos(q2+q3+q4) ;

%% Auxiliary variables
a1 = - Ix1 + Iy1 + m1*r1^2 + (m2 + m3)*l1^2 ;
a2 = - Ix2 + Iy2 + m2*r2^2 + m3*l2^2 ;
a3 = - Ix3 + Iy3 + m3*r3^2 ;
a4 = l1*(m2*r2 + m3*l2) ;
a10 = Ix1 + Ix2 + Ix3 - Iy1 - Iy2 - Iy3 + Iz1 + Iz2 + Iz3 ;
a11 = Ix2 + Ix3 - Iy2 - Iy3 + Iz2 + Iz3 ;
b7 = m3*r3*(l1*c34 + l2*c4) ;
b8 = m3*r3*(l1*c2 + l2*c23) ;

%% Inertia Matrix
m11 = a1*(c2^2) + a2*(c23)^2 + a3*(c234)^2 + 2*a4*c2*c23 + 2*b8*c234 + Ix1 + Ix2 + Ix3 ;
m12 = 0 ;
m13 = 0 ;
m14 = 0 ;
m22 = a1 + a2 + a3 + 2*a4*c3 + 2*b7 + a10 ;
m23 = a2 + a3 + a4*c3 + 2*b7 + a11 ;
m24 = m3*r3^2 + b7 + Iz3 ;
m33 = a2 + a3 + 2*m3*l2*r3*c4 + a11 ;
m34 = m3*(r3^2 + l2*r3*c4) + Iz3 ;
m44 = m3*r3^2 + Iz3 ;

M = [ m11 m12 m13 m14;
      m12 m22 m23 m24;
      m13 m23 m33 m34;
      m14 m24 m34 m44 ];
