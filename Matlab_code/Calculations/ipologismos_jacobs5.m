function [J,Jv,Jw,Jd] = ipologismos_jacobs5(x)
% function [J,Jv,Jw] = ipologismos_jacobs(x)

global lt

lm1 = lt(1);
lm2 = lt(2);
lm3 = lt(3);

h10 = lm1*cos(x(3))                   + lm2*cos(x(3)+x(4))                 + lm3*cos(x(3)+x(4)+x(5));
h12 = lm2*cos(x(3)+x(4))              + lm3*cos(x(3)+x(4)+x(5));
h14 = lm3*cos(x(3)+x(4)+x(5));
h11 = lm1*sin(x(3))                   + lm2*sin(x(3)+x(4))                 + lm3*sin(x(3)+x(4)+x(5));
h13 = lm2*sin(x(3)+x(4))              + lm3*sin(x(3)+x(4)+x(5));   
h15 = lm3*sin(x(3)+x(4)+x(5));

hd10 = -lm1*sin(x(3))*x(8)                                                 - lm2*sin(x(3)+x(4))*(x(8)+x(9))              - lm3*sin(x(3)+x(4)+x(5))*(x(8)+x(9)+x(10));
hd12 = -lm2*sin(x(3)+x(4))*(x(8)+x(9))                                     - lm3*sin(x(3)+x(4)+x(5))*(x(8)+x(9)+x(10)); 
hd14 = -lm3*sin(x(3)+x(4)+x(5))*(x(8)+x(9)+x(10));
hd11 =  lm1*cos(x(3))*x(8)                                                 + lm2*cos(x(3)+x(4))*(x(8)+x(9))              + lm3*cos(x(3)+x(4)+x(5))*(x(8)+x(9)+x(10));
hd13 =  lm2*cos(x(3)+x(4))*(x(8)+x(9))                                     + lm3*cos(x(3)+x(4)+x(5))*(x(8)+x(9)+x(10)); 
hd15 =  lm3*cos(x(3)+x(4)+x(5))*(x(8)+x(9)+x(10));

j11 = -sin(x(1))*cos(x(2))*h10        +  cos(x(1))*h11;
j12 = -cos(x(1))*sin(x(2))*h10;
j13 =  sin(x(1))*h10                  -  cos(x(1))*cos(x(2))*h11;
j14 =  sin(x(1))*h12                  -  cos(x(1))*cos(x(2))*h13;
j15 =  sin(x(1))*h14                  -  cos(x(1))*cos(x(2))*h15;
j21 =  cos(x(1))*cos(x(2))*h10        +  sin(x(1))*h11;
j22 = -sin(x(1))*sin(x(2))*h10;
j23 = -cos(x(1))*h10                  -  sin(x(1))*cos(x(2))*h11;
j24 = -cos(x(1))*h12                  -  sin(x(1))*cos(x(2))*h13;
j25 = -cos(x(1))*h14                  -  sin(x(1))*cos(x(2))*h15;

