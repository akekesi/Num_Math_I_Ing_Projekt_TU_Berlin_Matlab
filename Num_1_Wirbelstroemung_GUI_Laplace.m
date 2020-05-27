%% Laplace-Op.
function [A] = Num_1_Wirbelstroemung_GUI_Laplace(nx,ny)
A = zeros(nx*ny,nx*ny);

for m = 1:1:nx*ny
    A(m,m) = -4;
    if mod(m,ny) == 1
        A(m,m+1) = 1;
        A(m+1,m) = 1;
    elseif mod(m,ny) == 0
        A(m,m-1) = 1;
        A(m-1,m) = 1;
    else
        A(m,m-1) = 1;
        A(m,m+1) = 1;
    end
    if m <= (nx-1)*ny
        A(m,m+ny) = 1;
        A(m+ny,m) = 1;
    end
end
end