function status = threedee_out(t,x,flag)

global f lambda pt1 pt2 u dfi dlxi dlzi dni sn Phi Psi det5 det4 pc1 pc2 dwt1 dwt2 dpt1o dpt2o dwt1o dwt2o k                     % in
global poc1o poc2o O1 O2 O3 O4 Nar nx1 nz1 nx2 nz2 nc1 nc2 nx1e nz1e nx2e nz2e nc1e nc2e bpsi1 bpsi2 bphi1 bphi2  eul2 eul1 %in
global qwer t_out x_out F Lambda ptt ptm U Dfi Dlxi Dlzi Dni Sn phi psi Det5 Det4 pct pcm Dwt1 Dwt2 Dpt1o Dpt2o Dwt1o Dwt2o     % out
global Poc1o Poc2o o1 o2 o3 o4 sphi Nx1 Nz1 Nx2 Nz2 Nc1 Nc2 Nx1e Nz1e Nx2e Nz2e Nc1e Nc2e Bpsi1 Bpsi2 Bphi1 Bphi2 Eul1 Eul2 K   %out
    
global dpt1 dpt2 dpt3 
global Dpt1 Dpt2 Dpt3

if ~isequal(flag,'done')
    qwer            = qwer + 1;
    t_out(qwer, :)  = t(1);
    
    Dpt1            = [Dpt1; dpt1'];
    Dpt2            = [Dpt2; dpt2'];
    Dpt3            = [Dpt3; dpt3'];
    
    status = false;
    
%     qwer                = qwer + 1;
%     t_out(qwer,:)         = t(1);
%     x_out(qwer,:)       = x;
%     F(qwer,:)           = f;
%     Lambda(qwer,:)      = lambda;
%     ptt(qwer,:)         = pt1;
%     ptm(qwer,:)         = pt2;
%     U(qwer,:)           = u;
%     Dfi(qwer,:)         = dfi;
%     Dlxi(qwer,:)        = dlxi;
%     Dlzi(qwer,:)        = dlzi;
%     Dni(qwer,:)         = dni;
%     Sn(qwer,:)          = sn;
%     phi(qwer,:)         = Phi;
%     psi(qwer,:)         = Psi;
%     Det5(qwer,:)        = det5;
%     Det4(qwer,:)        = det4;
%     pct(qwer,:)         = pc1;
%     pcm(qwer,:)         = pc2;
%     Kd(qwer,:)          = kd;
%     Dpt1(qwer,:)        = dpt1;
%     Dpt2(qwer,:)        = dpt2;
%     Dwt1(qwer,:)        = dwt1;
%     Dwt2(qwer,:)        = dwt2;
%     Dpt1o(qwer,:)       = dpt1o;
%     Dpt2o(qwer,:)       = dpt2o;
%     Dwt1o(qwer,:)       = dwt1o;
%     Dwt2o(qwer,:)       = dwt2o;
%     Poc1o(qwer,:)       = poc1o;
%     Poc2o(qwer,:)       = poc2o;
%     o1(qwer,:)          = O1;
%     o2(qwer,:)          = O2;
%     o3(qwer,:)          = O3;
%     o4(qwer,:)          = O4;
%     sphi(qwer,:)        = Nar;
%     Nx1(qwer,:)         = nx1;
%     Nz1(qwer,:)         = nz1;
%     Nx2(qwer,:)         = nx2;
%     Nz2(qwer,:)         = nz2;
%     Nc1(qwer,:)         = nc1;
%     Nc2(qwer,:)         = nc2;
%     Dn1(qwer,:)         = dn1;
%     Dn2(qwer,:)         = dn2;
%     Nx1e(qwer,:)        = nx1e;
%     Nz1e(qwer,:)        = nz1e;
%     Nx2e(qwer,:)        = nx2e;
%     Nz2e(qwer,:)        = nz2e;
%     Nc1e(qwer,:)        = nc1e;
%     Nc2e(qwer,:)        = nc2e;
%     Bpsi1(qwer,:)       = bpsi1;
%     Bpsi2(qwer,:)       = bpsi2;
%     Bphi1(qwer,:)       = bphi1;
%     Bphi2(qwer,:)       = bphi2;
%     Eul1(qwer,:)        = eul1;
%     Eul2(qwer,:)        = eul2;
%     K(qwer,:)           = k;

else
    status = true;
    return;
end