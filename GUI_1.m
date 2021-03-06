function varargout = GUI_1(varargin)
% GUI_1 M-file for GUI_1.fig
%      GUI_1, by itself, creates a new GUI_1 or raises the existing
%      singleton*.
%
%      H = GUI_1 returns the handle to a new GUI_1 or the handle to
%      the existing singleton*.
%
%      GUI_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_1.M with the given input arguments.
%
%      GUI_1('Property','Value',...) creates a new GUI_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_1

% Last Modified by GUIDE v2.5 22-Jun-2014 17:22:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_1_OutputFcn, ...
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


% --- Executes just before GUI_1 is made visible.
function GUI_1_OpeningFcn(hObject, eventdata, handles, varargin)
%hObject =  stem(zero2negone(bitstr(10)))
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_1 (see VARARGIN)
%axes(handles.axes1);
%x1 = [-3*pi : 0.01 : 3*pi];
%handles.awgn = addnoise(x1);
%handles.noawgn = x1;

global Tb Ts c

Tb=0.07;
Ts=0.0001;
c=Tb/Ts;


 
handles.current_data=0;
handles.randbitstr = 0;
handles.modulated = 0;
handles.demodulated = 0;


% Choose default command line output for GUI_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_modulate.
function button_modulate_Callback(hObject, eventdata, handles)
% hObject    handle to button_modulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%y = mskmod(x,8,[],pi/2);
%plot(y,16);
handles.modulated = mod_test(handles.eyediagram,handles.eyediagram2);
plot (handles.axes4,handles.modulated);
axis(handles.axes4,[-inf,inf,-1.5,1.5]);
grid(handles.axes4);
guidata(hObject,handles);

% --- Executes on button press in button_mod_fig.
function button_mod_fig_Callback(hObject, eventdata, handles)
% hObject    handle to button_mod_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(2)
plot(handles.modulated);
axis([-inf,inf,-1.5,1.5]);
grid on;

% --- Executes on button press in button_demodulate.
function button_demodulate_Callback(hObject, eventdata, handles)
% hObject    handle to button_demodulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%cla;
handles.demodulated = demodulate(handles.modulated_noise);
axes(handles.axes5)
cla(gca);
hold on;
plot(d2a(handles.demodulated));
plot(d2a(handles.randbitstr),'--r');
axis([-inf,inf,-1.5,1.5]);
grid on;
guidata(hObject,handles);

% --- Executes on button press in button_demod_fig.
function button_demod_fig_Callback(hObject, eventdata, handles)
% hObject    handle to button_demod_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(4)
hold on;
plot(d2a(handles.demodulated));
plot(d2a(handles.randbitstr),'--r');
axis([-inf,inf,-1.5,1.5]);
grid on;
hold off;


% --- Executes on button press in button_random.
function button_random_Callback(hObject, eventdata, handles)
% hObject    handle to button_random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.randbitstr = (zero2negone(bitstr(20)));
handles.bitstr = d2a(handles.randbitstr);
[handles.eyediagram,handles.eyediagram2] = eye_diag(handles.randbitstr);
%handles.eyediagram2 = eye_diag2(handles.randbitstr);
[a,b]=demux(handles.randbitstr);
[handles.even,handles.odd]=halfsins(a,b);

plot(handles.axes1,d2a(handles.randbitstr));
axis(handles.axes1,[-inf,inf,-1.5,1.5]);
grid(handles.axes1);
guidata(hObject,handles);


% --- Executes on button press in button_demod_fig.
function button_rand_fig_Callback(hObject, eventdata, handles)
% hObject    handle to button_demod_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(1)
switch handles.str{handles.val}
    
    case 'Bitstream'
        plot(handles.bitstr);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Eyediagram'
        plot(handles.eyediagram);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Eyediagram2'
        plot(handles.eyediagram2);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Halfsinus even'
        plot(handles.even);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Halfsinus odd'
        plot(handles.odd);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    otherwise
        plot(handles.bitstr);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
end

