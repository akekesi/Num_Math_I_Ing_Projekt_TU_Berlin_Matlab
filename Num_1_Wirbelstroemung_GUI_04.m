% expl. Euler mit Ein-/Ausstroemung
% Geschw./Partikel
% Ein-/Ausstroemung

function [] = Num_1_Wirbelstroemung_GUI_04(h,t,u_L,u_R,u_O,u_U,video_jn,video_name)
%% Hauptteil

% Ein/Aus Geschw:  Num_1_Wirbelstroemung_GUI_Geschw_EinAus(...)
% u_L = U_EA(1,1);
% u_R = U_EA(2,1);
% u_O = U_EA(3,1);
% u_U = U_EA(4,1);
x_ea = 0:h:1;
y_ea = x_ea;
nx_ea = length(x_ea);
[X_EA,Y_EA] = meshgrid(x_ea,y_ea);
U_EA = [u_L;-u_R;-u_O;u_U];
[u_EinAus1,v_EinAus1] = Num_1_Wirbelstroemung_GUI_Geschw_EinAus(U_EA,nx_ea,nx_ea);

% kin. Viskositat: Num_1_Wirbelstroemung_GUI_Reibung(...)
nue = 0; % 10^(-6);

% Wand Geschw:     Num_1_Wirbelstroemung_GUI_Omega_Rand(...)
% u_Wand_L = U_Wand(1,1);
% u_Wand_R = U_Wand(2,1);
% u_Wand_O = U_Wand(3,1);
% u_Wand_U = U_Wand(4,1);
U_Wand = [0;0;0;0];

x = h:h:1-h;
y = h:h:1-h;
nx = length(x);
ny = length(y);
[X,Y] = meshgrid(x,y);
X_p1_0 = [1*h;10*h]; % Anfangspunkt der Partikel
X_p2_0 = [1*h;15*h]; % Anfangspunkt der Partikel
X_p3_0 = [1*h;5*h];  % Anfangspunkt der Partikel

omega = @(x,y) zeros(ny,nx);
Omega_0 = omega(X,Y);

[U_Eu1,V_Eu1,n_Eu1,X_p1_Eu1,X_p2_Eu1,X_p3_Eu1] = Berechnung(U_EA,nue,U_Wand,Omega_0,nx,ny,h,t,X_p1_0,X_p2_0,X_p3_0);

%% Plot
F = figure('name','Plot 2','units','normalized','outerposition',[0 0 1 1]);

if video_jn == 1
    Video = VideoWriter([video_name,'.avi']);
    Video.FrameRate = 13;
    open(Video)
end

for n = 1:1:n_Eu1-1
    % Eu1
    subplot(2,1,1)
    quiver(X,Y,U_Eu1(:,:,n),V_Eu1(:,:,n))
    hold on
    plot(X_p1_Eu1(1,1,1),X_p1_Eu1(2,1,1),'x','MarkerSize',15,'LineWidth',2,'Color','r')
    plot(X_p2_Eu1(1,1,1),X_p2_Eu1(2,1,1),'x','MarkerSize',15,'LineWidth',2,'Color','r')
    plot(X_p3_Eu1(1,1,1),X_p3_Eu1(2,1,1),'x','MarkerSize',15,'LineWidth',2,'Color','r')
    for k = 1:1:n
        plot(X_p1_Eu1(1,1,k),X_p1_Eu1(2,1,k),'.','MarkerSize',15,'Color','k')
        plot(X_p2_Eu1(1,1,k),X_p2_Eu1(2,1,k),'.','MarkerSize',15,'Color','k')
        plot(X_p3_Eu1(1,1,k),X_p3_Eu1(2,1,k),'.','MarkerSize',15,'Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')

    subplot(2,1,2)
    quiver(X_EA,Y_EA,u_EinAus1,-v_EinAus1)
    text(0.2,0.5,num2str(U_EA(1,1)))
    text(0.8,0.5,num2str(-U_EA(2,1)))
    text(0.5,0.9,num2str(U_EA(4,1)))  % umtauschen wegen Richtung des Plots
    text(0.5,0.1,num2str(-U_EA(3,1))) % umtauschen wegen Richtung des Plots
    xlim([-0.2 1.2])
    ylim([-0.2 1.2])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    grid on
    daspect([1 1 1])
    title('Ein/Ausstr. am Rand')


    drawnow
    if video_jn == 1
        frame = getframe(gcf);
        writeVideo(Video,frame);
    end
