% expl. Euler mit Ein-/Ausstroemung
% Geschw./Partikel
% Wandgeschwindigkeit

function [] = Num_1_Wirbelstroemung_GUI_05(t,video_jn,video_name)
%% Hauptteil

% Ein/Aus Geschw:  Num_1_Wirbelstroemung_GUI_Geschw_EinAus(...)
% u_EA_L = U_EA(1,1);
% u_EA_R = U_EA(2,1);
% u_EA_O = U_EA(3,1);
% u_EA_U = U_EA(4,1);
U_EA = [0;0;0;0];

% kin. Viskositat: Num_1_Wirbelstroemung_GUI_Reibung(...)
nue = 10^(-6);

% Wand Geschw:     Num_1_Wirbelstroemung_P07_Omega_Rand(...)
% u_Wand_L = U_Wand(1,1);
% u_Wand_R = U_Wand(2,1);
% u_Wand_O = U_Wand(3,1);
% u_Wand_U = U_Wand(4,1);
U_Wand = [0;0;0;0];

h1 = 0.05;
h2 = h1;
h3 = 0.025;
h4 = h1;
CFL1 = 0.5;
CFL2 = 0.25;
CFL3 = CFL1;
CFL4 = CFL1;

[OMEGA_Eu1,U_Eu1,V_Eu1,T_Eu1,n_Eu1,X_p1_Eu1,X_p2_Eu1,X_p3_Eu1,Omega_0_Sum_Eu1,X_Eu1,Y_Eu1] = Berechnung(U_EA,nue,U_Wand,h1,CFL1,t,1);
[OMEGA_Eu2,U_Eu2,V_Eu2,T_Eu2,n_Eu2,X_p1_Eu2,X_p2_Eu2,X_p3_Eu2,Omega_0_Sum_Eu2,X_Eu2,Y_Eu2] = Berechnung(U_EA,nue,U_Wand,h2,CFL2,t,1);
[OMEGA_Eu3,U_Eu3,V_Eu3,T_Eu3,n_Eu3,X_p1_Eu3,X_p2_Eu3,X_p3_Eu3,Omega_0_Sum_Eu3,X_Eu3,Y_Eu3] = Berechnung(U_EA,nue,U_Wand,h3,CFL3,t,1);
[OMEGA_Eu4,U_Eu4,V_Eu4,T_Eu4,n_Eu4,X_p1_Eu4,X_p2_Eu4,X_p3_Eu4,Omega_0_Sum_Eu4,X_Eu4,Y_Eu4] = Berechnung(U_EA,nue,U_Wand,h4,CFL4,t,2);

%% Plotteil
F = figure('name','Plot 2','units','normalized','outerposition',[0 0 1 1]);

if video_jn == 1
    Video = VideoWriter([video_name,'.avi']);
    Video.FrameRate = 13;
    open(Video)
end