function input_bitstream_Callback(hObject, eventdata, handles)
% hObject    handle to input_bitstream (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_bitstream as text
%        str2double(get(hObject,'String')) returns contents of input_bitstream as a double
input_bitstream = get(hObject,'String');

%handles.input_bitstream = get(hObject,'string');
%guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function input_bitstream_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_bitstream (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_generate.
function button_generate_Callback(hObject, eventdata, handles)
% hObject    handle to button_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_bitstream = get(handles.input_bitstream,'String');
input_string = input_bitstream;

for n=1:length(input_string)
   input(n)=bin2dec(input_string(n))
end

handles.randbitstr = (zero2negone(input));
handles.bitstr = d2a(handles.randbitstr);
[handles.eyediagram,handles.eyediagram2] = eye_diag(handles.randbitstr);
%handles.eyediagram2 = eye_diag2(handles.randbitstr);
[a,b]=demux(handles.randbitstr);
[handles.even,handles.odd]=halfsins(a,b);


plot(handles.axes1,d2a(handles.randbitstr));
axis(handles.axes1,[-inf,inf,-1.5,1.5]);
grid(handles.axes1);
guidata(hObject,handles);





function input_snr_Callback(hObject, eventdata, handles)
% hObject    handle to input_snr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_snr = get(hObject,'String');
% Hints: get(hObject,'String') returns contents of input_snr as text
%        str2double(get(hObject,'String')) returns contents of input_snr as a double


% --- Executes during object creation, after setting all properties.
function input_snr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_snr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_noise.
function button_noise_Callback(hObject, eventdata, handles)
% hObject    handle to button_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input_snr = str2double(get(handles.input_snr,'String'));

handles.modulated_noise = addnoise(handles.modulated,input_snr);
plot(handles.axes4,handles.modulated_noise);
axis(handles.axes4,[-inf,inf,-inf,inf]);
grid(handles.axes4);
guidata(hObject,handles);


% --- Executes on selection change in selectlist.
function selectlist_Callback(hObject, eventdata, handles)
% hObject    handle to selectlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns selectlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        selectlist

  
val = get(hObject, 'Value');
str = get(hObject, 'String');
handles.str = str;
handles.val = val;

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function selectlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_show.
function button_show_Callback(hObject, eventdata, handles)
try
switch handles.str{handles.val}
    
    case 'Bitstream'
        axes(handles.axes1)
        cla(gca);
        plot(handles.bitstr);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Eyediagram'
        axes(handles.axes1)
        cla(gca);
        plot(handles.eyediagram);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Eyediagram2'
        axes(handles.axes1)
        cla(gca);
        plot(handles.eyediagram2);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Halfsinus even'
        axes(handles.axes1)
        cla(gca);
        plot(handles.even);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    case 'Halfsinus odd'
        axes(handles.axes1)
        cla(gca);
        plot(handles.odd);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
    otherwise
        plot(handles.bitstr);
        axis([-inf,inf,-1.5,1.5]);
        grid on;
end

catch
    
end

% hObject    handle to button_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_snr_fig.
function button_snr_fig_Callback(hObject, eventdata, handles)
figure(3)
plot(handles.modulated_noise);
axis([-inf,inf,-inf,inf]);
grid on;
% hObject    handle to button_snr_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ber_fig_button.
function ber_fig_button_Callback(hObject, eventdata, handles)
% hObject    handle to ber_fig_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.n_input = str2double(get(handles.n_input,'String'));
handles.simber = BER(handles.n_input);
handles.Eb_N0_dB = [-30:10]; 
handles.theoryBer = 0.5*erfc(sqrt(10.^(handles.Eb_N0_dB/10))); % theoretical ber
 
figure (6)
semilogy(handles.Eb_N0_dB,handles.theoryBer,'b.-');
hold on
semilogy(handles.Eb_N0_dB,handles.simber,'mx-');
axis([-30 10 10^-5 0.5])
grid on
legend('theory', 'simulation');
xlabel('Eb/No, dB');
ylabel('Bit Error Rate');


function n_input_Callback(hObject, eventdata, handles)
% hObject    handle to n_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n_input = get(hObject,'String');
% Hints: get(hObject,'String') returns contents of n_input as text
%        str2double(get(hObject,'String')) returns contents of n_input as a double


% --- Executes during object creation, after setting all properties.
function n_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
