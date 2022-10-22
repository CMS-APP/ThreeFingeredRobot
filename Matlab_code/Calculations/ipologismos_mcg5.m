function [M,C,Gq] = ipologismos_mcg5(x)  % Gq = stili

global lt L31 L41 L51
% m1 m2 m3 rm1 rm2 rm3 Ix1 Iy1 Iz1 Ix2 Iy2 Iz2 Ix3 Iy3 Iz3 g;

lm1 = lt(1);
lm2 = lt(2);
m1 = L31.m;
m2 = L41.m;
m3 = L51.m;
rm1 = L31.r(1);
rm2 = L41.r(1);
rm3 = L51.r(1);
Ix1 = L31.I(1);
Iy1 = L31.I(2);
Iz1 = L31.I(3);
Ix2 = L41.I(1);
Iy2 = L41.I(2);
Iz2 = L41.I(3);
Ix3 = L51.I(1);
Iy3 = L51.I(2);
Iz3 = L51.I(3);
g = 9.81;

x1 = x(1);  x2 = x(2);  x3 = x(3);  x4 = x(4);  x5 = x(5); x6 = x(6); x7 = x(7); x8 = x(8); x9 = x(9); x10 = x(10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1  = sin(x1);           s2  = sin(x2);            s3   = sin(x3);         c1   = cos(x1);           c2 = cos(x2);            c3 = cos(x3);     
s34 = sin(x3+x4);        c34 = cos(x3+x4);         s345 = sin(x3+x4+x5);   c345 = cos(x3+x4+x5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a1 = c3*lm1 + c34*rm2;                  b1 = s3*lm1 + s34*rm2;
a2 = c3*lm1 + c34*lm2 + c345*rm3;       b2 = s3*lm1 + s34*lm2 + s345*rm3;

ad1_q3 = -b1;  ad1_q4 = -s34*rm2;       ad2_q3 = -b2;                      ad2_q4 = -s34*lm2 - s345*rm3;   ad2_q5 = -s345*rm3;  
bd1_q3 = a1;   bd1_q4 =  c34*rm2;       bd2_q3 =  a2;                      bd2_q4 =  c34*lm2 + c345*rm3;   bd2_q5 =  c345*rm3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d1  = -s1*c2*c3*rm1 + c1*s3*rm1;      d2  = -c1*s2*c3*rm1;                d3  = -c1*c2*s3*rm1 + s1*c3*rm1; d4  = c1*c2*c3*rm1 + s1*s3*rm1; d5  = -s1*s2*c3*rm1;
d6  = -s1*c2*s3*rm1-c1*c3*rm1;        d7  = -c2*c3*rm1;                   d8  = s2*s3*rm1;                 d9  = -s1*c2*a1 + c1*b1;        d10 = -c1*s2*a1;
d11 = -c1*c2*b1 + s1*a1;              d12 = -c1*c2*s34*rm2 + s1*c34*rm2;  d13 = c1*c2*a1 + s1*b1;          d14 = -s1*s2*a1;                d15 = -s1*c2*b1 - c1*a1;
d16 = -s1*c2*s34*rm2 - c1*c34*rm2;    d17 = -c2*a1;                       d18 = s2*b1;                     d19 = s2*s34*rm2;               d20 = -s1*c2*a2 + c1*b2;
d21 = -c1*s2*a2;                      d22 = -c1*c2*b2 + s1*a2;            d23 = -c1*c2*s34*lm2 - c1*c2*s345*rm3 + s1*c34*lm2 + s1*c345*rm3;
d24 = -c1*c2*s345*rm3 + s1*c345*rm3;  d25 = c1*c2*a2 + s1*b2;             d26 = -s1*s2*a2;                                                 d27 = -s1*c2*b2 - c1*a2;
d28 = -s1*c2*s34*lm2 - s1*c2*s345*rm3 - c1*c34*lm2 - c1*c345*rm3;         d29 = -s1*c2*s345*rm3 - c1*c345*rm3;                             d30 = -c2*a2;
d31 = s2*b2;                          d32 = s2*s34*lm2 + s2*s345*rm3;     d33 = s2*s345*rm3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e1  = d1^2 + d4^2;                       e2  = d2^2 + d5^2 + d7^2;                e3  = d3^2 + d6^2 + d8^2;                e4  = 2*d1*d2 + 2*d4*d5;
e5  = 2*d1*d3 + 2*d4*d6;                 e6  = 2*d2*d3 + 2*d5*d6 + 2*d7*d8;       e7  = d9^2 + d13^2;                      e8  = d10^2 + d14^2 + d17^2;
e9  = d11^2 + d15^2 + d18^2;             e10 = d12^2 + d16^2 + d19^2;             e11 = 2*d9*d10 + 2*d13*d14;              e12 = 2*d9*d11 + 2*d13*d15;
e13 = 2*d9*d12 + 2*d13*d16;              e14 = 2*d10*d11 + 2*d14*d15 + 2*d17*d18; e15 = 2*d10*d12 + 2*d14*d16 + 2*d17*d19; e16 = 2*d11*d12 + 2*d15*d16 + 2*d18*d19;
e17 = d20^2 + d25^2;                     e18 = d21^2 + d26^2 + d30^2;             e19 = d22^2 + d27^2 + d31^2;             e20 = d23^2 + d28^2 +  d32^2;
e21 = d24^2 + d29^2 + d33^2;             e22 = 2*d20*d21 + 2*d25*d26;             e23 = 2*d20*d22 + 2*d25*d27;             e24 = 2*d20*d23 + 2*d25*d28;
e25 = 2*d20*d24 + 2*d25*d29;             e26 = 2*d21*d22 + 2*d26*d27 + 2*d30*d31; e27 = 2*d21*d23 + 2*d26*d28 + 2*d30*d32; e28 = 2*d21*d24 + 2*d26*d29 + 2*d30*d33;
e29 = 2*d22*d23 + 2*d27*d28 + 2*d31*d32; e30 = 2*d22*d24 + 2*d27*d29 + 2*d31*d33; e31 = 2*d23*d24 + 2*d28*d29 + 2*d32*d33;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f1  = m1*e1 + m2*e7 + m3*e17; f2  = m1*e2 + m2*e8 + m3*e18; f3  = m1*e3 + m2*e9 + m3*e19;  f4  = m1*e4 + m2*e11 + m3*e22;  f5  = m1*e5 + m2*e12 + m3*e23;
f6  = m2*e13 + m3*e24;        f7  = m3*e25;                 f8  = m1*e6 + m2*e14 + m3*e26; f9  = m2*e15 + m3*e27;          f10 = m3*e28;
f11 = m2*e16 + m3*e29;        f12 = m3*e30;
f13 = m3*e31;          f14 = s2^2*c3^2*Ix1 + s2^2*s3^2*Iy1 + c2^2*Iz1 + s2^2*c34^2*Ix2 + s2^2*s34^2*Iy2 + c2^2*Iz2 + s2^2*c345^2*Ix3 + s2^2*s345^2*Iy3 + c2^2*Iz3;
f15 = s3^2*Ix1 + c3^2*Iy1 + s34^2*Ix2 + c34^2*Iy2 + s345^2*Ix3 + c345^2*Iy3;                                               f16 = Iz1 + Iz2 + Iz3;
f17 = Iz2 + Iz3;       f18 = Iz3;
f19 = 2*s3*s2*c3*Ix1 - 2*c3*s2*s3*Iy1 + 2*s34*s2*c34*Ix2 - 2*c34*s2*s34*Iy2 + 2*s345*s2*c345*Ix3 - 2*c345*s2*s345*Iy3;     f20 = -2*c2*(Iz1+Iz2+Iz3);
f21 = -2*c2*(Iz2+Iz3);                                      f22 = -2*c2*Iz3;               f23 = 2*Iz2 + 2*Iz3;            f24 = 2*Iz3;
f25 = 2*Iz3;                                                f26 = m2*e10 + m3*e20;         f27 = m3*e21;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dd1_q1  = -c1*c2*rm1*c3-s1*s3*rm1; dd1_q2 = s2*s1*c3*rm1;  dd1_q3 = s1*c2*s3*rm1+c1*c3*rm1;    dd1_q4 = 0;                        dd1_q5 = 0;
dd2_q1  = s1*s2*c3*rm1;            dd2_q2 = -c1*c2*c3*rm1; dd2_q3 = c1*s2*s3*rm1;              dd2_q4 = 0;                        dd2_q5 = 0;
dd3_q1  = s1*c2*s3*rm1+c1*c3*rm1;  dd3_q2 = c1*s2*s3*rm1;  dd3_q3 = -c1*c2*c3*rm1-s1*s3*rm1;   dd3_q4 = 0;                        dd3_q5 = 0;
dd4_q1  = -s1*c2*c3*rm1+c1*s3*rm1; dd4_q2 = -c1*s2*c3*rm1; dd4_q3 = -c1*c2*s3*rm1+s1*c3*rm1;   dd4_q4 = 0;                        dd4_q5 = 0;
dd5_q1  = -c1*s2*c3*rm1;           dd5_q2 = -s1*c2*c3*rm1; dd5_q3 = s1*s2*s3*rm1;              dd5_q4 = 0;                        dd5_q5 = 0;
dd6_q1  = -c1*c2*s3*rm1+s1*c3*rm1; dd6_q2 = s1*s2*s3*rm1;  dd6_q3 = -s1*c2*c3*rm1+c1*s3*rm1;   dd6_q4 = 0;                        dd6_q5 = 0;
dd7_q1  = 0;                       dd7_q2 = s2*c3*rm1;     dd7_q3 = c2*s3*rm1;                 dd7_q4 = 0;                        dd7_q5 = 0;
dd8_q1  = 0;                       dd8_q2 = c2*s3*rm1;     dd8_q3 = s2*c3*rm1;                 dd8_q4 = 0;                        dd8_q5 = 0; 
dd9_q1  = -c1*c2*a1-s1*b1;         dd9_q2 = s1*s2*a1;      dd9_q3 = -s1*c2*ad1_q3+c1*bd1_q3;   dd9_q4 = -s1*c2*ad1_q4+c1*bd1_q4;  dd9_q5 = 0; 
dd10_q1 = s1*s2*a1;                dd10_q2 = -c1*c2*a1;    dd10_q3 = -c1*s2*ad1_q3;            dd10_q4 = -c1*s2*ad1_q4;           dd10_q5 = 0;
dd11_q1 = s1*c2*b1+c1*a1;          dd11_q2 = c1*s2*b1;     dd11_q3 = -c1*c2*bd1_q3+s1*ad1_q3;  dd11_q4 = -c1*c2*bd1_q4+s1*ad1_q4; dd11_q5 = 0;
dd12_q1 = s1*c2*s34*rm2+c1*c34*rm2;dd12_q2 = c1*s2*s34*rm2;dd12_q3 = -c1*c2*c34*rm2-s1*s34*rm2; dd12_q4 = -c1*c2*c34*rm2-s1*s34*rm2; dd12_q5 = 0;
dd13_q1 = -s1*c2*a1+c1*b1;         dd13_q2 = -c1*s2*a1;    dd13_q3 = c1*c2*ad1_q3+s1*bd1_q3;   dd13_q4 = c1*c2*ad1_q4+s1*bd1_q4;  dd13_q5 = 0;
dd14_q1 = -c1*s2*a1;               dd14_q2 = -s1*c2*a1;    dd14_q3 = -s1*s2*ad1_q3;            dd14_q4 = -s1*s2*ad1_q4;           dd14_q5 = 0;
dd15_q1 = -c1*c2*b1+s1*a1;         dd15_q2 = s1*s2*b1;     dd15_q3 = -s1*c2*bd1_q3-c1*ad1_q3;  dd15_q4 = -s1*c2*bd1_q4-c1*ad1_q4; dd15_q5 = 0;
dd16_q1 = -c1*c2*s34*rm2+s1*c34*rm2; dd16_q2 = s1*s2*s34*rm2; dd16_q3 = -s1*c2*c34*rm2+c1*s34*rm2; dd16_q4 = -s1*c2*c34*rm2+c1*s34*rm2; dd16_q5 = 0;
dd17_q1 = 0;                       dd17_q2 = s2*a1;        dd17_q3 = -c2*ad1_q3;               dd17_q4 = -c2*ad1_q4;              dd17_q5 = 0;  
dd18_q1 = 0;                       dd18_q2 = c2*b1;        dd18_q3 = s2*bd1_q3;                dd18_q4 = s2*bd1_q4;               dd18_q5 = 0;  
dd19_q1 = 0;                       dd19_q2 = c2*s34*rm2;   dd19_q3 = s2*c34*rm2;               dd19_q4 = s2*c34*rm2;              dd19_q5 = 0;  
dd20_q1 = -c1*c2*a2-s1*b2;         dd20_q2 = s1*s2*a2;     dd20_q3 = -s1*c2*ad2_q3+c1*bd2_q3; dd20_q4 = -s1*c2*ad2_q4+c1*bd2_q4; dd20_q5 = -s1*c2*ad2_q5+c1*bd2_q5;  
dd21_q1 = s1*s2*a2;                dd21_q2 = -c1*c2*a2;    dd21_q3 = -c1*s2*ad2_q3;           dd21_q4 = -c1*s2*ad2_q4;           dd21_q5 = -c1*s2*ad2_q5;  
dd22_q1 = s1*c2*b2+c1*a2;          dd22_q2 = c1*s2*b2;     dd22_q3 = -c1*c2*bd2_q3+s1*ad2_q3; dd22_q4 = -c1*c2*bd2_q4+s1*ad2_q4; dd22_q5 = -c1*c2*bd2_q5+s1*ad2_q5;  
dd23_q1 = s1*c2*s34*lm2+s1*c2*s345*rm3+c1*c34*lm2+c1*c345*rm3;                                dd23_q2 = c1*s2*s34*lm2+c1*s2*s345*rm3; 
dd23_q3 = -c1*c2*c34*lm2-c1*c2*c345*rm3-s1*s34*lm2-s1*s345*rm3;                               dd23_q5 = -c1*c2*c345*rm3-s1*s345*rm3;
dd23_q4 = -c1*c2*c34*lm2-c1*c2*c345*rm3-s1*s34*lm2-s1*s345*rm3; 
dd24_q1 = s1*c2*s345*rm3+c1*c345*rm3;                      dd24_q2 = c1*s2*s345*rm3;          dd24_q3 = -c1*c2*c345*rm3-s1*s345*rm3; 
dd24_q4 = -c1*c2*c345*rm3-s1*s345*rm3;                                                        dd24_q5 = -c1*c2*c345*rm3-s1*s345*rm3;
dd25_q1 = -s1*c2*a2+c1*b2;                                 dd25_q2 = -c1*s2*a2;               dd25_q3 = c1*c2*ad2_q3+s1*bd2_q3; 
dd25_q4 = c1*c2*ad2_q4+s1*bd2_q4;                                                             dd25_q5 = c1*c2*ad2_q5+s1*bd2_q5; 
dd26_q1 = -c1*s2*a2;                                       dd26_q2 = -s1*c2*a2;               dd26_q3 = -s1*s2*ad2_q3;
dd26_q4 = -s1*s2*ad2_q4;                                                                      dd26_q5 = -s1*s2*ad2_q5;
dd27_q1 = -c1*c2*b2+s1*a2;                                 dd27_q2 = s1*s2*b2;                dd27_q3 = -s1*c2*bd2_q3-c1*ad2_q3;
dd27_q4 = -s1*c2*bd2_q4-c1*ad2_q4;                                                            dd27_q5 = -s1*c2*bd2_q5-c1*ad2_q5;
dd28_q1 = -c1*c2*s34*lm2-c1*c2*s345*rm3+s1*c34*lm2+s1*c345*rm3;                               dd28_q2 = s1*s2*s34*lm2+s1*s2*s345*rm3; 
dd28_q3 = -s1*c2*c34*lm2-s1*c2*c345*rm3+c1*s34*lm2+c1*s345*rm3;                               dd28_q4 = -s1*c2*c34*lm2-s1*c2*c345*rm3+c1*s34*lm2+c1*s345*rm3;  
dd28_q5 = -s1*c2*c345*rm3+c1*s345*rm3;
dd29_q1 = -c1*c2*s345*rm3+s1*c345*rm3;                     dd29_q2 = s1*s2*s345*rm3;          dd29_q3 = -s1*c2*c345*rm3+c1*s345*rm3; 
dd29_q4 = -s1*c2*c345*rm3+c1*s345*rm3;                                                        dd29_q5 = -s1*c2*c345*rm3+c1*s345*rm3;
dd30_q1 = 0;                                               dd30_q2 = s2*a2;                   dd30_q3 = -c2*ad2_q3;
dd30_q4 = -c2*ad2_q4;                                                                         dd30_q5 = -c2*ad2_q5; 
dd31_q1 = 0;                                               dd31_q2 = c2*b2;                   dd31_q3 = s2*bd2_q3;
dd31_q4 = s2*bd2_q4;                                                                          dd31_q5 = s2*bd2_q5;
dd32_q1 = 0;                                               dd32_q2 = c2*s34*lm2+c2*s345*rm3;  dd32_q3 = s2*c34*lm2+s2*c345*rm3;
dd32_q4 = s2*c34*lm2+s2*c345*rm3;                                                             dd32_q5 = s2*c345*rm3;
dd33_q1 = 0;                                               dd33_q2 = c2*s345*rm3;             dd33_q3 = s2*c345*rm3;
dd33_q4 = s2*c345*rm3;                                                                        dd33_q5 = s2*c345*rm3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ed1_q1 = 2*d1*dd1_q1 + 2*d4*dd4_q1;                ed1_q2 = 2*d1*dd1_q2 + 2*d4*dd4_q2;                ed1_q3 = 2*d1*dd1_q3 + 2*d4*dd4_q3; 
ed1_q4 = 2*d1*dd1_q4 + 2*d4*dd4_q4;                                                                   ed1_q5 = 2*d1*dd1_q5 + 2*d4*dd4_q5;
ed2_q1 = 2*d2*dd2_q1 + 2*d5*dd5_q1 + 2*d7*dd7_q1;  ed2_q2 = 2*d2*dd2_q2 + 2*d5*dd5_q2 + 2*d7*dd7_q2;  ed2_q3 = 2*d2*dd2_q3 + 2*d5*dd5_q3 + 2*d7*dd7_q3;
ed2_q4 = 2*d2*dd2_q4 + 2*d5*dd5_q4 + 2*d7*dd7_q4;                                                     ed2_q5 = 2*d2*dd2_q5 + 2*d5*dd5_q5 + 2*d7*dd7_q5;
ed3_q1 = 2*d3*dd3_q1 + 2*d6*dd6_q1 + 2*d8*dd8_q1;  ed3_q2 = 2*d3*dd3_q2 + 2*d6*dd6_q2 + 2*d8*dd8_q2;  ed3_q3 = 2*d3*dd3_q3 + 2*d6*dd6_q3 + 2*d8*dd8_q3;
ed3_q4 = 2*d3*dd3_q4 + 2*d6*dd6_q4 + 2*d8*dd8_q4;                                                     ed3_q5 = 2*d3*dd3_q5 + 2*d6*dd6_q5 + 2*d8*dd8_q5;
ed4_q1 = 2*dd1_q1*d2 + 2*d1*dd2_q1 + 2*dd4_q1*d5 + 2*d4*dd5_q1;            ed4_q2 = 2*dd1_q2*d2 + 2*d1*dd2_q2 + 2*dd4_q2*d5 + 2*d4*dd5_q2;
ed4_q3 = 2*dd1_q3*d2 + 2*d1*dd2_q3 + 2*dd4_q3*d5 + 2*d4*dd5_q3;            ed4_q4 = 2*dd1_q4*d2 + 2*d1*dd2_q4 + 2*dd4_q4*d5 + 2*d4*dd5_q4;
ed4_q5 = 2*dd1_q5*d2 + 2*d1*dd2_q5 + 2*dd4_q5*d5 + 2*d4*dd5_q5;
ed5_q1 = 2*dd1_q1*d3 + 2*d1*dd3_q1 + 2*dd4_q1*d6 + 2*d4*dd6_q1;            ed5_q2 = 2*dd1_q2*d3 + 2*d1*dd3_q2 + 2*dd4_q2*d6 + 2*d4*dd6_q2;
ed5_q3 = 2*dd1_q3*d3 + 2*d1*dd3_q3 + 2*dd4_q3*d6 + 2*d4*dd6_q3;            ed5_q4 = 2*dd1_q4*d3 + 2*d1*dd3_q4 + 2*dd4_q4*d6 + 2*d4*dd6_q4;
ed5_q5 = 2*dd1_q5*d3 + 2*d1*dd3_q5 + 2*dd4_q5*d6 + 2*d4*dd6_q5;
ed6_q1 = 2*dd2_q1*d3 + 2*d2*dd3_q1 + 2*dd5_q1*d6 + 2*d5*dd6_q1 + 2*dd7_q1*d8 + 2*d7*dd8_q1;
ed6_q2 = 2*dd2_q2*d3 + 2*d2*dd3_q2 + 2*dd5_q2*d6 + 2*d5*dd6_q2 + 2*dd7_q2*d8 + 2*d7*dd8_q2;
ed6_q3 = 2*dd2_q3*d3 + 2*d2*dd3_q3 + 2*dd5_q3*d6 + 2*d5*dd6_q3 + 2*dd7_q3*d8 + 2*d7*dd8_q3;
ed6_q4 = 2*dd2_q4*d3 + 2*d2*dd3_q4 + 2*dd5_q4*d6 + 2*d5*dd6_q4 + 2*dd7_q4*d8 + 2*d7*dd8_q4;
ed6_q5 = 2*dd2_q5*d3 + 2*d2*dd3_q5 + 2*dd5_q5*d6 + 2*d5*dd6_q5 + 2*dd7_q5*d8 + 2*d7*dd8_q5;
ed7_q1 = 2*d9*dd9_q1 + 2*d13*dd13_q1;                                      ed7_q2 = 2*d9*dd9_q2 + 2*d13*dd13_q2;            ed7_q3 = 2*d9*dd9_q3 + 2*d13*dd13_q3; 
ed7_q4 = 2*d9*dd9_q4 + 2*d13*dd13_q4;                                                                                       ed7_q5 = 2*d9*dd9_q5 + 2*d13*dd13_q5;
ed8_q1 = 2*d10*dd10_q1 + 2*d14*dd14_q1 + 2*d17*dd17_q1;                    ed8_q2 = 2*d10*dd10_q2 + 2*d14*dd14_q2 + 2*d17*dd17_q2; 
ed8_q3 = 2*d10*dd10_q3 + 2*d14*dd14_q3 + 2*d17*dd17_q3;                    ed8_q4 = 2*d10*dd10_q4 + 2*d14*dd14_q4 + 2*d17*dd17_q4;  
ed8_q5 = 2*d10*dd10_q5 + 2*d14*dd14_q5 + 2*d17*dd17_q5;
ed9_q1 = 2*d11*dd11_q1 + 2*d15*dd15_q1 + 2*d18*dd18_q1;                    ed9_q2 = 2*d11*dd11_q2 + 2*d15*dd15_q2 + 2*d18*dd18_q2; 
ed9_q3 = 2*d11*dd11_q3 + 2*d15*dd15_q3 + 2*d18*dd18_q3;                    ed9_q4 = 2*d11*dd11_q4 + 2*d15*dd15_q4 + 2*d18*dd18_q4;  
ed9_q5 = 2*d11*dd11_q5 + 2*d15*dd15_q5 + 2*d18*dd18_q5;
ed10_q1 = 2*d12*dd12_q1 + 2*d16*dd16_q1 + 2*d19*dd19_q1;                   ed10_q2 = 2*d12*dd12_q2 + 2*d16*dd16_q2 + 2*d19*dd19_q2; 
ed10_q3 = 2*d12*dd12_q3 + 2*d16*dd16_q3 + 2*d19*dd19_q3;                   ed10_q4 = 2*d12*dd12_q4 + 2*d16*dd16_q4 + 2*d19*dd19_q4;  
ed10_q5 = 2*d12*dd12_q5 + 2*d16*dd16_q5 + 2*d19*dd19_q5;
ed11_q1 = 2*dd9_q1*d10 + 2*d9*dd10_q1 + 2*dd13_q1*d14 + 2*d13*dd14_q1;     ed11_q2 = 2*dd9_q2*d10 + 2*d9*dd10_q2 + 2*dd13_q2*d14 + 2*d13*dd14_q2;
ed11_q3 = 2*dd9_q3*d10 + 2*d9*dd10_q3 + 2*dd13_q3*d14 + 2*d13*dd14_q3;     ed11_q4 = 2*dd9_q4*d10 + 2*d9*dd10_q4 + 2*dd13_q4*d14 + 2*d13*dd14_q4;
ed11_q5 = 2*dd9_q5*d10 + 2*d9*dd10_q5 + 2*dd13_q5*d14 + 2*d13*dd14_q5;
ed12_q1 = 2*dd9_q1*d11 + 2*d9*dd11_q1 + 2*dd13_q1*d15 + 2*d13*dd15_q1;     ed12_q2 = 2*dd9_q2*d11 + 2*d9*dd11_q2 + 2*dd13_q2*d15 + 2*d13*dd15_q2;
ed12_q3 = 2*dd9_q3*d11 + 2*d9*dd11_q3 + 2*dd13_q3*d15 + 2*d13*dd15_q3;     ed12_q4 = 2*dd9_q4*d11 + 2*d9*dd11_q4 + 2*dd13_q4*d15 + 2*d13*dd15_q4;
ed12_q5 = 2*dd9_q5*d11 + 2*d9*dd11_q5 + 2*dd13_q5*d15 + 2*d13*dd15_q5;
ed13_q1 = 2*dd9_q1*d12 + 2*d9*dd12_q1 + 2*dd13_q1*d16 + 2*d13*dd16_q1;     ed13_q2 = 2*dd9_q2*d12 + 2*d9*dd12_q2 + 2*dd13_q2*d16 + 2*d13*dd16_q2;
ed13_q3 = 2*dd9_q3*d12 + 2*d9*dd12_q3 + 2*dd13_q3*d16 + 2*d13*dd16_q3;     ed13_q4 = 2*dd9_q4*d12 + 2*d9*dd12_q4 + 2*dd13_q4*d16 + 2*d13*dd16_q4;
ed13_q5 = 2*dd9_q5*d12 + 2*d9*dd12_q5 + 2*dd13_q5*d16 + 2*d13*dd16_q5;
ed14_q1 = 2*dd10_q1*d11 + 2*d10*dd11_q1 + 2*dd14_q1*d15 + 2*d14*dd15_q1    + 2*dd17_q1*d18 + 2*d17*dd18_q1;
ed14_q2 = 2*dd10_q2*d11 + 2*d10*dd11_q2 + 2*dd14_q2*d15 + 2*d14*dd15_q2    + 2*dd17_q2*d18 + 2*d17*dd18_q2;
ed14_q3 = 2*dd10_q3*d11 + 2*d10*dd11_q3 + 2*dd14_q3*d15 + 2*d14*dd15_q3    + 2*dd17_q3*d18 + 2*d17*dd18_q3;
ed14_q4 = 2*dd10_q4*d11 + 2*d10*dd11_q4 + 2*dd14_q4*d15 + 2*d14*dd15_q4    + 2*dd17_q4*d18 + 2*d17*dd18_q4;
ed14_q5 = 2*dd10_q5*d11 + 2*d10*dd11_q5 + 2*dd14_q5*d15 + 2*d14*dd15_q5    + 2*dd17_q5*d18 + 2*d17*dd18_q5;
ed15_q1 = 2*dd10_q1*d12 + 2*d10*dd12_q1 + 2*dd14_q1*d16 + 2*d14*dd16_q1    + 2*dd17_q1*d19 + 2*d17*dd19_q1;
ed15_q2 = 2*dd10_q2*d12 + 2*d10*dd12_q2 + 2*dd14_q2*d16 + 2*d14*dd16_q2    + 2*dd17_q2*d19 + 2*d17*dd19_q2;
ed15_q3 = 2*dd10_q3*d12 + 2*d10*dd12_q3 + 2*dd14_q3*d16 + 2*d14*dd16_q3    + 2*dd17_q3*d19 + 2*d17*dd19_q3;
ed15_q4 = 2*dd10_q4*d12 + 2*d10*dd12_q4 + 2*dd14_q4*d16 + 2*d14*dd16_q4    + 2*dd17_q4*d19 + 2*d17*dd19_q4;
ed15_q5 = 2*dd10_q5*d12 + 2*d10*dd12_q5 + 2*dd14_q5*d16 + 2*d14*dd16_q5    + 2*dd17_q5*d19 + 2*d17*dd19_q5;
ed16_q1 = 2*dd11_q1*d12 + 2*d11*dd12_q1 + 2*dd15_q1*d16 + 2*d15*dd16_q1    + 2*dd18_q1*d19 + 2*d18*dd19_q1;
ed16_q2 = 2*dd11_q2*d12 + 2*d11*dd12_q2 + 2*dd15_q2*d16 + 2*d15*dd16_q2    + 2*dd18_q2*d19 + 2*d18*dd19_q2;
ed16_q3 = 2*dd11_q3*d12 + 2*d11*dd12_q3 + 2*dd15_q3*d16 + 2*d15*dd16_q3    + 2*dd18_q3*d19 + 2*d18*dd19_q3;
ed16_q4 = 2*dd11_q4*d12 + 2*d11*dd12_q4 + 2*dd15_q4*d16 + 2*d15*dd16_q4    + 2*dd18_q4*d19 + 2*d18*dd19_q4;
ed16_q5 = 2*dd11_q5*d12 + 2*d11*dd12_q5 + 2*dd15_q5*d16 + 2*d15*dd16_q5    + 2*dd18_q5*d19 + 2*d18*dd19_q5;
ed17_q1 = 2*d20*dd20_q1 + 2*d25*dd25_q1;                                   ed17_q2 = 2*d20*dd20_q2 + 2*d25*dd25_q2;      ed17_q3 = 2*d20*dd20_q3 + 2*d25*dd25_q3; 
ed17_q4 = 2*d20*dd20_q4 + 2*d25*dd25_q4;                                                                                 ed17_q5 = 2*d20*dd20_q5 + 2*d25*dd25_q5;
ed18_q1 = 2*d21*dd21_q1 + 2*d26*dd26_q1 + 2*d30*dd30_q1;                   ed18_q2 = 2*d21*dd21_q2 + 2*d26*dd26_q2 + 2*d30*dd30_q2; 
ed18_q3 = 2*d21*dd21_q3 + 2*d26*dd26_q3 + 2*d30*dd30_q3;                   ed18_q4 = 2*d21*dd21_q4 + 2*d26*dd26_q4 + 2*d30*dd30_q4;  
ed18_q5 = 2*d21*dd21_q5 + 2*d26*dd26_q5 + 2*d30*dd30_q5;
ed19_q1 = 2*d22*dd22_q1 + 2*d27*dd27_q1 + 2*d31*dd31_q1;                   ed19_q2 = 2*d22*dd22_q2 + 2*d27*dd27_q2 + 2*d31*dd31_q2; 
ed19_q3 = 2*d22*dd22_q3 + 2*d27*dd27_q3 + 2*d31*dd31_q3;                   ed19_q4 = 2*d22*dd22_q4 + 2*d27*dd27_q4 + 2*d31*dd31_q4;  
ed19_q5 = 2*d22*dd22_q5 + 2*d27*dd27_q5 + 2*d31*dd31_q5;
ed20_q1 = 2*d23*dd23_q1 + 2*d28*dd28_q1 + 2*d32*dd32_q1;                   ed20_q2 = 2*d23*dd23_q2 + 2*d28*dd28_q2 + 2*d32*dd32_q2; 
ed20_q3 = 2*d23*dd23_q3 + 2*d28*dd28_q3 + 2*d32*dd32_q3;                   ed20_q4 = 2*d23*dd23_q4 + 2*d28*dd28_q4 + 2*d32*dd32_q4;  
ed20_q5 = 2*d23*dd23_q5 + 2*d28*dd28_q5 + 2*d32*dd32_q5;
ed21_q1 = 2*d24*dd24_q1 + 2*d29*dd29_q1 + 2*d33*dd33_q1;                   ed21_q2 = 2*d24*dd24_q2 + 2*d29*dd29_q2 + 2*d33*dd33_q2; 
ed21_q3 = 2*d24*dd24_q3 + 2*d29*dd29_q3 + 2*d33*dd33_q3;                   ed21_q4 = 2*d24*dd24_q4 + 2*d29*dd29_q4 + 2*d33*dd33_q4;  
ed21_q5 = 2*d24*dd24_q5 + 2*d29*dd29_q5 + 2*d33*dd33_q5;
ed22_q1 = 2*dd20_q1*d21 + 2*d20*dd21_q1 + 2*dd25_q1*d26 + 2*d25*dd26_q1;   ed22_q2 = 2*dd20_q2*d21 + 2*d20*dd21_q2 + 2*dd25_q2*d26 + 2*d25*dd26_q2;
ed22_q3 = 2*dd20_q3*d21 + 2*d20*dd21_q3 + 2*dd25_q3*d26 + 2*d25*dd26_q3;   ed22_q4 = 2*dd20_q4*d21 + 2*d20*dd21_q4 + 2*dd25_q4*d26 + 2*d25*dd26_q4;
ed22_q5 = 2*dd20_q5*d21 + 2*d20*dd21_q5 + 2*dd25_q5*d26 + 2*d25*dd26_q5;
ed23_q1 = 2*dd20_q1*d22 + 2*d20*dd22_q1 + 2*dd25_q1*d27 + 2*d25*dd27_q1;   ed23_q2 = 2*dd20_q2*d22 + 2*d20*dd22_q2 + 2*dd25_q2*d27 + 2*d25*dd27_q2;
ed23_q3 = 2*dd20_q3*d22 + 2*d20*dd22_q3 + 2*dd25_q3*d27 + 2*d25*dd27_q3;   ed23_q4 = 2*dd20_q4*d22 + 2*d20*dd22_q4 + 2*dd25_q4*d27 + 2*d25*dd27_q4;
ed23_q5 = 2*dd20_q5*d22 + 2*d20*dd22_q5 + 2*dd25_q5*d27 + 2*d25*dd27_q5;
ed24_q1 = 2*dd20_q1*d23 + 2*d20*dd23_q1 + 2*dd25_q1*d28 + 2*d25*dd28_q1;   ed24_q2 = 2*dd20_q2*d23 + 2*d20*dd23_q2 + 2*dd25_q2*d28 + 2*d25*dd28_q2;
ed24_q3 = 2*dd20_q3*d23 + 2*d20*dd23_q3 + 2*dd25_q3*d28 + 2*d25*dd28_q3;   ed24_q4 = 2*dd20_q4*d23 + 2*d20*dd23_q4 + 2*dd25_q4*d28 + 2*d25*dd28_q4;
ed24_q5 = 2*dd20_q5*d23 + 2*d20*dd23_q5 + 2*dd25_q5*d28 + 2*d25*dd28_q5;
ed25_q1 = 2*dd20_q1*d24 + 2*d20*dd24_q1 + 2*dd25_q1*d29 + 2*d25*dd29_q1;   ed25_q2 = 2*dd20_q2*d24 + 2*d20*dd24_q2 + 2*dd25_q2*d29 + 2*d25*dd29_q2;
ed25_q3 = 2*dd20_q3*d24 + 2*d20*dd24_q3 + 2*dd25_q3*d29 + 2*d25*dd29_q3;   ed25_q4 = 2*dd20_q4*d24 + 2*d20*dd24_q4 + 2*dd25_q4*d29 + 2*d25*dd29_q4;
ed25_q5 = 2*dd20_q5*d24 + 2*d20*dd24_q5 + 2*dd25_q5*d29 + 2*d25*dd29_q5;
ed26_q1 = 2*dd21_q1*d22 + 2*d21*dd22_q1 + 2*dd26_q1*d27 + 2*d26*dd27_q1 + 2*dd30_q1*d31 + 2*d30*dd31_q1;
ed26_q2 = 2*dd21_q2*d22 + 2*d21*dd22_q2 + 2*dd26_q2*d27 + 2*d26*dd27_q2 + 2*dd30_q2*d31 + 2*d30*dd31_q2;
ed26_q3 = 2*dd21_q3*d22 + 2*d21*dd22_q3 + 2*dd26_q3*d27 + 2*d26*dd27_q3 + 2*dd30_q3*d31 + 2*d30*dd31_q3;
ed26_q4 = 2*dd21_q4*d22 + 2*d21*dd22_q4 + 2*dd26_q4*d27 + 2*d26*dd27_q4 + 2*dd30_q4*d31 + 2*d30*dd31_q4;
ed26_q5 = 2*dd21_q5*d22 + 2*d21*dd22_q5 + 2*dd26_q5*d27 + 2*d26*dd27_q5 + 2*dd30_q5*d31 + 2*d30*dd31_q5;
ed27_q1 = 2*dd21_q1*d23 + 2*d21*dd23_q1 + 2*dd26_q1*d28 + 2*d26*dd28_q1 + 2*dd30_q1*d32 + 2*d30*dd32_q1;
ed27_q2 = 2*dd21_q2*d23 + 2*d21*dd23_q2 + 2*dd26_q2*d28 + 2*d26*dd28_q2 + 2*dd30_q2*d32 + 2*d30*dd32_q2;
ed27_q3 = 2*dd21_q3*d23 + 2*d21*dd23_q3 + 2*dd26_q3*d28 + 2*d26*dd28_q3 + 2*dd30_q3*d32 + 2*d30*dd32_q3;
ed27_q4 = 2*dd21_q4*d23 + 2*d21*dd23_q4 + 2*dd26_q4*d28 + 2*d26*dd28_q4 + 2*dd30_q4*d32 + 2*d30*dd32_q4;
ed27_q5 = 2*dd21_q5*d23 + 2*d21*dd23_q5 + 2*dd26_q5*d28 + 2*d26*dd28_q5 + 2*dd30_q5*d32 + 2*d30*dd32_q5;
ed28_q1 = 2*dd21_q1*d24 + 2*d21*dd24_q1 + 2*dd26_q1*d29 + 2*d26*dd29_q1 + 2*dd30_q1*d33 + 2*d30*dd33_q1;
ed28_q2 = 2*dd21_q2*d24 + 2*d21*dd24_q2 + 2*dd26_q2*d29 + 2*d26*dd29_q2 + 2*dd30_q2*d33 + 2*d30*dd33_q2;
ed28_q3 = 2*dd21_q3*d24 + 2*d21*dd24_q3 + 2*dd26_q3*d29 + 2*d26*dd29_q3 + 2*dd30_q3*d33 + 2*d30*dd33_q3;
ed28_q4 = 2*dd21_q4*d24 + 2*d21*dd24_q4 + 2*dd26_q4*d29 + 2*d26*dd29_q4 + 2*dd30_q4*d33 + 2*d30*dd33_q4;
ed28_q5 = 2*dd21_q5*d24 + 2*d21*dd24_q5 + 2*dd26_q5*d29 + 2*d26*dd29_q5 + 2*dd30_q5*d33 + 2*d30*dd33_q5;
ed29_q1 = 2*dd22_q1*d23 + 2*d22*dd23_q1 + 2*dd27_q1*d28 + 2*d27*dd28_q1 + 2*dd31_q1*d32 + 2*d31*dd32_q1;
ed29_q2 = 2*dd22_q2*d23 + 2*d22*dd23_q2 + 2*dd27_q2*d28 + 2*d27*dd28_q2 + 2*dd31_q2*d32 + 2*d31*dd32_q2;
ed29_q3 = 2*dd22_q3*d23 + 2*d22*dd23_q3 + 2*dd27_q3*d28 + 2*d27*dd28_q3 + 2*dd31_q3*d32 + 2*d31*dd32_q3;
ed29_q4 = 2*dd22_q4*d23 + 2*d22*dd23_q4 + 2*dd27_q4*d28 + 2*d27*dd28_q4 + 2*dd31_q4*d32 + 2*d31*dd32_q4;
ed29_q5 = 2*dd22_q5*d23 + 2*d22*dd23_q5 + 2*dd27_q5*d28 + 2*d27*dd28_q5 + 2*dd31_q5*d32 + 2*d31*dd32_q5;      
ed30_q1 = 2*dd22_q1*d24 + 2*d22*dd24_q1 + 2*dd27_q1*d29 + 2*d27*dd29_q1 + 2*dd31_q1*d33 + 2*d31*dd33_q1;
ed30_q2 = 2*dd22_q2*d24 + 2*d22*dd24_q2 + 2*dd27_q2*d29 + 2*d27*dd29_q2 + 2*dd31_q2*d33 + 2*d31*dd33_q2;
ed30_q3 = 2*dd22_q3*d24 + 2*d22*dd24_q3 + 2*dd27_q3*d29 + 2*d27*dd29_q3 + 2*dd31_q3*d33 + 2*d31*dd33_q3;
ed30_q4 = 2*dd22_q4*d24 + 2*d22*dd24_q4 + 2*dd27_q4*d29 + 2*d27*dd29_q4 + 2*dd31_q4*d33 + 2*d31*dd33_q4;
ed30_q5 = 2*dd22_q5*d24 + 2*d22*dd24_q5 + 2*dd27_q5*d29 + 2*d27*dd29_q5 + 2*dd31_q5*d33 + 2*d31*dd33_q5; 
ed31_q1 = 2*dd23_q1*d24 + 2*d23*dd24_q1 + 2*dd28_q1*d29 + 2*d28*dd29_q1 + 2*dd32_q1*d33 + 2*d32*dd33_q1;
ed31_q2 = 2*dd23_q2*d24 + 2*d23*dd24_q2 + 2*dd28_q2*d29 + 2*d28*dd29_q2 + 2*dd32_q2*d33 + 2*d32*dd33_q2;
ed31_q3 = 2*dd23_q3*d24 + 2*d23*dd24_q3 + 2*dd28_q3*d29 + 2*d28*dd29_q3 + 2*dd32_q3*d33 + 2*d32*dd33_q3;
ed31_q4 = 2*dd23_q4*d24 + 2*d23*dd24_q4 + 2*dd28_q4*d29 + 2*d28*dd29_q4 + 2*dd32_q4*d33 + 2*d32*dd33_q4;
ed31_q5 = 2*dd23_q5*d24 + 2*d23*dd24_q5 + 2*dd28_q5*d29 + 2*d28*dd29_q5 + 2*dd32_q5*d33 + 2*d32*dd33_q5; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fd1_q1 = m1*ed1_q1  + m2*ed7_q1 + m3*ed17_q1;    fd1_q2 = m1*ed1_q2  + m2*ed7_q2  + m3*ed17_q2;  fd1_q3 = m1*ed1_q3  + m2*ed7_q3 + m3*ed17_q3;
fd1_q4 = m1*ed1_q4  + m2*ed7_q4 + m3*ed17_q4;    fd1_q5 = m1*ed1_q5  + m2*ed7_q5  + m3*ed17_q5;
fd2_q1 = m1*ed2_q1  + m2*ed8_q1 + m3*ed18_q1;    fd2_q2 = m1*ed2_q2  + m2*ed8_q2  + m3*ed18_q2;  fd2_q3 = m1*ed2_q3  + m2*ed8_q3 + m3*ed18_q3;
fd2_q4 = m1*ed2_q4  + m2*ed8_q4 + m3*ed18_q4;    fd2_q5 = m1*ed2_q5  + m2*ed8_q5  + m3*ed18_q5;
fd3_q1 = m1*ed3_q1  + m2*ed9_q1 + m3*ed19_q1;    fd3_q2 = m1*ed3_q2  + m2*ed9_q2  + m3*ed19_q2;  fd3_q3 = m1*ed3_q3  + m2*ed9_q3 + m3*ed19_q3;
fd3_q4 = m1*ed3_q4  + m2*ed9_q4 + m3*ed19_q4;    fd3_q5 = m1*ed3_q5  + m2*ed9_q5  + m3*ed19_q5;
fd4_q1 = m1*ed4_q1  + m2*ed11_q1 + m3*ed22_q1;   fd4_q2 = m1*ed4_q2  + m2*ed11_q2 + m3*ed22_q2;  fd4_q3 = m1*ed4_q3  + m2*ed11_q3 + m3*ed22_q3;
fd4_q4 = m1*ed4_q4  + m2*ed11_q4 + m3*ed22_q4;   fd4_q5 = m1*ed4_q5  + m2*ed11_q5 + m3*ed22_q5;
fd5_q1 = m1*ed5_q1  + m2*ed12_q1 + m3*ed23_q1;   fd5_q2 = m1*ed5_q2  + m2*ed12_q2 + m3*ed23_q2;  fd5_q3 = m1*ed5_q3  + m2*ed12_q3 + m3*ed23_q3;
fd5_q4 = m1*ed5_q4  + m2*ed12_q4 + m3*ed23_q4;   fd5_q5 = m1*ed5_q5  + m2*ed12_q5 + m3*ed23_q5;
fd6_q1 = m2*ed13_q1 + m3*ed24_q1;                fd6_q2 = m2*ed13_q2 + m3*ed24_q2;               fd6_q3 = m2*ed13_q3 + m3*ed24_q3;
fd6_q4 = m2*ed13_q4 + m3*ed24_q4;                fd6_q5 = m2*ed13_q5 + m3*ed24_q5;
fd7_q1 = m3*ed25_q1;                             fd7_q2 = m3*ed25_q2;                            fd7_q3 = m3*ed25_q3;
fd7_q4 = m3*ed25_q4;                             fd7_q5 = m3*ed25_q5;
fd8_q1 = m1*ed6_q1  + m2*ed14_q1 + m3*ed26_q1;   fd8_q2 = m1*ed6_q2  + m2*ed14_q2 + m3*ed26_q2;  fd8_q3 = m1*ed6_q3  + m2*ed14_q3 + m3*ed26_q3;
fd8_q4 = m1*ed6_q4  + m2*ed14_q4 + m3*ed26_q4;   fd8_q5 = m1*ed6_q5  + m2*ed14_q5 + m3*ed26_q5;
fd9_q1 = m2*ed15_q1 + m3*ed27_q1;                fd9_q2 = m2*ed15_q2 + m3*ed27_q2;               fd9_q3 = m2*ed15_q3 + m3*ed27_q3;
fd9_q4 = m2*ed15_q4 + m3*ed27_q4;                fd9_q5 = m2*ed15_q5 + m3*ed27_q5;
fd10_q1 = m3*ed28_q1;                            fd10_q2 = m3*ed28_q2;                           fd10_q3 = m3*ed28_q3;
fd10_q4 = m3*ed28_q4;                            fd10_q5 = m3*ed28_q5;
fd11_q1 = m2*ed16_q1 + m3*ed29_q1;               fd11_q2 = m2*ed16_q2 + m3*ed29_q2;              fd11_q3 = m2*ed16_q3 + m3*ed29_q3;
fd11_q4 = m2*ed16_q4 + m3*ed29_q4;               fd11_q5 = m2*ed16_q5 + m3*ed29_q5;
fd12_q1 = m3*ed30_q1;                            fd12_q2 = m3*ed30_q2;                           fd12_q3 = m3*ed30_q3;
fd12_q4 = m3*ed30_q4;                            fd12_q5 = m3*ed30_q5;
fd13_q1 = m3*ed31_q1;                            fd13_q2 = m3*ed31_q2;                           fd13_q3 = m3*ed31_q3;
fd13_q4 = m3*ed31_q4;                            fd13_q5 = m3*ed31_q5;
fd26_q1 = m2*ed10_q1 + m3*ed20_q1;               fd26_q2 = m2*ed10_q2 + m3*ed20_q2;              fd26_q3 = m2*ed10_q3 + m3*ed20_q3;
fd26_q4 = m2*ed10_q4 + m3*ed20_q4;               fd26_q5 = m2*ed10_q5 + m3*ed20_q5;
fd27_q1 = m3*ed21_q1;                            fd27_q2 = m3*ed21_q2;                           fd27_q3 = m3*ed21_q3;
fd27_q4 = m3*ed21_q4;                            fd27_q5 = m3*ed21_q5;
fd14_q1 = 0;                                     
fd14_q2 = 2*s2*c2*c3^2*Ix1+2*s2*c2*s3^2*Iy1-2*c2*s2*Iz1+2*s2*c2*c34^2*Ix2+2*s2*c2*s34^2*Iy2-2*c2*s2*Iz2+2*s2*c2*c345^2*Ix3+2*s2*c2*s345^2*Iy3-2*c2*s2*Iz3;
fd14_q3 = -2*c3*s3*s2^2*Ix1+2*s3*c3*s2^2*Iy1-2*c34*s34*s2^2*Ix2+2*s34*c34*s2^2*Iy2-2*c345*s345*s2^2*Ix3+2*s345*c345*s2^2*Iy3;
fd14_q4 = -2*c34*s34*s2^2*Ix2+2*s34*c34*s2^2*Iy2-2*c345*s345*s2^2*Ix3+2*s345*c345*s2^2*Iy3;
fd14_q5 = -2*c345*s345*s2^2*Ix3+2*s345*c345*s2^2*Iy3;
fd15_q1 = 0;                                                               fd15_q2 = 0;
fd15_q3 = 2*s3*c3*Ix1-2*c3*s3*Iy1+2*s34*c34*Ix2-2*c34*s34*Iy2+2*s345*c345*Ix3-2*c345*s345*Iy3;
fd15_q4 = 2*s34*c34*Ix2-2*c34*s34*Iy2+2*s345*c345*Ix3-2*c345*s345*Iy3;
fd15_q5 = 2*s345*c345*Ix3-2*c345*s345*Iy3;
fd16_q1 = 0;  fd16_q2 = 0;  fd16_q3 = 0;  fd16_q4 = 0;  fd16_q5 = 0;       fd17_q1 = 0;  fd17_q2 = 0;  fd17_q3 = 0;  fd17_q4 = 0;  fd17_q5 = 0;
fd18_q1 = 0;  fd18_q2 = 0;  fd18_q3 = 0;  fd18_q4 = 0;  fd18_q5 = 0;       fd23_q1 = 0;  fd23_q2 = 0;  fd23_q3 = 0;  fd23_q4 = 0;  fd23_q5 = 0;
fd24_q1 = 0;  fd24_q2 = 0;  fd24_q3 = 0;  fd24_q4 = 0;  fd24_q5 = 0;       fd25_q1 = 0;  fd25_q2 = 0;  fd25_q3 = 0;  fd25_q4 = 0;  fd25_q5 = 0;
fd19_q1 = 0;
fd19_q2 = 2*c2*s3*c3*Ix1-2*c2*c3*s3*Iy1+2*c2*s34*c34*Ix2-2*c2*c34*s34*Iy2+2*c2*s345*c345*Ix3-2*c2*c345*s345*Iy3;
fd19_q3 = 2*c3^2*s2*Ix1-2*s3^2*s2*Ix1+2*s3^2*s2*Iy1-2*c3^2*s2*Iy1+2*c34^2*s2*Ix2-2*s34^2*s2*Ix2+2*s34^2*s2*Iy2-2*c34^2*s2*Iy2+2*c345^2*s2*Ix3-2*s345^2*s2*Ix3+...
          2*s345^2*s2*Iy3-2*c345^2*s2*Iy3;
fd19_q4 = 2*c34^2*s2*Ix2-2*s34^2*s2*Ix2+2*s34^2*s2*Iy2-2*c34^2*s2*Iy2+2*c345^2*s2*Ix3-2*s345^2*s2*Ix3+2*s345^2*s2*Iy3-2*c345^2*s2*Iy3;
fd19_q5 = 2*c345^2*s2*Ix3-2*s345^2*s2*Ix3+2*s345^2*s2*Iy3-2*c345^2*s2*Iy3;
fd20_q1 = 0;  fd20_q2 = 2*s2*(Iz1+Iz2+Iz3);                                fd20_q3 = 0;  fd20_q4 = 0;    fd20_q5 = 0;
fd21_q1 = 0;  fd21_q2 = 2*s2*(Iz2+Iz3);                                    fd21_q3 = 0;  fd21_q4 = 0;    fd21_q5 = 0; 
fd22_q1 = 0;  fd22_q2 = 2*s2*Iz3;                                          fd22_q3 = 0;  fd22_q4 = 0;    fd22_q5 = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ccc111 = .5*(fd1_q1+fd14_q1);                                                     ccc211 = .5*(fd1_q2+fd14_q2);  
ccc311 = .5*(fd1_q3+fd14_q3);                                                     ccc411 = .5*(fd1_q4+fd14_q4);                                                     
ccc511 = .5*(fd1_q5+fd14_q5); 
cc11   = ccc111*x6 + ccc211*x7 + ccc311*x8 + ccc411*x9 + ccc511*x10;

ccc121 = .5*(fd1_q2+fd14_q2);                                                     ccc221 = .5*(fd4_q2+fd19_q2-fd2_q1-fd15_q1); 
ccc321 = .5*(.5*fd4_q3+.5*fd19_q3+.5*fd5_q2+.5*fd20_q2-.5*fd8_q1);                ccc421 = .5*(.5*fd4_q4+.5*fd19_q4+.5*fd6_q2+.5*fd21_q2-.5*fd9_q1);                
ccc521 = .5*(.5*fd4_q5+.5*fd19_q5+.5*fd7_q2+.5*fd22_q2-.5*fd10_q1);
cc12   = ccc121*x6 + ccc221*x7 + ccc321*x8 + ccc421*x9 + ccc521*x10;

ccc131 = .5*(fd1_q3+fd14_q3);                                                     ccc231 = .5*(.5*fd5_q2+.5*fd20_q2+.5*fd4_q3+.5*fd19_q3-.5*fd8_q1);
ccc331 = .5*(fd5_q3+fd20_q3-fd3_q1-fd16_q1);                                      ccc431 = .5*(.5*fd5_q4+.5*fd20_q4+.5*fd6_q3+.5*fd21_q3-.5*fd11_q1-.5*fd23_q1);  
ccc531 = .5*(.5*fd5_q5+.5*fd20_q5+.5*fd7_q3+.5*fd22_q3-.5*fd12_q1-.5*fd24_q1);
cc13   = ccc131*x6 + ccc231*x7 + ccc331*x8 + ccc431*x9 + ccc531*x10;

ccc141 = .5*(fd1_q4+fd14_q4);                                                     ccc241 = .5*(.5*fd6_q2+.5*fd21_q2+.5*fd4_q4+.5*fd19_q4-.5*fd9_q1); 
ccc341 = .5*(.5*fd6_q3+.5*fd21_q3+.5*fd5_q4+.5*fd20_q4-.5*fd11_q1-.5*fd23_q1);    ccc441 = .5*(fd6_q4+fd21_q4-fd17_q1-fd26_q1);
ccc541 = .5*(.5*fd6_q5+.5*fd21_q5+.5*fd7_q4+.5*fd22_q4-.5*fd13_q1-.5*fd25_q1);
cc14   = ccc141*x6 + ccc241*x7 + ccc341*x8 + ccc441*x9 + ccc541*x10;

ccc151 = .5*(fd1_q5+fd14_q5);                                                     ccc251 = .5*(.5*fd7_q2+.5*fd22_q2+.5*fd4_q5+.5*fd19_q5-.5*fd10_q1);  
ccc351 = .5*(.5*fd7_q3+.5*fd22_q3+.5*fd5_q5+.5*fd20_q5-.5*fd12_q1-.5*fd24_q1);    ccc451 = .5*(.5*fd7_q4+.5*fd22_q4+.5*fd6_q5+.5*fd21_q5-.5*fd13_q1-.5*fd25_q1);
ccc551 = .5*(fd7_q5+fd22_q5-fd18_q1-fd27_q1);
cc15   = ccc151*x6 + ccc251*x7 + ccc351*x8 + ccc451*x9 + ccc551*x10;

ccc112 = .5*(fd4_q1+fd19_q1-fd1_q2-fd14_q2);                                      ccc312 = .5*(.5*fd4_q3+.5*fd19_q3+.5*fd8_q1-.5*fd5_q2-.5*fd20_q2);
ccc212 = .5*(fd2_q1+fd15_q1);                                                     ccc512 = .5*(.5*fd4_q5+.5*fd19_q5+.5*fd10_q1-.5*fd7_q2-.5*fd22_q2);
ccc412 = .5*(.5*fd4_q4+.5*fd19_q4+.5*fd9_q1-.5*fd6_q2-.5*fd21_q2);  
cc21   = ccc112*x6 + ccc212*x7 + ccc312*x8 + ccc412*x9 + ccc512*x10;
  
ccc122 = .5*(fd2_q1+fd15_q1);                                                     ccc422 = .5*(fd2_q4+fd15_q4); 
ccc222 = .5*(fd2_q2+fd15_q2);                                                     ccc322 = .5*(fd2_q3+fd15_q3);                     
ccc522 = .5*(fd2_q5+fd15_q5);
cc22   = ccc122*x6 + ccc222*x7 + ccc322*x8 + ccc422*x9 + ccc522*x10;

ccc132 = .5*(.5*fd8_q1+.5*fd4_q3+.5*fd19_q3-.5*fd5_q2-.5*fd20_q2);                ccc232 = .5*(fd2_q3+fd15_q3);    
ccc432 = .5*(.5*fd8_q4+.5*fd9_q3-.5*fd11_q2-.5*fd23_q2);                          ccc332 = .5*(fd8_q3-fd3_q2-fd16_q2);
ccc532 = .5*(.5*fd8_q5+.5*fd10_q3-.5*fd12_q2-.5*fd24_q2);
cc23   = ccc132*x6 + ccc232*x7 + ccc332*x8 + ccc432*x9 + ccc532*x10;

ccc142 = .5*(.5*fd9_q1+.5*fd4_q4+.5*fd19_q4-.5*fd6_q2-.5*fd21_q2);                ccc242 = .5*(fd2_q4+fd15_q4); 
ccc342 = .5*(.5*fd9_q3+.5*fd8_q4-.5*fd11_q2-.5*fd23_q2);                          ccc542 = .5*(.5*fd9_q5+.5*fd10_q4-.5*fd13_q2-.5*fd25_q2);
ccc442 = .5*(fd9_q4-fd17_q2-fd26_q2);                                      
cc24   = ccc142*x6 + ccc242*x7 + ccc342*x8 + ccc442*x9 + ccc542*x10;

ccc152 = .5*(.5*fd10_q1+.5*fd4_q5+.5*fd19_q5-.5*fd7_q2-.5*fd22_q2);               ccc252 = .5*(fd2_q5+fd15_q5);    
ccc352 = .5*(.5*fd10_q3+.5*fd8_q5-.5*fd12_q2-.5*fd24_q2);                         ccc552 = .5*(fd10_q5-fd18_q2-fd27_q2);
ccc452 = .5*(.5*fd10_q4+.5*fd9_q5-.5*fd13_q2-.5*fd25_q2); 
cc25   = ccc152*x6 + ccc252*x7 + ccc352*x8 + ccc452*x9 + ccc552*x10;

ccc113 = .5*(fd5_q1+fd20_q1-fd1_q3-fd14_q3);                                      ccc513 = .5*(.5*fd5_q5+.5*fd20_q5+.5*fd12_q1+.5*fd24_q1-.5*fd7_q3-.5*fd22_q3);
ccc213 = .5*(.5*fd5_q2+.5*fd20_q2+.5*fd8_q1-.5*fd4_q3-.5*fd19_q3);                ccc313 = .5*(fd3_q1+fd16_q1);
ccc413 = .5*(.5*fd5_q4+.5*fd20_q4+.5*fd11_q1+.5*fd23_q1-.5*fd6_q3-.5*fd21_q3);  
cc31   = ccc113*x6 + ccc213*x7 + ccc313*x8 + ccc413*x9 + ccc513*x10;

ccc123 = .5*(.5*fd8_q1+.5*fd5_q2+.5*fd20_q2-.5*fd4_q3-.5*fd19_q3);                ccc223 = .5*(fd8_q2-fd2_q3-fd15_q3);  
ccc423 = .5*(.5*fd8_q4+.5*fd11_q2+.5*fd23_q2-.5*fd9_q3);                          ccc323 = .5*(fd3_q2+fd16_q2);
ccc523 = .5*(.5*fd8_q5+.5*fd12_q2+.5*fd24_q2-.5*fd10_q3);
cc32   = ccc123*x6 + ccc223*x7 + ccc323*x8 + ccc423*x9 + ccc523*x10;

ccc133 = .5*(fd3_q1+fd16_q1);                                                     ccc233 = .5*(fd3_q2+fd16_q2);                        
ccc433 = .5*(fd3_q4+fd16_q4);                                                     ccc333 = .5*(fd3_q3+fd16_q3);
ccc533 = .5*(fd3_q5+fd16_q5);
cc33   = ccc133*x6 + ccc233*x7 + ccc333*x8 + ccc433*x9 + ccc533*x10;

ccc143 = .5*(.5*fd11_q1+.5*fd23_q1+.5*fd5_q4+.5*fd20_q4-.5*fd6_q3-.5*fd21_q3);    ccc243 = .5*(.5*fd11_q2+.5*fd23_q2+.5*fd8_q4-.5*fd9_q3);
ccc343 = .5*(fd3_q4+fd16_q4);                                                     ccc443 = .5*(fd11_q4+fd23_q4-fd17_q3-fd26_q3);  
ccc543 = .5*(.5*fd11_q5+.5*fd23_q5+.5*fd12_q4+.5*fd24_q4-.5*fd13_q3-.5*fd25_q3);
cc34   = ccc143*x6 + ccc243*x7 + ccc343*x8 + ccc443*x9 + ccc543*x10;

ccc153 = .5*(.5*fd12_q1+.5*fd24_q1+.5*fd5_q5+.5*fd20_q5-.5*fd7_q3-.5*fd22_q3);    ccc253 = .5*(.5*fd12_q2+.5*fd24_q2+.5*fd8_q5-.5*fd10_q3);
ccc353 = .5*(fd3_q5+fd16_q5);                                                     ccc453 = .5*(.5*fd12_q4+.5*fd24_q4+.5*fd11_q5+.5*fd23_q5-.5*fd13_q3-.5*fd25_q3); 
ccc553 = .5*(fd12_q5+fd24_q5-fd18_q3-fd27_q3);
cc35   = ccc153*x6 + ccc253*x7 + ccc353*x8 + ccc453*x9 + ccc553*x10;

ccc114 = .5*(fd6_q1+fd21_q1-fd1_q4-fd14_q4);                                      ccc214 = .5*(.5*fd6_q2+.5*fd21_q2+.5*fd9_q1-.5*fd4_q4-.5*fd19_q4);
ccc314 = .5*(.5*fd6_q3+.5*fd21_q3+.5*fd11_q1+.5*fd23_q1-.5*fd5_q4-.5*fd20_q4);    ccc414 = .5*(fd17_q1+fd26_q1);  
ccc514 = .5*(.5*fd6_q5+.5*fd21_q5+.5*fd13_q1+.5*fd25_q1-.5*fd7_q4-.5*fd22_q4);
cc41   = ccc114*x6 + ccc214*x7 + ccc314*x8 + ccc414*x9 + ccc514*x10;

ccc124 = .5*(.5*fd9_q1+.5*fd6_q2+.5*fd21_q2-.5*fd4_q4-.5*fd19_q4);                ccc224 = .5*(fd9_q2-fd2_q4-fd15_q4);
ccc324 = .5*(.5*fd9_q3+.5*fd11_q2+.5*fd23_q2-.5*fd8_q4);                          ccc424 = .5*(fd17_q2+fd26_q2); 
ccc524 = .5*(.5*fd9_q5+.5*fd13_q2+.5*fd25_q2-.5*fd10_q4);
cc42   = ccc124*x6 + ccc224*x7 + ccc324*x8 + ccc424*x9 + ccc524*x10;

ccc134 = .5*(.5*fd11_q1+.5*fd23_q1+.5*fd6_q3+.5*fd21_q3-.5*fd5_q4-.5*fd20_q4);    ccc234 = .5*(.5*fd11_q2+.5*fd23_q2+.5*fd9_q3-.5*fd8_q4);
ccc334 = .5*(fd11_q3+fd23_q3-fd3_q4-fd16_q4);                                     ccc434 = .5*(fd17_q3+fd26_q3);        
ccc534 = .5*(.5*fd11_q5+.5*fd23_q5+.5*fd13_q3+.5*fd25_q3-.5*fd12_q4-.5*fd24_q4);
cc43   = ccc134*x6 + ccc234*x7 + ccc334*x8 + ccc434*x9 + ccc534*x10;

ccc144 = .5*(fd17_q1+fd26_q1);                                                    ccc244 = .5*(fd17_q2+fd26_q2);          
ccc444 = .5*(fd17_q4+fd26_q4);                                                    ccc344 = .5*(fd17_q3+fd26_q3);   
ccc544 = .5*(fd17_q5+fd26_q5);
cc44   = ccc144*x6 + ccc244*x7 + ccc344*x8 + ccc444*x9 + ccc544*x10;

ccc154 = .5*(.5*fd13_q1+.5*fd25_q1+.5*fd6_q5+.5*fd21_q5-.5*fd7_q4-.5*fd22_q4);    ccc254 = .5*(.5*fd13_q2+.5*fd25_q2+.5*fd9_q5-.5*fd10_q4);
ccc354 = .5*(.5*fd13_q3+.5*fd25_q3+.5*fd11_q5+.5*fd23_q5-.5*fd12_q4-.5*fd24_q4);  ccc454 = .5*(fd17_q5+fd26_q5); 
ccc554 = .5*(fd13_q5+fd25_q5-fd18_q4-fd27_q4);
cc45   = ccc154*x6 + ccc254*x7 + ccc354*x8 + ccc454*x9 + ccc554*x10;

ccc115 = .5*(fd7_q1+fd22_q1-fd1_q5-fd14_q5);                                      ccc215 = .5*(.5*fd7_q2+.5*fd22_q2+.5*fd10_q1-.5*fd4_q5-.5*fd19_q5);   
ccc515 = .5*(fd18_q1+fd27_q1);                                                    ccc415 = .5*(.5*fd7_q4+.5*fd22_q4+.5*fd13_q1+.5*fd25_q1-.5*fd6_q5-.5*fd21_q5);
ccc315 = .5*(.5*fd7_q3+.5*fd22_q3+.5*fd12_q1+.5*fd24_q1-.5*fd5_q5-.5*fd20_q5);  
cc51   = ccc115*x6 + ccc215*x7 + ccc315*x8 + ccc415*x9 + ccc515*x10;

ccc125 = .5*(.5*fd10_q1+.5*fd7_q2+.5*fd22_q2-.5*fd4_q5-.5*fd19_q5);               ccc225 = .5*(fd10_q2-fd2_q5-fd15_q5);  
ccc425 = .5*(.5*fd10_q4+.5*fd13_q2+.5*fd25_q2-.5*fd9_q5);                         ccc325 = .5*(.5*fd10_q3+.5*fd12_q2+.5*fd24_q2-.5*fd8_q5);
ccc525 = .5*(fd18_q2+fd27_q2);
cc52   = ccc125*x6 + ccc225*x7 + ccc325*x8 + ccc425*x9 + ccc525*x10;

ccc135 = .5*(.5*fd12_q1+.5*fd24_q1+.5*fd7_q3+.5*fd22_q3-.5*fd5_q5-.5*fd20_q5);    ccc235 = .5*(.5*fd12_q2+.5*fd24_q2+.5*fd10_q3-.5*fd8_q5);
ccc335 = .5*(fd12_q3+fd24_q3-fd3_q5-fd16_q5);                                     ccc435 = .5*(.5*fd12_q4+.5*fd24_q4+.5*fd13_q3+.5*fd25_q3-.5*fd11_q5-.5*fd23_q5);   
ccc535 = .5*(fd18_q3+fd27_q3);
cc53   = ccc135*x6 + ccc235*x7 + ccc335*x8 + ccc435*x9 + ccc535*x10;

ccc145 = .5*(.5*fd13_q1+.5*fd25_q1+.5*fd7_q4+.5*fd22_q4-.5*fd6_q5-.5*fd21_q5);    ccc245 = .5*(.5*fd13_q2+.5*fd25_q2+.5*fd10_q4-.5*fd9_q5);
ccc345 = .5*(.5*fd13_q3+.5*fd25_q3+.5*fd12_q4+.5*fd24_q4-.5*fd11_q5-.5*fd23_q5);  ccc445 = .5*(fd13_q4+fd25_q4-fd17_q5-fd26_q5); 
ccc545 = .5*(fd18_q4+fd27_q4);
cc54   = ccc145*x6 + ccc245*x7 + ccc345*x8 + ccc445*x9 + ccc545*x10;

ccc155 = .5*(fd18_q1+fd27_q1);                                                     ccc255 = .5*(fd18_q2+fd27_q2); 
ccc355 = .5*(fd18_q3+fd27_q3);                                                     ccc455 = .5*(fd18_q4+fd27_q4); 
ccc555 = .5*(fd18_q5+fd27_q5);
cc55   = ccc155*x6 + ccc255*x7 + ccc355*x8 + ccc455*x9 + ccc555*x10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gg1 = 0;                  gg2 = -m1*g*rm1*c3*c2  - m2*g*a1*c2 - m3*g*a2*c2;         gg3 = m1*g*s2*rm1*s3 - m2*g*s2*ad1_q3 - m3*g*s2*ad2_q3;   
gg5 = -m3*g*s2*ad2_q5;    gg4 = -m2*g*s2*ad1_q4 - m3*g*s2*ad2_q4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = [   (f1+f14)    (.5*(f4+f19))  (.5*(f5+f20))    (.5*(f6+f21))  (.5*(f7+f22))   ;...
     (.5*(f4+f19))     (f2+f15)       (.5*f8)          (.5*f9)        (.5*f10)     ;...
     (.5*(f5+f20))      (.5*f8)      (f3+f16)      (.5*(f11+f23))  (.5*(f12+f24))  ;...
     (.5*(f6+f21))      (.5*f9)    (.5*(f11+f23))     (f17+f26)    (.5*(f13+f25))  ;...
     (.5*(f7+f22))     (.5*f10)    (.5*(f12+f24))  (.5*(f13+f25))    (f18+f27)    ];

C = [cc11 cc12 cc13 cc14 cc15 ;...
     cc21 cc22 cc23 cc24 cc25 ;...
     cc31 cc32 cc33 cc34 cc35 ;...
     cc41 cc42 cc43 cc44 cc45 ;...
     cc51 cc52 cc53 cc54 cc55];
 
 Gq = [gg1 ; gg2 ; gg3 ; gg4 ; gg5];