% 1. Eu
for n = 1:1:n_Eu1
    subplot(3,4,1)
    surf(X_Eu1,Y_Eu1,OMEGA_Eu1(:,:,n))
    shading interp
    view(2)
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'expl. Euler';['(h = ',num2str(h1),', CFL = ',num2str(CFL1),', UDS-1.)'];'\omega'})
    
    subplot(3,4,5)
    quiver(X_Eu1,Y_Eu1,U_Eu1(:,:,n),V_Eu1(:,:,n))
    hold on
    plot(X_p1_Eu1(1,1,1),X_p1_Eu1(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_Eu1(1,1,1),X_p2_Eu1(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_Eu1(1,1,1),X_p3_Eu1(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_Eu1(1,1,k),X_p1_Eu1(2,1,k),'.','Color','k')
        plot(X_p2_Eu1(1,1,k),X_p2_Eu1(2,1,k),'.','Color','k')
        plot(X_p3_Eu1(1,1,k),X_p3_Eu1(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,4,9)
    NR_Eu1 = sum(OMEGA_Eu1(:,:,n),'all')/Omega_0_Sum_Eu1;
    plot(T_Eu1(:,:,n),NR_Eu1,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_Eu1
        plot([T_Eu1(:,:,1) T_Eu1(:,:,n)],[NR_Eu1 NR_Eu1],'r')
        text(0.5,NR_Eu1+0.05,[num2str(round(NR_Eu1*1000)/10),'%'])
        text(0.5,NR_Eu1-0.05,['n = ',num2str(n_Eu1)])
    end
    title('$\omega/\omega_0 - t$','interpreter','latex')
    
    drawnow
    if video_jn == 1
        frame = getframe(gcf);
        writeVideo(Video,frame);
    end
end

% 2. Eu
for n = 1:1:n_Eu2
    subplot(3,4,2)
    surf(X_Eu2,Y_Eu2,OMEGA_Eu2(:,:,n))
    shading interp
    view(2)
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'expl. Euler';['(h = ',num2str(h2),', CFL = ',num2str(CFL2),', UDS-1.)'];'\omega'})
    
    subplot(3,4,6)
    quiver(X_Eu2,Y_Eu2,U_Eu2(:,:,n),V_Eu2(:,:,n))
    hold on
    plot(X_p1_Eu2(1,1,1),X_p1_Eu2(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_Eu2(1,1,1),X_p2_Eu2(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_Eu2(1,1,1),X_p3_Eu2(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_Eu2(1,1,k),X_p1_Eu2(2,1,k),'.','Color','k')
        plot(X_p2_Eu2(1,1,k),X_p2_Eu2(2,1,k),'.','Color','k')
        plot(X_p3_Eu2(1,1,k),X_p3_Eu2(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,4,10)
    NR_Eu2 = sum(OMEGA_Eu2(:,:,n),'all')/Omega_0_Sum_Eu2;
    plot(T_Eu2(:,:,n),NR_Eu2,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_Eu2
        plot([T_Eu2(:,:,1) T_Eu2(:,:,n)],[NR_Eu2 NR_Eu2],'r')
        text(0.5,NR_Eu2+0.05,[num2str(round(NR_Eu2*1000)/10),'%'])
        text(0.5,NR_Eu2-0.05,['n = ',num2str(n_Eu2)])
    end
    title('$\omega/\omega_0 - t$','interpreter','latex')
    
    drawnow
   if video_jn == 1
        frame = getframe(gcf);
        writeVideo(Video,frame);
    end
end

% 3. Eu
for n = 1:1:n_Eu3
    subplot(3,4,3)
    surf(X_Eu3,Y_Eu3,OMEGA_Eu3(:,:,n))
    shading interp
    view(2)
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'expl. Euler';['(h = ',num2str(h3),', CFL = ',num2str(CFL3),', UDS-1.)'];'\omega'})
    
    subplot(3,4,7)
    quiver(X_Eu3,Y_Eu3,U_Eu3(:,:,n),V_Eu3(:,:,n))
    hold on
    plot(X_p1_Eu3(1,1,1),X_p1_Eu3(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_Eu3(1,1,1),X_p2_Eu3(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_Eu3(1,1,1),X_p3_Eu3(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_Eu3(1,1,k),X_p1_Eu3(2,1,k),'.','Color','k')
        plot(X_p2_Eu3(1,1,k),X_p2_Eu3(2,1,k),'.','Color','k')
        plot(X_p3_Eu3(1,1,k),X_p3_Eu3(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,4,11)
    NR_Eu3 = sum(OMEGA_Eu3(:,:,n),'all')/Omega_0_Sum_Eu3;
    plot(T_Eu3(:,:,n),NR_Eu3,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_Eu3
        plot([T_Eu3(:,:,1) T_Eu3(:,:,n)],[NR_Eu3 NR_Eu3],'r')
        text(0.5,NR_Eu3+0.05,[num2str(round(NR_Eu3*1000)/10),'%'])
        text(0.5,NR_Eu3-0.05,['n = ',num2str(n_Eu3)])
    end
    title('$\omega/\omega_0 - t$','interpreter','latex')
    
    drawnow
   if video_jn == 1
        frame = getframe(gcf);
        writeVideo(Video,frame);
    end
end

% 4. Eu
for n = 1:1:n_Eu4
    subplot(3,4,4)
    surf(X_Eu4,Y_Eu4,OMEGA_Eu4(:,:,n))
    shading interp
    view(2)
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'expl. Euler';['(h = ',num2str(h4),', CFL = ',num2str(CFL4),', UDS-2.)'];'\omega'})
    
    subplot(3,4,8)
    quiver(X_Eu4,Y_Eu4,U_Eu4(:,:,n),V_Eu4(:,:,n))
    hold on
    plot(X_p1_Eu4(1,1,1),X_p1_Eu4(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_Eu4(1,1,1),X_p2_Eu4(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_Eu4(1,1,1),X_p3_Eu4(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_Eu4(1,1,k),X_p1_Eu4(2,1,k),'.','Color','k')
        plot(X_p2_Eu4(1,1,k),X_p2_Eu4(2,1,k),'.','Color','k')
        plot(X_p3_Eu4(1,1,k),X_p3_Eu4(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,4,12)
    NR_Eu4 = sum(OMEGA_Eu4(:,:,n),'all')/Omega_0_Sum_Eu4;
    plot(T_Eu4(:,:,n),NR_Eu4,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_Eu4
        plot([T_Eu4(:,:,1) T_Eu4(:,:,n)],[NR_Eu4 NR_Eu4],'r')
        text(0.5,NR_Eu4-0.05,[num2str(round(NR_Eu4*1000)/10),'%'])
        text(0.5,NR_Eu4-0.15,['n = ',num2str(n_Eu4)])
    end
    title('$\omega/\omega_0 - t$','interpreter','latex')
    
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
function [OMEGA,U,V,T,n,X_p1,X_p2,X_p3,Omega_0_Sum,X,Y] = Berechnung(U_EA,nue,U_Wand,h,CFL,t,UDS)
x = h:h:1-h;
y = h:h:1-h;
nx = length(x);
ny = length(y);
[X,Y] = meshgrid(x,y);
X_p1_0 = [((nx-1)/2+1)*h;((ny-1)/2+1)*h];         % Anfangspunkt der Partikel
X_p2_0 = [((nx-1)/2+1)/2*1*h;((ny-1)/2+1)/2*3*h]; % Anfangspunkt der Partikel
X_p3_0 = [((nx-1)/2+1)/2*3*h;((ny-1)/2+1)/2*1*h]; % Anfangspunkt der Partikel

omega = @(x,y)sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2));

Omega_0 = omega(X,Y);
Omega_0_Sum = sum(Omega_0,'all');


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
    
    [A] = Num_1_Wirbelstroemung_P07_Laplace(nx,ny);
    [DX,DY] = Num_1_Wirbelstroemung_P07_Nabla(nx,ny,h);
    
    [Psi_Rand] = Num_1_Wirbelstroemung_P07_Psi_Rand(U_EA,nx,ny,h);        % als Matrix (n+2)x(n+2)
    [Psi_Rand_v] = Num_1_Wirbelstroemung_P07_Rand_Trafo(Psi_Rand); % als Vektor (ny*nx)x(1)
    
    Psi_v = -A\(Omega_v*h^2+Psi_Rand_v); % als Vektor (ny*nx)x(1)
    Psi = reshape(Psi_v,ny,nx);          % als Matrix (ny)x(nx)
    DXPsi = reshape(DX*Psi_v,ny,nx);     % Gradient x
    DYPsi = reshape(DY*Psi_v,ny,nx);     % Gradient y
    u = DYPsi;
    v = -DXPsi;
    
    [dt] = Num_1_Wirbelstroemung_P07_dt(u,v,h,CFL);
    if UDS == 1
        [d_Omega] = Num_1_Wirbelstroemung_P07_UpWind(u,v,Omega,h);
    elseif UDS == 2
        [d_Omega] = Num_1_Wirbelstroemung_P07_UpWind_2(u,v,Omega,h);
    end
    [Reibung] = Num_1_Wirbelstroemung_P07_Reibung(nue,U_Wand,Omega,Psi,Psi_Rand,nx,ny,h);
    d_Omega = d_Omega+Reibung;
    [Omega_neu] = Num_1_Wirbelstroemung_P07_Expl_Euler(dt,Omega,d_Omega);
    [X_p1_neu] = Num_1_Wirbelstroemung_P07_Partikel(X_p1_0,u,v,h,dt);
    [X_p2_neu] = Num_1_Wirbelstroemung_P07_Partikel(X_p2_0,u,v,h,dt);
    [X_p3_neu] = Num_1_Wirbelstroemung_P07_Partikel(X_p3_0,u,v,h,dt);
    
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