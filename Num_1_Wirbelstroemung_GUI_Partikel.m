%% Partikel
function [X_p_neu] = Num_1_Wirbelstroemung_GUI_Partikel(X_p_0,u,v,h,dt)
x = X_p_0(1,1);
y = X_p_0(2,1);
[ny,nx] = size(u);

if x > (nx-1)*h
    x_neu = x;
    y_neu = y;
elseif y > (ny-1)*h
    x_neu = x;
    y_neu = y;
elseif x < h
    x_neu = x;
    y_neu = y;
elseif y < h
    x_neu = x;
    y_neu = y;
elseif mod(x,h) == 0 && mod(y,h) == 0
    n = fix(x/h);
    m = fix(y/h);
    x_neu = x+dt*u(m,n);
    y_neu = y+dt*v(m,n);
elseif mod(x,h) == 0 && mod(y,h) ~= 0
    n = fix(x/h);
    m = fix(y/h);
    a = x-n*h;
    v_p = (h-a)/h*v(m,n)+a/h*v(m,n+1);
    x_neu = x+dt*u(m,n);
    y_neu = y+dt*v_p;
elseif mod(x,h) ~= 0 && mod(y,h) == 0
    n = fix(x/h);
    m = fix(y/h);
    a = x-n*h;
    u_p = (h-a)/h*v(m,n)+a/h*v(m,n+1);
    x_neu = x+dt*u_p;
    y_neu = y+dt*v(m,n);
else
    n = fix(x/h);
    m = fix(y/h);
    a = x-n*h;
    b = h-(y-m*h);
    u_p = (h-b)/h*((h-a)/h*u(m+1,n)+a/h*u(m+1,n+1))+b/h*((h-a)/h*u(m,n)+a/h*u(m,n+1));
    v_p = (h-b)/h*((h-a)/h*v(m+1,n)+a/h*v(m+1,n+1))+b/h*((h-a)/h*v(m,n)+a/h*v(m,n+1));
    x_neu = x+dt*u_p;
    y_neu = y+dt*v_p;
end
X_p_neu = [x_neu;y_neu];
end