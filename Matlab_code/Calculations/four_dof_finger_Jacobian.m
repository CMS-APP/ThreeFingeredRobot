function J = four_dof_finger_Jacobian(l,q)



%% Links length
l1 = l(1) ;
l2 = l(2) ;
l3 = l(3) ;

%% Joint variables
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

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

%% Jacobian
Jw1 = [ 0 0 1 ]' ;
Jw2 = [ -s1 c1 0 ]' ;
Jw3 = [ -s1 c1 0 ]' ;
Jw4 = [ -s1 c1 0 ]' ;
Jw = [ Jw1 Jw2 Jw3 Jw4 ] ;

Jv1 = [ -s1*h0  c1*h0   0  ]' ;
Jv2 = [ -c1*h1 -s1*h1 -h0 ]' ;
Jv3 = [ -c1*h3 -s1*h3 -h2 ]' ;
Jv4 = [ -c1*h5 -s1*h5 -h4 ]' ;
Jv = [ Jv1 Jv2 Jv3 Jv4 ] ;

J = [ Jv; Jw ] ;
