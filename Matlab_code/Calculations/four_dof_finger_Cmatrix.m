function C = four_dof_finger_Cmatrix(l,q)

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
dq1 = q(5);
dq2 = q(6);
dq3 = q(7);
dq4 = q(8);

%% Trigonometric abbreviations
c2 = cos(q2);
c23 = cos(q2+q3);
c24 = cos(q2+q4);
c234 = cos(q2+q3+q4) ;

s2 = sin(q2);
s3 = sin(q3);
s4 = sin(q4);
s23 = sin(q2+q3);
s34 = sin(q3+q4);
s234 = sin(q2+q3+q4) ;

%% Auxiliary variables
a1 = - Ix1 + Iy1 + m1*r1^2 + (m2 + m3)*l1^2 ;
a2 = - Ix2 + Iy2 + m2*r2^2 + m3*l2^2 ;
a3 = - Ix3 + Iy3 + m3*r3^2 ;
a4 = l1*(m2*r2 + m3*l2) ;
b5 = m3*r3*(l1*sin(2*q2 + q3 + q4) + l2*sin(2*q2 + 2*q3 + q4)) ;
b8 = m3*r3*(l1*c2 + l2*c23) ;
b9 = m3*r3*(l1*s34 + l2*s4) ;

%% Centripental and coriolis
C11 = (-a1*s2*c2 -a2*s23*c23 -a3*s234*c234 - a4*(2*c2*s23 - s3))*dq2 ...
      - (a2*s23*c23 + a3*s234*c24 + a4*c2*s23 + 0.5*b5 + 0.5*m3*l1*r3*s34 + 0.5*m3*l2*r3*(2*c23*s234 - s4))*dq3 ...
      - (b8 + a3*c234)*s234*dq4 ;
C12 = (-a1*s2*c2 - a2*s23*c23 - a3*s234*c234 - a4*(2*c2*s23 - s3) - b5)*dq1 ;
C13 = -(a2*s23*c23 + a3*s234*c234 + a4*c2*s23 + 0.5*b5 + 0.5*m3*l1*r3*s34 + 0.5*m3*r3*l2*(2*c23*s234 - s4))*dq1 ;
C14 = -(b8 + a3*c234)*s234*dq1 ;

C21 = -C12 ;
C22 = (-a4*s3 - m3*l1*r3*s34)*dq3 - b9*dq4 ;
C23 = (-a4*s3 - m3*l1*r3*s34)*(dq2 + dq3)  - b9*dq4;
C24 = -b9*(dq2 + dq3 + dq4) ;

C31 = -C13 ;
C32 = (a3*s3 + m3*l1*r3*s34)*dq2 - m3*l2*r3*s4*dq4;
C33 = -m3*l2*r3*s4*dq4 ;
C34 = -m3*l2*r3*s4*(dq2 + dq3 + dq4) ;

C41 = -C14 ;
C42 = b9*dq2 + m3*l2*r3*s4*dq3 ;
C43 = m3*l2*r3*s4*(dq2+dq3) ;
C44 = 0 ;


C = [ C11 C12 C13 C14;
      C21 C22 C23 C24;
      C31 C32 C33 C34;
      C41 C42 C43 C44 ] ;
  