%% Adams-Baschforth
function [Omega_neu] = Num_1_Wirbelstroemung_GUI_Adams_Baschforth(dt,Omega,u,v,Omega_1,u_1,v_1,h)
Omega_neu = Omega+dt/2*(3*Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega,h)-Num_1_Wirbelstroemung_GUI_UpWind(u_1,v_1,Omega_1,h));
end