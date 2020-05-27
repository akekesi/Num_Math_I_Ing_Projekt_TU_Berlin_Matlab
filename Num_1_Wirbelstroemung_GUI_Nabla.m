%% Nabla-Op.
function [DX,DY] = Num_1_Wirbelstroemung_GUI_Nabla(nx,ny,h)
DX = zeros(ny*nx,ny*nx);
DY = zeros(ny*nx,ny*nx);

for m = 1:1:ny*nx
    if m <= ny
        DX(m,m) = -3;
        DX(m,m+ny) = 4;
        DX(m,m+2*ny) = -1;
    elseif m > (nx-1)*ny
        DX(m,m) = 3;
        DX(m,m-ny) = -4;
        DX(m,m-2*ny) = 1;
    else
        DX(m,m-ny) = -1;
        DX(m,m+ny) = 1;
    end
end
for m = 1:1:ny*nx
    if mod(m,ny) ==1
        DY(m,m) = -3;
        DY(m,m+1) = 4;
        DY(m,m+2) = -1;
    elseif mod(m,ny) == 0
        DY(m,m) = 3;
        DY(m,m-1) = -4;
        DY(m,m-2) = 1;
    else
        DY(m,m-1) = -1;
        DY(m,m+1) = 1;
    end
end
DX = DX/2/h;
DY = DY/2/h;
end