function varargout = agenteviajero(varargin)
% AGENTEVIAJERO MATLAB code for agenteviajero.fig
%      AGENTEVIAJERO, by itself, creates a new AGENTEVIAJERO or raises the existing
%      singleton*.
%
%      H = AGENTEVIAJERO returns the handle to a new AGENTEVIAJERO or the handle to
%      the existing singleton*.
%
%      AGENTEVIAJERO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AGENTEVIAJERO.M with the given input arguments.
%
%      AGENTEVIAJERO('Property','Value',...) creates a new AGENTEVIAJERO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before agenteviajero_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to agenteviajero_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help agenteviajero

% Last Modified by GUIDE v2.5 05-Dec-2016 15:49:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @agenteviajero_OpeningFcn, ...
                   'gui_OutputFcn',  @agenteviajero_OutputFcn, ...
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


% --- Executes just before agenteviajero is made visible.
function agenteviajero_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to agenteviajero (see VARARGIN)

% Choose default command line output for agenteviajero
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes agenteviajero wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = agenteviajero_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global n;
n=str2double(get(handles.edit1,'string'));
set(handles.uitable1,'data',cell(n,n));
set(handles.uitable1,'visible','on');
set(handles.uitable1,'ColumnEditable',true(1,n));

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=str2double(get(handles.uitable1,'data'));
global n;

estado=get(handles.radiobutton1,'Value');
if estado==1
    for i=1:n
        m(i)=i;
    end
    p=perms(m);
    f=0;
    per=factorial(n)
    for i=1:per
        if p(i,1)==1
            f=f+1;
            x(f,:)=p(i,:);
        end
    end
    for i=1:f
        j=2;
        b=1;
        c=x(i,2);
        aux(i)=0;
        aux(i)=aux(i)+a(b,c);
        for k=3:n
            b=c;
            c=x(i,k);
            aux(i)=aux(i)+a(b,c);
        end
        aux(i)=aux(i)+a(c,1);
    end
    dist=min(aux);
    i=find(aux(1,:)==dist);
    ruta=x(i(1),:);
    ruta(n+1)=1;
    txt='Fuerza bruta';
    set(handles.uipanel1,'title',txt);
    set(handles.text5,'string',num2str(ruta));
    set(handles.text7,'string',dist);
end  

estado=get(handles.radiobutton2,'Value');
if estado==1  
    dist=0;
    x=min(a(1,:));
    dist=dist+x; 
    [i,j]=find(a(1,:)==x);
    a(j,i)=NaN;
    ruta(1)=1;
    ind=j;
    for k=2:n
        if k==n
            ruta(k)=ind;
            ruta(k+1)=1;
            dist=dist+a(ind,1);       
        else    
            x=min(a(ind,2:n));
            dist=dist+x;
            [i,j]=find(a(ind,2:n)==x);
            a(j+1,ind)=NaN;
            ruta(k)=ind;
            ind=j+1;       
        end   
    end 
    
    txt='Vecino mas cercano';
    set(handles.uipanel1,'title',txt);
    set(handles.text5,'string',num2str(ruta));
    set(handles.text7,'string',dist);
              
end  


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();
close(Menu);
