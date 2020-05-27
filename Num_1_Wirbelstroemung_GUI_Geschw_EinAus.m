%% Geschw_Rand
function [u_EinAus,v_EinAus] = Num_1_Wirbelstroemung_GUI_Geschw_EinAus(U_EA,Nx,Ny)
u_EinAus = zeros(Ny,Nx);
v_EinAus = zeros(Ny,Nx);

for m = 1:1:Ny
    for n = 1:1:Nx
        if n == 1              % links
            u_EinAus(m,n) = U_EA(1,1);
        elseif n == Nx         % rechts
            u_EinAus(m,n) = U_EA(2,1);
        elseif m == 1          % oben 
            v_EinAus(m,n) = U_EA(3,1);
        elseif m == Ny         % unten
            v_EinAus(m,n) = U_EA(4,1);
        else                   % innen
            u_EinAus(m,n) = 0;
            v_EinAus(m,n) = 0;
        end
    end
end
end