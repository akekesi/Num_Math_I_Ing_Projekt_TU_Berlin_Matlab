%% Runge-Kutta 4
function [Omega_neu] = Num_1_Wirbelstroemung_GUI_Runge_Kutta_4(dt,Omega,u,v,h)

k1 = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega,h);
k2 = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega+dt/2*k1,h);
k3 = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega+dt/2*k2,h);
k4 = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega+dt*k3,h);
Omega_neu = Omega+dt*(k1/6+k2/3+k3/3+k4/6);

end