% Verfahrensvergleich
% Omega
% Geschw./Partikel
% Verlust

function [] = Num_1_Wirbelstroemung_GUI_01(h,t,omega,video_jn,video_name)
%% Haupteil

% Gitteraufbau
x = h:h:1-h;
y = h:h:1-h;
nx = length(x);
ny = length(y);
[X,Y] = meshgrid(x,y);
X_p1_0 = [10*h;10*h]; % Anfangspunkt der Partikel
X_p2_0 = [16*h;15*h]; % Anfangspunkt der Partikel
X_p3_0 = [4*h;15*h];  % Anfangspunkt der Partikel

Omega_0 = omega(X,Y);
Omega_0_Sum = sum(Omega_0,'all');

nue = 0;

%Eu: 1
CFL_Eu = 0.7;
%RK: 2
CFL_RK = 1.2;
%AB: 3
CFL_AB = 0.35;

[OMEGA_Eu,U_Eu,V_Eu,T_Eu,n_Eu,X_p1_Eu,X_p2_Eu,X_p3_Eu] = Berechnung(Omega_0,nx,ny,h,t,X_p1_0,X_p2_0,X_p3_0,CFL_Eu,1);
[OMEGA_RK,U_RK,V_RK,T_RK,n_RK,X_p1_RK,X_p2_RK,X_p3_RK] = Berechnung(Omega_0,nx,ny,h,t,X_p1_0,X_p2_0,X_p3_0,CFL_RK,2);
[OMEGA_AB,U_AB,V_AB,T_AB,n_AB,X_p1_AB,X_p2_AB,X_p3_AB] = Berechnung(Omega_0,nx,ny,h,t,X_p1_0,X_p2_0,X_p3_0,CFL_AB,3);

%% Plot
F = figure('name','Plot 1','units','normalized','outerposition',[0 0 1 1]);

if video_jn == 1
    Video = VideoWriter([video_name,'.avi']);
    Video.FrameRate = 13;
    open(Video)
end

