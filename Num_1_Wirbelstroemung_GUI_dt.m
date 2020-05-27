%% delta t
function [dt] = Num_1_Wirbelstroemung_GUI_dt(u,v,h,CFL)
[ny,nx] = size(u);
if norm(reshape(u,ny*nx,1),inf) == 0 || norm(reshape(v,ny*nx,1),inf) == 0
    dt = 10^-3;
else
    dtx = CFL*h/norm(reshape(u,ny*nx,1),inf);
    dty = CFL*h/norm(reshape(v,ny*nx,1),inf);
    dt = min(dtx,dty);
end
end