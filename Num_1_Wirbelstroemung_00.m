%% Start
clear all
clc
close gcf

%% Die fuenf Hauptfunction:

%Verfahrensvergleich()
%Reibung()
%Wandbew()
%EinAusstr()
%Verbesserung()

%% 1. Verfahrensvergleich
function [] = Verfahrensvergleich()
h = 0.05;
t = 3;
video_jn = 0; % 0: ohne Video, 1: mit Video
video_name = 'num_1_Wirbelstroemung_GUI_video_01';
omega = @(x,y)sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2));
Num_1_Wirbelstroemung_GUI_01(h,t,omega,video_jn,video_name)
end

%% 2.
function [] = Reibung()
h = 0.05;
t = 3;
nue1 = 0;
nue2 = 10^(-6);
nue3 = 10^(-5);
video_jn = 0; % 0: ohne Video, 1: mit Video
video_name = 'num_1_Wirbelstroemung_GUI_video_02';
omega = @(x,y)sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2));
Num_1_Wirbelstroemung_GUI_02(h,t,nue1,nue2,nue3,omega,video_jn,video_name)
end

%% 3.
function [] = Wandbew()
h = 0.05;
n_bis = 75;
% nach Uhrzeigersinn: +
u_w_L = 0.5;
u_w_R = -0.5;
u_w_O = 0;
u_w_U = 0;
video_jn = 0; % 0: ohne Video, 1: mit Video
video_name = 'num_1_Wirbelstroemung_GUI_video_03';
Num_1_Wirbelstroemung_GUI_03(h,n_bis,u_w_L,u_w_R,u_w_O,u_w_U,video_jn,video_name)
end

%% 4.
function [] = EinAusstr()
h = 0.05;
t = 3;
% nach Innen: +
% nach Aussen: -
% Summe muss 0 sein!
u_L = 0.6;
u_R = 0.3;
u_O = -0.2;
u_U = -0.7;
sum_u = u_L+u_R+u_O+u_U;
if abs(sum_u) > 10^(-12)
    warndlg('Summe u muss 0 sein!')
    return
end
video_jn = 0; % 0: ohne Video, 1: mit Video
video_name = 'num_1_Wirbelstroemung_GUI_video_04';
Num_1_Wirbelstroemung_GUI_04(h,t,u_L,u_R,u_U,u_O,video_jn,video_name) % u_O und u_U umgetauscht wegen Reichtung des Plots
end

%% 5.
function [] = Verbesserung()
t = 3;
video_jn = 0; % 0: ohne Video, 1: mit Video
video_name = 'num_1_Wirbelstroemung_GUI_video_05';
Num_1_Wirbelstroemung_GUI_05(t,video_jn,video_name)
end