% Eu
for n = 1:1:n_Eu
    subplot(3,3,1)
    surf(X,Y,OMEGA_Eu(:,:,n))
    shading interp
    view(2)
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'expl. Euler';['(h = ',num2str(h),', CFL = ',num2str(CFL_Eu),', \nu = ',num2str(nue),')'];'\omega'})
    
    subplot(3,3,4)
    quiver(X,Y,U_Eu(:,:,n),V_Eu(:,:,n))
    hold on
    plot(X_p1_Eu(1,1,1),X_p1_Eu(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_Eu(1,1,1),X_p2_Eu(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_Eu(1,1,1),X_p3_Eu(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_Eu(1,1,k),X_p1_Eu(2,1,k),'.','Color','k')
        plot(X_p2_Eu(1,1,k),X_p2_Eu(2,1,k),'.','Color','k')
        plot(X_p3_Eu(1,1,k),X_p3_Eu(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,3,7)
    NR_Eu = sum(OMEGA_Eu(:,:,n),'all')/Omega_0_Sum;
    plot(T_Eu(:,:,n),NR_Eu,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_Eu
        plot([T_Eu(:,:,1) T_Eu(:,:,n)],[NR_Eu NR_Eu],'r')
        text(0.5,NR_Eu+h,[num2str(round(NR_Eu*1000)/10),'%'])
        text(0.5,NR_Eu-1*h,['n = ',num2str(n_Eu)])
    end
    title('$\omega/\omega_0 - t$','interpreter','latex')
    drawnow
    if video_jn == 1
        frame = getframe(gcf);
        writeVideo(Video,frame);
    end
end

% RK
for n = 1:1:n_RK
    subplot(3,3,2)
    surf(X,Y,OMEGA_RK(:,:,n))
    shading interp
    view(2)
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'Runge-Kutta-4';['(h = ',num2str(h),', CFL = ',num2str(CFL_RK),', \nu = ',num2str(nue),')'];'\omega'})
    
    subplot(3,3,5)
    quiver(X,Y,U_RK(:,:,n),V_RK(:,:,n))
    daspect([1 1 1])
    hold on
    plot(X_p1_RK(1,1,1),X_p1_RK(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_RK(1,1,1),X_p2_RK(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_RK(1,1,1),X_p3_RK(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_RK(1,1,k),X_p1_RK(2,1,k),'.','Color','k')
        plot(X_p2_RK(1,1,k),X_p2_RK(2,1,k),'.','Color','k')
        plot(X_p3_RK(1,1,k),X_p3_RK(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,3,8)
    NR_RK = sum(OMEGA_RK(:,:,n),'all')/Omega_0_Sum;
    plot(T_RK(:,:,n),NR_RK,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_RK
        plot([T_RK(:,:,1) T_RK(:,:,n)],[NR_RK NR_RK],'r')
        text(0.5,NR_RK+h,[num2str(round(NR_RK*1000)/10),'%'])
        text(0.5,NR_RK-1*h,['n = ',num2str(n_RK)])
    end
    title('$\omega/\omega_0 - t$','interpreter','latex')
    drawnow
    if video_jn == 1
        frame = getframe(gcf);
        writeVideo(Video,frame);
    end
end

% AB
for n = 1:1:n_AB
    subplot(3,3,3)
    surf(X,Y,OMEGA_AB(:,:,n))
    shading interp
    view(2)
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    title({'Adams-Bashforth';['(h = ',num2str(h),', CFL = ',num2str(CFL_AB),', \nu = ',num2str(nue),')'];'\omega'})
    
    subplot(3,3,6)
    quiver(X,Y,U_AB(:,:,n),V_AB(:,:,n))
    daspect([1 1 1])
    hold on
    plot(X_p1_AB(1,1,1),X_p1_AB(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p2_AB(1,1,1),X_p2_AB(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    plot(X_p3_AB(1,1,1),X_p3_AB(2,1,1),'x','MarkerSize',10,'LineWidth',2,'Color','r')
    
    for k = 1:1:n
        plot(X_p1_AB(1,1,k),X_p1_AB(2,1,k),'.','Color','k')
        plot(X_p2_AB(1,1,k),X_p2_AB(2,1,k),'.','Color','k')
        plot(X_p3_AB(1,1,k),X_p3_AB(2,1,k),'.','Color','k')
    end
    xlim([0 1])
    ylim([0 1])
    xticks(0:0.2:1)
    yticks(0:0.2:1)
    daspect([1 1 1])
    hold off
    title('Geschw. / Partikel')
    
    subplot(3,3,9)
    NR_AB = sum(OMEGA_AB(:,:,n),'all')/Omega_0_Sum;
    plot(T_AB(:,:,n),NR_AB,'*','Color','k')
    ylim([0, 1.1])
    xlim([0, t])
    grid on
    hold on
    if n == n_AB
        plot([T_AB(:,:,1) T_AB(:,:,n)],[NR_AB NR_AB],'r')
        text(0.5,NR_AB+h,[num2str(round(NR_AB*1000)/10),'%'])
        text(0.5,NR_AB-1*h,['n = ',num2str(n_AB)])
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
function [OMEGA,U,V,T,n,X_p1,X_p2,X_p3] = Berechnung(Omega_0,nx,ny,h,t,X_p1_0,X_p2_0,X_p3_0,CFL,F)
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
    
    Psi_v = -A\(Omega_v*h^2);        % als Vektor (ny*nx)x(1)
    Psi = reshape(Psi_v,ny,nx);      % als Matrix (ny)x(nx)
    DXPsi = reshape(DX*Psi_v,ny,nx); % Gradient x
    DYPsi = reshape(DY*Psi_v,ny,nx); % Gradient y
    u = DYPsi;
    v = -DXPsi;
    
    % 1. expl. Euler
    if F == 1
        [dt] = Num_1_Wirbelstroemung_GUI_dt(u,v,h,CFL);
        [d_Omega] = Num_1_Wirbelstroemung_GUI_UpWind(u,v,Omega,h);
        [Omega_neu] = Num_1_Wirbelstroemung_GUI_Expl_Euler(dt,Omega,d_Omega);
    % 2. Runge-Kutta-4
    elseif F == 2
        [dt] = Num_1_Wirbelstroemung_GUI_dt(u,v,h,CFL);
        [Omega_neu] = Num_1_Wirbelstroemung_GUI_Runge_Kutta_4(dt,Omega,u,v,h);
    % 3. Adams-Bashforth
    elseif F == 3
        if n == 1
            Omega_neu = Omega;
            [dt] = Num_1_Wirbelstroemung_GUI_dt(u,v,h,CFL);
        else
            [dt] = Num_1_Wirbelstroemung_GUI_dt(u,v,h,CFL);
            [Omega_neu] = Num_1_Wirbelstroemung_GUI_Adams_Baschforth(dt,Omega,u,v,OMEGA(:,:,n-1),U(:,:,n-1),V(:,:,n-1),h);
        end
    end
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