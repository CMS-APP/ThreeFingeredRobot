function I = inertia_tensors(m1, l1, w, d)

Ix1 = m1*(l1^2 + d^2) / 12 ;
Iy1 = m1*(d^2 + w^2) / 12 ;
Iz1 = m1*(w^2 + l1^2) / 12 ;

I = [Ix1 Iy1 Iz1] ;