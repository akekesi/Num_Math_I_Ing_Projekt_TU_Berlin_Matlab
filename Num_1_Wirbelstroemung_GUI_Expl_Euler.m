%% expliziter Euler
function [Omega_neu] = Num_1_Wirbelstroemung_GUI_Expl_Euler(dt,Omega,d_Omega)

Omega_neu = Omega+dt*d_Omega;

end