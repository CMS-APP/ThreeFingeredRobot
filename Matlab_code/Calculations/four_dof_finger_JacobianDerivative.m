function dJ = four_dof_finger_JacobianDerivative(l, q)

%% Links length
l1 = l(1) ;
l2 = l(2) ;
l3 = l(3) ;

%% Joint variables
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
dq1 = q(5);
dq2 = q(6);
dq3 = q(7);
dq4 = q(8);
qdot = [ dq1 dq2 dq3 dq4 ]' ;

%% Trigonometric abbreviations
c1 = cos(q1);
c2 = cos(q2);
c23 = cos(q2+q3);
c234 = cos(q2+q3+q4) ;

s1 = sin(q1);
s2 = sin(q2);
s23 = sin(q2+q3);
s234 = sin(q2+q3+q4) ;

%% Auxiliary variables
h0 = c2*l1 + c23*l2 + c234*l3 ;
h1 = s2*l1 + s23*l2 + s234*l3 ;
h2 = c23*l2 + c234*l3 ;
h3 = s23*l2 + s234*l3 ;
h4 = c234*l3 ;
h5 = s234*l3 ;

%% Jacobian derivative
dJw1 = [ 0 0 0 ]' ;
dJw2 = [ -c1*dq1 -s1*dq1 0 ]' ;
dJw3 = [ -c1*dq1 -s1*dq1 0 ]' ;
dJw4 = [ -c1*dq1 -s1*dq1 0 ]' ;

dJw = [ dJw1 dJw2 dJw3 dJw4 ] ;

dJv11 = [ -c1*h0 s1*h1 s1*h3 s1*h5 ]*qdot ;
dJv21 = [ -s1*h0 -c1*h1 -c1*h3 -c1*h5 ]*qdot ;
dJv31 = 0 ;
dJv1 = [ dJv11 dJv21 dJv31 ]' ;

dJv12 = [ s1*h1 -c1*h0 -c1*h2 -c1*h4 ]*qdot ;
dJv22 = [ -c1*h1 -s1*h0 -s1*h2 -s1*h4 ]*qdot ;
dJv32 = [ 0 h1 h3 h5 ]*qdot ;
dJv2 = [ dJv12 dJv22 dJv32 ]' ;

dJv13 = [ s1*h3 -c1*h2 -c1*h2 -c1*h4 ]*qdot ;
dJv23 = [ -c1*h3 -s1*h2 -s1*h2 -s1*h4 ]*qdot ;
dJv33 = [ 0 h3 h3 h5 ]*qdot ;
dJv3 = [ dJv13 dJv23 dJv33 ]' ;

dJv14 = [ s1*h5 -c1*h4 -c1*h4 -c1*h4 ]*qdot ;
dJv24 = [ -c1*h5 -s1*h4 -s1*h4 -s1*h4 ]*qdot ;
dJv34 = [ 0 h5 h5 h5 ]*qdot ;
dJv4 = [ dJv14 dJv24 dJv34 ]' ;

dJv = [ dJv1 dJv2 dJv3 dJv4 ] ;

dJ = [dJv; dJw] ;