jd11 = -cos(x(1))*x(6)*cos(x(2))*h10  +  sin(x(1))*sin(x(2))*x(7)*h10  -   sin(x(1))*cos(x(2))*hd10      -  sin(x(1))*x(6)*h11            +  cos(x(1))*hd11;
jd12 = sin(x(1))*x(6)*sin(x(2))*h10   -  cos(x(1))*cos(x(2))*x(7)*h10  -   cos(x(1))*sin(x(2))*hd10;
jd13 = cos(x(1))*x(6)*h10             +  sin(x(1))*hd10                +   sin(x(1))*x(6)*cos(x(2))*h11  +  cos(x(1))*sin(x(2))*x(7)*h11  -  cos(x(1))*cos(x(2))*hd11;
jd14 = cos(x(1))*x(6)*h12             +  sin(x(1))*hd12                +   sin(x(1))*x(6)*cos(x(2))*h13  +  cos(x(1))*sin(x(2))*x(7)*h13  -  cos(x(1))*cos(x(2))*hd13;
jd15 = cos(x(1))*x(6)*h14             +  sin(x(1))*hd14                +   sin(x(1))*x(6)*cos(x(2))*h15  +  cos(x(1))*sin(x(2))*x(7)*h15  -  cos(x(1))*cos(x(2))*hd15;
jd21 = -sin(x(1))*x(6)*cos(x(2))*h10  -  cos(x(1))*sin(x(2))*x(7)*h10  +   cos(x(1))*cos(x(2))*hd10      +  cos(x(1))*x(6)*h11            +  sin(x(1))*hd11; 
jd22 = -cos(x(1))*x(6)*sin(x(2))*h10  -  sin(x(1))*cos(x(2))*x(7)*h10  -   sin(x(1))*sin(x(2))*hd10;
jd23 = sin(x(1))*x(6)*h10             -  cos(x(1))*hd10                -   cos(x(1))*x(6)*cos(x(2))*h11  +  sin(x(1))*sin(x(2))*x(7)*h11  -  sin(x(1))*cos(x(2))*hd11;
jd24 = sin(x(1))*x(6)*h12             -  cos(x(1))*hd12                -   cos(x(1))*x(6)*cos(x(2))*h13  +  sin(x(1))*sin(x(2))*x(7)*h13  -  sin(x(1))*cos(x(2))*hd13;
jd25 = sin(x(1))*x(6)*h14             -  cos(x(1))*hd14                -   cos(x(1))*x(6)*cos(x(2))*h15  +  sin(x(1))*sin(x(2))*x(7)*h15  -  sin(x(1))*cos(x(2))*hd15;
jd32 = sin(x(2))*x(7)*h10             -  cos(x(2))*hd10;
jd33 = cos(x(2))*x(7)*h11             +  sin(x(2))*hd11;
jd34 = cos(x(2))*x(7)*h13             +  sin(x(2))*hd13;
jd35 = cos(x(2))*x(7)*h15             +  sin(x(2))*hd15;
jd43 = sin(x(1))*x(6)*sin(x(2))       - cos(x(1))*cos(x(2))*x(7);
jd44 = jd43;                          jd45 = jd43;
jd53 = -cos(x(1))*x(6)*sin(x(2))      - sin(x(1))*cos(x(2))*x(7);
jd54 = jd53;                          jd55 = jd53;

J  = [ j11          j12                  j13                      j14                      j15           ;...
       j21          j22                  j23                      j24                      j25           ;...
        0    (-cos(x(2))*h10)      (sin(x(2))*h11)          (sin(x(2))*h13)          (sin(x(2))*h15)     ;...
        0      (-sin(x(1)))    (-cos(x(1))*sin(x(2)))   (-cos(x(1))*sin(x(2)))   (-cos(x(1))*sin(x(2)))  ;...
        0        cos(x(1))     (-sin(x(1))*sin(x(2)))   (-sin(x(1))*sin(x(2)))   (-sin(x(1))*sin(x(2)))  ;...
        1           0               (-cos(x(2)))              (-cos(x(2)))            (-cos(x(2)))      ];
     
Jv = [ j11          j12                  j13                      j14                      j15           ;...
       j21          j22                  j23                      j24                      j25           ;...
        0    (-cos(x(2))*h10)      (sin(x(2))*h11)          (sin(x(2))*h13)          (sin(x(2))*h15)    ];
    
Jw = [  0      (-sin(x(1)))    (-cos(x(1))*sin(x(2)))   (-cos(x(1))*sin(x(2)))   (-cos(x(1))*sin(x(2)))  ;...
        0        cos(x(1))     (-sin(x(1))*sin(x(2)))   (-sin(x(1))*sin(x(2)))   (-sin(x(1))*sin(x(2)))  ;...
        1           0               (-cos(x(2)))              (-cos(x(2)))            (-cos(x(2)))      ];
    
Jd = [ jd11             jd12               jd13               jd14               jd15        ;...
       jd21             jd22               jd23               jd24               jd25        ;...
         0              jd32               jd33               jd34               jd35        ;...
         0       (-cos(x(1))*x(6))         jd43               jd44               jd45        ;...
         0       (-sin(x(1))*x(6))         jd53               jd54               jd55        ;...
         0               0           (sin(x(2))*x(7))   (sin(x(2))*x(7))   (sin(x(2))*x(7)) ];
   