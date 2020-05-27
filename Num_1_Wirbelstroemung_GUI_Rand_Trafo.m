%% Rand
function [R_v] = Num_1_Wirbelstroemung_GUI_Rand_Trafo(R)
[Nx,Ny] = size(R);
nx = Nx-2;
ny = Ny-2;

R_v = zeros(nx*ny,1);
R_v(1,1) = R(1,2)+R(2,1);
R_v(ny,1) = R(ny+1,1)+R(ny+2,2);
R_v((nx-1)*ny+1,1) = R(1,nx+1)+R(2,nx+2);
R_v(nx*ny,1) = R(ny+1,nx+2)+R(ny+2,nx+1);
for m = 2:1:(nx-1)*ny
    if m < ny
        R_v(m,1) = R(m+1,1);
        R_v((nx-1)*ny+m,1) = R(m+1,nx+2);
    elseif mod(m,ny) == 1
        R_v(m,1) = R(1,(m-1)/ny+2);
        R_v(m+ny-1,1) = R(ny+2,(m-1)/ny+2);
    end
end
end