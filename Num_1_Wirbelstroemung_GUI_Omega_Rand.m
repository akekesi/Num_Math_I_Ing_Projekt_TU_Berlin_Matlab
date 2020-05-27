%% Omega_Rand
function [Omega_Rand] = Num_1_Wirbelstroemung_GUI_Omega_Rand(U_Wand,Psi,Psi_Rand,nx,ny,h)
Nx = nx+2;
Ny = ny+2;
u_Wand_L = U_Wand(1,1); % nach oben (+)
u_Wand_R = U_Wand(2,1); % nach oben (-)
u_Wand_O = U_Wand(3,1); % nach rechts (+)
u_Wand_U = U_Wand(4,1); % nach rechts (-)

Omega_Rand = zeros(Ny,Nx);

for m = 1:1:Ny
    for n = 1:1:Nx
        if n == 1                     % links
            if m == 1
                Omega_Rand(m,n) = -1/h^2*Psi_Rand(m+1,n)-1/h^2*Psi_Rand(m,n+1);
            elseif m == Ny
                Omega_Rand(m,n) = -1/h^2*Psi_Rand(m-1,n)-1/h^2*Psi_Rand(m,n+1);
            else
                Omega_Rand(m,n) = -2*Psi(m-1,n)/h^2-2*u_Wand_L/h+4/h^2*Psi_Rand(m,n)-1/h^2*Psi_Rand(m-1,n)-1/h^2*Psi_Rand(m+1,n);
            end
        end
        if n == Nx                    % rechts
            if m == 1
                Omega_Rand(m,n) = -1/h^2*Psi_Rand(m+1,n)-1/h^2*Psi_Rand(m,n-1);
            elseif m == Ny
                Omega_Rand(m,n) = -1/h^2*Psi_Rand(m-1,n)-1/h^2*Psi_Rand(m,n-1);

            else
                Omega_Rand(m,n) = -2*Psi(m-1,n-2)/h^2-2*u_Wand_R/h+4/h^2*Psi_Rand(m,n)-1/h^2*Psi_Rand(m-1,n)-1/h^2*Psi_Rand(m+1,n);
            end
        end
        if m == 1 && n > 1 && n < Nx  % unten
            Omega_Rand(m,n) = -2*Psi(m,n-1)/h^2-2*u_Wand_U/h+4/h^2*Psi_Rand(m,n)-1/h^2*Psi_Rand(m,n-1)-1/h^2*Psi_Rand(m,n+1);
        end
        if m == Ny && n > 1 && n < Nx % oben
            Omega_Rand(m,n) = -2*Psi(m-2,n-1)/h^2-2*u_Wand_O/h+4/h^2*Psi_Rand(m,n)-1/h^2*Psi_Rand(m,n-1)-1/h^2*Psi_Rand(m,n+1);
        end
    end
end
end