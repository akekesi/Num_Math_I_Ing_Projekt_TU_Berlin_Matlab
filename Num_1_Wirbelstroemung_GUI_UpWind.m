%% UpWind-Verfahern
function [d_Omega] = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega,h)
d_Omega = zeros(size(Omega));
[ny,nx] = size(Omega);

% 1.Ordnung
for m = 1:1:ny
    for n = 1:1:nx
        if n == 1
            d_omega_x = 1/h*(Omega(m,n+1)-Omega(m,n));
        elseif n == nx
            d_omega_x = 1/h*(Omega(m,n)-Omega(m,n-1));
        elseif u(m,n) > 0
            d_omega_x = 1/h*(Omega(m,n)-Omega(m,n-1));
        elseif u(m,n) < 0
            d_omega_x = 1/h*(Omega(m,n+1)-Omega(m,n));
        end
        if m == 1
            d_omega_y = 1/h*(Omega(m+1,n)-Omega(m,n));
        elseif m == ny
            d_omega_y = 1/h*(Omega(m,n)-Omega(m-1,n));
        elseif v(m,n) > 0
            d_omega_y = 1/h*(Omega(m,n)-Omega(m-1,n));
        elseif v(m,n) < 0
            d_omega_y = 1/h*(Omega(m+1,n)-Omega(m,n));
        end
        d_Omega(m,n) = -(u(m,n)*d_omega_x + v(m,n)*d_omega_y);
    end
end