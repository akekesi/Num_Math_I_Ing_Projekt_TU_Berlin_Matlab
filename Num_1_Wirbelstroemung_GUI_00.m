function varargout = Num_1_Wirbelstroemung_GUI_00(varargin)
% Num_1_Wirbelstroemung_GUI_00 MATLAB code for Num_1_Wirbelstroemung_GUI_00.fig
%      Num_1_Wirbelstroemung_GUI_00, by itself, creates a new Num_1_Wirbelstroemung_GUI_00 or raises the existing
%      singleton*.
%
%      H = Num_1_Wirbelstroemung_GUI_00 returns the handle to a new Num_1_Wirbelstroemung_GUI_00 or the handle to
%      the existing singleton*.
%
%      Num_1_Wirbelstroemung_GUI_00('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Num_1_Wirbelstroemung_GUI_00.M with the given input arguments.
%
%      Num_1_Wirbelstroemung_GUI_00('Property','Value',...) creates a new Num_1_Wirbelstroemung_GUI_00 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Num_1_Wirbelstroemung_GUI_00_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Num_1_Wirbelstroemung_GUI_00_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Num_1_Wirbelstroemung_GUI_00

% Last Modified by GUIDE v2.5 25-Apr-2020 02:14:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Num_1_Wirbelstroemung_GUI_00_OpeningFcn, ...
                   'gui_OutputFcn',  @Num_1_Wirbelstroemung_GUI_00_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Num_1_Wirbelstroemung_GUI_00 is made visible.
function Num_1_Wirbelstroemung_GUI_00_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Num_1_Wirbelstroemung_GUI_00 (see VARARGIN)

% Choose default command line output for Num_1_Wirbelstroemung_GUI_00
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Num_1_Wirbelstroemung_GUI_00 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear all
clc

% --- Outputs from this function are returned to the command line.
function varargout = Num_1_Wirbelstroemung_GUI_00_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_plot1.
function pb_plot1_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plot1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = str2double(get(handles.edit1_gitterabstand,'string'));
t = str2double(get(handles.edit1_zeit,'string'));
video_jn = get(handles.rb_video,'value');
video_name = get(handles.edit_video,'string');
omega = get(get(handles.uibuttongroup1_omega,'SelectedObject'),'string');
if omega == "Omega Test 1"
    omega = 'sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2))';
elseif omega == "Omega Test 2"
    omega = 'sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.70).^2+(y-0.70).^2))+sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2))';
else
    omega = get(handles.edit_omeganeu,'string');
    if omega == ""
        warndlg('Bitte neue Omega-Funktion eingeben!')
        return
    end
end
omega = str2func(['@(x,y)',omega]);
Num_1_Wirbelstroemung_GUI_01(h,t,omega,video_jn,video_name)

% --- Executes on button press in pb_plot2.
function pb_plot2_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plot2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = str2double(get(handles.edit2_gitterabstand,'string'));
t = str2double(get(handles.edit2_zeit,'string'));
nue1 = str2double(get(handles.edit_reibung1,'string'));
nue2 = str2double(get(handles.edit_reibung2,'string'));
nue3 = str2double(get(handles.edit_reibung3,'string'));
video_jn = get(handles.rb_video,'value');
video_name = get(handles.edit_video,'string');
omega = get(get(handles.uibuttongroup2_omega,'SelectedObject'),'string');
if omega == "Omega Test 1"
    omega = 'sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2))';
elseif omega == "Omega Test 2"
    omega = 'sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.70).^2+(y-0.70).^2))+sin(pi*x).*sin(pi*y).*6.*exp(-50.*((x-0.30).^2+(y-0.30).^2))';
end
omega = str2func(['@(x,y)',omega]);
Num_1_Wirbelstroemung_GUI_02(h,t,nue1,nue2,nue3,omega,video_jn,video_name)

% --- Executes on button press in pb_plot3.
function pb_plot3_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plot3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = str2double(get(handles.edit3_gitterabstand,'string'));
n_bis = str2double(get(handles.edit3_schritte,'string'));
video_jn = get(handles.rb_video,'value');
video_name = get(handles.edit_video,'string');
u_w_L = str2double(get(handles.edit_w_L,'string'));
u_w_R = str2double(get(handles.edit_w_R,'string'));
u_w_O = str2double(get(handles.edit_w_O,'string'));
u_w_U = str2double(get(handles.edit_w_U,'string'));
Num_1_Wirbelstroemung_GUI_03(h,n_bis,u_w_L,u_w_R,u_w_O,u_w_U,video_jn,video_name)

% --- Executes on button press in pb_plot4.
function pb_plot4_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plot4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = str2double(get(handles.edit4_gitterabstand,'string'));
t = str2double(get(handles.edit4_zeit,'string'));
video_jn = get(handles.rb_video,'value');
video_name = get(handles.edit_video,'string');
u_L = str2double(get(handles.edit_u_L,'string'));
u_R = str2double(get(handles.edit_u_R,'string'));
u_O = str2double(get(handles.edit_u_U,'string')); % umtauschen wegen Richtung des Plots
u_U = str2double(get(handles.edit_u_O,'string')); % umtauschen wegen Richtung des Plots
sum_u = u_L+u_R+u_O+u_U;
if abs(sum_u) > 10^(-12)
    warndlg('Summe u muss 0 sein!')
    return
end
Num_1_Wirbelstroemung_GUI_04(h,t,u_L,u_R,u_O,u_U,video_jn,video_name)

% --- Executes on button press in pb_plot5.
function pb_plot5_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plot5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = str2double(get(handles.edit5_zeit,'string'));
video_jn = get(handles.rb_video,'value');
video_name = get(handles.edit_video,'string');
Num_1_Wirbelstroemung_GUI_05(t,video_jn,video_name)

% --- Executes on button press in pb_close.
function pb_close_Callback(hObject, eventdata, handles)
% hObject    handle to pb_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


function edit1_gitterabstand_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_gitterabstand as text
%        str2double(get(hObject,'String')) returns contents of edit1_gitterabstand as a double


% --- Executes during object creation, after setting all properties.
function edit1_gitterabstand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_zeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_zeit as text
%        str2double(get(hObject,'String')) returns contents of edit1_zeit as a double


% --- Executes during object creation, after setting all properties.
function edit1_zeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_funktion_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_funktion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_funktion as text
%        str2double(get(hObject,'String')) returns contents of edit1_funktion as a double


% --- Executes during object creation, after setting all properties.
function edit1_funktion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_funktion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_u_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_u_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_u_L as text
%        str2double(get(hObject,'String')) returns contents of edit_u_L as a double


% --- Executes during object creation, after setting all properties.
function edit_u_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_u_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_u_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_u_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_u_R as text
%        str2double(get(hObject,'String')) returns contents of edit_u_R as a double


% --- Executes during object creation, after setting all properties.
function edit_u_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_u_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_u_O_Callback(hObject, eventdata, handles)
% hObject    handle to edit_u_O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_u_O as text
%        str2double(get(hObject,'String')) returns contents of edit_u_O as a double


% --- Executes during object creation, after setting all properties.
function edit_u_O_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_u_O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_u_U_Callback(hObject, eventdata, handles)
% hObject    handle to edit_u_U (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_u_U as text
%        str2double(get(hObject,'String')) returns contents of edit_u_U as a double


% --- Executes during object creation, after setting all properties.
function edit_u_U_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_u_U (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in rb_video.
function rb_video_Callback(hObject, eventdata, handles)
% hObject    handle to rb_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_video



function edit_video_Callback(hObject, eventdata, handles)
% hObject    handle to edit_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_video as text
%        str2double(get(hObject,'String')) returns contents of edit_video as a double


% --- Executes during object creation, after setting all properties.
function edit_video_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_omeganeu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_omeganeu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_omeganeu as text
%        str2double(get(hObject,'String')) returns contents of edit_omeganeu as a double


% --- Executes during object creation, after setting all properties.
function edit_omeganeu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_omeganeu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_gitterabstand_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_gitterabstand as text
%        str2double(get(hObject,'String')) returns contents of edit2_gitterabstand as a double


% --- Executes during object creation, after setting all properties.
function edit2_gitterabstand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_zeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_gitterabstand as text
%        str2double(get(hObject,'String')) returns contents of edit2_gitterabstand as a double


% --- Executes during object creation, after setting all properties.
function edit2_zeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reibung1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reibung1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reibung1 as text
%        str2double(get(hObject,'String')) returns contents of edit_reibung1 as a double


% --- Executes during object creation, after setting all properties.
function edit_reibung1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reibung1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reibung2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reibung2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reibung2 as text
%        str2double(get(hObject,'String')) returns contents of edit_reibung2 as a double


% --- Executes during object creation, after setting all properties.
function edit_reibung2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reibung2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reibung3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reibung3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reibung3 as text
%        str2double(get(hObject,'String')) returns contents of edit_reibung3 as a double


% --- Executes during object creation, after setting all properties.
function edit_reibung3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reibung3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_zeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_zeit as text
%        str2double(get(hObject,'String')) returns contents of edit4_zeit as a double


% --- Executes during object creation, after setting all properties.
function edit4_zeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_gitterabstand_Callback(hObject, eventdata, handles)
% hObject    handle to edit4_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4_gitterabstand as text
%        str2double(get(hObject,'String')) returns contents of edit4_gitterabstand as a double


% --- Executes during object creation, after setting all properties.
function edit4_gitterabstand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_schritte_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_schritte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_schritte as text
%        str2double(get(hObject,'String')) returns contents of edit3_schritte as a double


% --- Executes during object creation, after setting all properties.
function edit3_schritte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_schritte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_gitterabstand_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_gitterabstand as text
%        str2double(get(hObject,'String')) returns contents of edit3_gitterabstand as a double


% --- Executes during object creation, after setting all properties.
function edit3_gitterabstand_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_gitterabstand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_L as text
%        str2double(get(hObject,'String')) returns contents of edit_w_L as a double


% --- Executes during object creation, after setting all properties.
function edit_w_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_R as text
%        str2double(get(hObject,'String')) returns contents of edit_w_R as a double


% --- Executes during object creation, after setting all properties.
function edit_w_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_O_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_O as text
%        str2double(get(hObject,'String')) returns contents of edit_w_O as a double


% --- Executes during object creation, after setting all properties.
function edit_w_O_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_U_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w_U (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w_U as text
%        str2double(get(hObject,'String')) returns contents of edit_w_U as a double


% --- Executes during object creation, after setting all properties.
function edit_w_U_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w_U (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_zeit_Callback(hObject, eventdata, handles)
% hObject    handle to edit5_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5_zeit as text
%        str2double(get(hObject,'String')) returns contents of edit5_zeit as a double


% --- Executes during object creation, after setting all properties.
function edit5_zeit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5_zeit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