end
if video_jn == 1
    close(Video)
end
end
%% Berechnung
function [U,V,n,X_p1,X_p2,X_p3] = Berechnung(U_EA,nue,U_Wand,Omega_0,nx,ny,h,t,X_p1_0,X_p2_0,X_p3_0)
t_summe = 0;
n = 1; % Schritte bis t

OMEGA = zeros(size(Omega_0)); % 3D Matrix
PSI = zeros(size(Omega_0));   % 3D Matrix
U = zeros(size(Omega_0));     % 3D Matrix
V = zeros(size(Omega_0));     % 3D Matrix
T = zeros(1,1);
X_p1 = zeros(size(X_p1_0));
X_p2 = zeros(size(X_p2_0));
X_p3 = zeros(size(X_p3_0));

while t_summe <= t
    Omega = Omega_0;
    Omega_v = reshape(Omega,ny*nx,1); % als Vektor
    
    [A] = Num_1_Wirbelstroemung_GUI_Laplace(nx,ny);
    [DX,DY] = Num_1_Wirbelstroemung_GUI_Nabla(nx,ny,h);
    
    [Psi_Rand] = Num_1_Wirbelstroemung_GUI_Psi_Rand(U_EA,nx,ny,h);        % als Matrix (n+2)x(n+2)
    [Psi_Rand_v] = Num_1_Wirbelstroemung_GUI_Rand_Trafo(Psi_Rand); % als Vektor (ny*nx)x(1)
    
    Psi_v = -A\(Omega_v*h^2+Psi_Rand_v); % als Vektor (ny*nx)x(1)
    Psi = reshape(Psi_v,ny,nx);          % als Matrix (ny)x(nx)
    DXPsi = reshape(DX*Psi_v,ny,nx);     % Gradient x
    DYPsi = reshape(DY*Psi_v,ny,nx);     % Gradient y
    u = DYPsi;
    v = -DXPsi;
    
    % Euler Verfahren
    CFL = 0.7;
    [dt] = Num_1_Wirbelstroemung_GUI_dt(u,v,h,CFL);
    [d_Omega] = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega,h);
    [Reibung] = Num_1_Wirbelstroemung_GUI_Reibung(nue,U_Wand,Omega,Psi,Psi_Rand,nx,ny,h);
    d_Omega = d_Omega+Reibung;
    [Omega_neu] = Num_1_Wirbelstroemung_GUI_Expl_Euler(dt,Omega,d_Omega);
    
    [X_p1_neu] = Num_1_Wirbelstroemung_GUI_Partikel(X_p1_0,u,v,h,dt);
    [X_p2_neu] = Num_1_Wirbelstroemung_GUI_Partikel(X_p2_0,u,v,h,dt);
    [X_p3_neu] = Num_1_Wirbelstroemung_GUI_Partikel(X_p3_0,u,v,h,dt);
    
    OMEGA(:,:,n) = Omega;
    PSI(:,:,n) = Psi;
    U(:,:,n) = u;
    V(:,:,n) = v;
    T(:,:,n) = t_summe;
    X_p1(:,:,n) = X_p1_0;
    X_p2(:,:,n) = X_p2_0;
    X_p3(:,:,n) = X_p3_0;
    
    t_summe = t_summe + dt;
    n = n + 1;
    Omega_0 = Omega_neu;
    X_p1_0 = X_p1_neu;
    X_p2_0 = X_p2_neu;
    X_p3_0 = X_p3_neu;
end
n = n-1;
end