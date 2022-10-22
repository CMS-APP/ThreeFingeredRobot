function [k, th] = equiaxis(R)

th = acos((R(1,1)+R(2,2)+R(3,3)-1)/2);
k = 1/(2*sin(th))*[R(3,2) - R(2,3);
                    R(1,3) - R(3,1);
                    R(2,1) - R(1,2)]';
                

                