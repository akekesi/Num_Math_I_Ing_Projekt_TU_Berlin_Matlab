%% UpWind-Verfahern 2. Ordnung
function [d_Omega] = Num_1_Wirbelstroemung_GUI_UpWind_2(u,v,Omega,h)
d_Omega = zeros(size(Omega));
[ny,nx] = size(Omega);

% 2.Ordnung
for m = 1:1:ny
    for n = 1:1:nx
        if n == 1
            d_omega_x = 1/h*(Omega(m,n+1)-Omega(m,n));
        elseif n ==2
            if u(m,n) > 0
                d_omega_x = 1/h*(Omega(m,n)-Omega(m,n-1));
            elseif u(m,n) < 0
                d_omega_x = 1/h*(Omega(m,n+1)-Omega(m,n));
            end
        elseif n == nx
            d_omega_x = 1/h*(Omega(m,n)-Omega(m,n-1));
        elseif n == nx-1
            if u(m,n) > 0
                d_omega_x = 1/h*(Omega(m,n)-Omega(m,n-1));
            elseif u(m,n) < 0
                d_omega_x = 1/h*(Omega(m,n+1)-Omega(m,n));
            end
        elseif u(m,n) > 0
            d_omega_x = 1/2/h*(3*Omega(m,n)-4*Omega(m,n-1)+Omega(m,n-2));
        elseif u(m,n) < 0
            d_omega_x = 1/2/h*(-Omega(m,n+2)+4*Omega(m,n+1)-3*Omega(m,n));
        end
        
        if m == 1
            d_omega_y = 1/h*(Omega(m+1,n)-Omega(m,n));
        elseif m == 2
            if v(m,n) > 0
                d_omega_y = 1/h*(Omega(m,n)-Omega(m-1,n));
            elseif v(m,n) < 0
                d_omega_y = 1/h*(Omega(m+1,n)-Omega(m,n));
            end
        elseif m == ny
            d_omega_y = 1/h*(Omega(m,n)-Omega(m-1,n));
        elseif m == ny-1
            if v(m,n) > 0
                d_omega_y = 1/h*(Omega(m,n)-Omega(m-1,n));
            elseif v(m,n) < 0
                d_omega_y = 1/h*(Omega(m+1,n)-Omega(m,n));
            end
        elseif v(m,n) > 0
            d_omega_y = 1/2/h*(3*Omega(m,n)-4*Omega(m-1,n)+Omega(m-2,n));
        elseif v(m,n) < 0
            d_omega_y = 1/2/h*(-Omega(m+2,n)+4*Omega(m+1,n)-3*Omega(m,n));
        end
        d_Omega(m,n) = -(u(m,n)*d_omega_x + v(m,n)*d_omega_y);
    end
end
end