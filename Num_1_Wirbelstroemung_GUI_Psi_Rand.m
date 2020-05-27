%% Psi_Rand
function [Psi_Rand] = Num_1_Wirbelstroemung_GUI_Psi_Rand(U_EA,nx,ny,h)
Nx = nx+2;
Ny = ny+2;

[u_EinAus,v_EinAus] = Num_1_Wirbelstroemung_GUI_Geschw_EinAus(U_EA,Nx,Ny);
[Psi_Rand] = psi_rand(u_EinAus,v_EinAus,Nx,Ny,h);
end

%% Psi_Rand
function [Psi_Rand] = psi_rand(u_EinAus,v_EinAus,Nx,Ny,h)
Psi_Rand = zeros(Ny,Nx);

for m = 1:1:Ny
    for n = 1:1:Nx
        if n == 1               % links
            if m == 1
                Psi_Rand(m,n) = 0;
            else
                Psi_Rand(m,n) = Psi_Rand(m-1,n)+h/2*(u_EinAus(m-1,n)+u_EinAus(m,n));
            end
        elseif m == 1 && n > 1  % oben
                Psi_Rand(m,n) = Psi_Rand(m,n-1)+h/2*(v_EinAus(m,n-1)+v_EinAus(m,n));
        elseif m == Ny && n > 1 % unten
               Psi_Rand(m,n) = Psi_Rand(m,n-1)+h/2*(v_EinAus(m,n-1)+v_EinAus(m,n));
        elseif n == Nx          % rechts
            if m == 1
                Psi_Rand(m,n) = Psi_Rand(m,n-1);
            else
                Psi_Rand(m,n) = Psi_Rand(m-1,n)+h/2*(u_EinAus(m-1,n)+u_EinAus(m,n));
            end
        else                    % innen
            Psi_Rand(m,n) = 0;
        end
    end
end
end