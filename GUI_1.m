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

% Last Modified by GUIDE v2.5 24-May-2014 15:35:24

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
hObject =  stem(zero2negone(bitstr(10)))
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_1 (see VARARGIN)
%axes(handles.axes1);
x1 = [-3*pi : 0.01 : 3*pi];
handles.awgn = addnoise(x1,-9);
handles.noawgn = x1;

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
handles.modulated = mod_test(handles.randbitstr);
plot (handles.axes4,handles.modulated);
guidata(hObject,handles);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (get(hObject,'Value') == get(hObject,'Max'))
	display('Selected');
    handles.modulated = addnoise(handles.modulated,-9);
    
else
	display('Not selected');
    handles.modulated = handles.modulated;
    
end
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in button_demodulate.
function button_demodulate_Callback(hObject, eventdata, handles)
% hObject    handle to button_demodulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.demodulated = demodulate(handles.modulated);
plot(handles.axes5,d2a((handles.demodulated),0.001,0.1));
axis(handles.axes5,[-inf,inf,-1.5,1.5]);
guidata(hObject,handles);

%plot(handles.axes5,sin(handles.current_data));

% --- Executes on button press in button_random.
function button_random_Callback(hObject, eventdata, handles)
% hObject    handle to button_random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%plot(handles.axes1,d2a(zero2negone(bitstr(10))));
handles.randbitstr = (zero2negone(bitstr(20)));
plot(handles.axes1,d2a((handles.randbitstr),0.001,0.1));
axis(handles.axes1,[-inf,inf,-1.5,1.5]);
guidata(hObject,handles);


% --- Executes on button press in button_rand_fig.
function button_rand_fig_Callback(hObject, eventdata, handles)
% hObject    handle to button_rand_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(1)
plot(d2a((handles.randbitstr),0.001,0.1));
axis([-inf,inf,-1.5,1.5]);


% --- Executes on button press in button_mod_fig.
function button_mod_fig_Callback(hObject, eventdata, handles)
% hObject    handle to button_mod_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(2)
plot(handles.modulated);
% --- Executes on button press in button_demod_fig.
function button_demod_fig_Callback(hObject, eventdata, handles)
% hObject    handle to button_demod_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(3)
plot(d2a((handles.demodulated),0.001,0.1));
axis([-inf,inf,-1.5,1.5]);