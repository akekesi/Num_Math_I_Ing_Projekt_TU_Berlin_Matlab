%% Reibung
function [Reibung] = Num_1_Wirbelstroemung_GUI_Reibung(nue,U_Wand,Omega,Psi,Psi_Rand,nx,ny,h)

Omega_v = reshape(Omega,nx*ny,1);

[A] = Num_1_Wirbelstroemung_GUI_Laplace(nx,ny);

[Omega_Rand] = Num_1_Wirbelstroemung_GUI_Omega_Rand(U_Wand,Psi,Psi_Rand,nx,ny,h);  % als Matrix (n+2)x(n+2)
[Omega_Rand_v] = Num_1_Wirbelstroemung_GUI_Rand_Trafo(Omega_Rand); % als Vektor (ny*nx)x(1)

Reibung_v = nue*(1/h^2*A*Omega_v+1/h^2*Omega_Rand_v); % als Vektor (ny*nx)x(1)
Reibung = reshape(Reibung_v,ny,nx);                   % als Matrix (ny)x(nx)
end
