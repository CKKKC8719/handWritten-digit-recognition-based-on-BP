function varargout = number_reconginize(varargin)
% NUMBER_RECONGINIZE MATLAB code for number_reconginize.fig
%      NUMBER_RECONGINIZE, by itself, creates a new NUMBER_RECONGINIZE or raises the existing
%      singleton*.
%
%      H = NUMBER_RECONGINIZE returns the handle to a new NUMBER_RECONGINIZE or the handle to
%      the existing singleton*.
%
%      NUMBER_RECONGINIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUMBER_RECONGINIZE.M with the given input arguments.
%
%      NUMBER_RECONGINIZE('Property','Value',...) creates a new NUMBER_RECONGINIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before number_reconginize_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to number_reconginize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help number_reconginize

% Last Modified by GUIDE v2.5 06-Apr-2020 18:32:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @number_reconginize_OpeningFcn, ...
                   'gui_OutputFcn',  @number_reconginize_OutputFcn, ...
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


% --- Executes just before number_reconginize is made visible.
function number_reconginize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to number_reconginize (see VARARGIN)

% Choose default command line output for number_reconginize
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes number_reconginize wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = number_reconginize_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_image.
function open_image_Callback(hObject, eventdata, handles)
% hObject    handle to open_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.png';'*.bmp';'*.tif';'*.jpg';'*.*'},'载入图像');
if isequal(filename,0)|isequal(pathname,0)
    errordlg('没有选中文件','出错');
    return;
else
    file=[pathname,filename];
    global S   %设置一个全局变量S，保存初始图像路径，以便之后的还原操作
    S=file;
    x=imread(file);
    set(handles.axes1,'HandleVisibility','ON');
    axes(handles.axes1);
    imshow(x);
    handles.img=x;
    %photo_matrix=x;
    %handles.cc=photo_matrix;
    guidata(hObject,handles);
end


% --- Executes on button press in Regconition.
function Regconition_Callback(hObject, eventdata, handles)
% hObject    handle to Regconition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%global T;
%handles.img=im2double(handles.img);
numberqqq=gui_hanshu(handles.img);
set(handles.edit1,'String',num2str(numberqqq)); 




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
