
function varargout = fig(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fig_OpeningFcn, ...
                   'gui_OutputFcn',  @fig_OutputFcn, ...
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
function fig_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = fig_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function btnGraph_Callback(hObject, eventdata, handles)
clc
global a
global b
global c
global D
%  try
a=str2num(get(handles.aEditFun, 'String'))
b=str2num(get(handles.bEditFun, 'String'))
c=str2num(get(handles.cEditFun, 'String'))
%количество точек
N=str2num(get(handles.nEditFun, 'String'))
% ширина X
weightX=str2num(get(handles.weightX, 'String'))
% вершина параболы
hFun=-b/(2*a);
save('h','hFun');
D=b*b-4*c;
check=0;
negativeX=0;
positiveX=0;
if D<=0;
%     шаг
    h=abs(((hFun+weightX)-(hFun-weightX)))/N;
    negativeX=hFun-weightX;
    positiveX=hFun+weightX;
    x=negativeX:h:positiveX;
    set(handles.Ex2xChbx,'Enable','off')
else
    x1=(-b-sqrt(D))/(2*a)
    x2=(-b+sqrt(D))/(2*a)
    save('xx','x1','x2');
    %     шаг
    h=abs(((x2+weightX)-(x1-weightX)))/N;
    negativeX=x1-weightX;
    positiveX=x2+weightX;
    x=negativeX:h:positiveX
    check=1;
    set(handles.xChckBox,'Enable','on')
    set(handles.Ex2xChbx,'Enable','on')
%     set(handles.mnGraphX,'Enable','on')
end
set(handles.hChckBox,'Enable','on')
set(handles.Ex2hChbx,'Enable','on')
% set(handles.mnGraphH,'Enable','on')
if check==0
    set(handles.xChckBox,'Enable','off')
    set(handles.Ex2xChbx,'Enable','off')
%     set(handles.mnGraphX,'Enable','off')
end
handles.checkVarH=0;
handles.checkVarX=0;
y=f(x);
handles.Line=plot(x,y);
if get(handles.chbxFix,'Value')==1
    set(handles.pmColour, 'Value',1)
    set(handles.Line, 'Marker','none')
    set(handles.rbMarkNo,'Value',1)
end
pmColour_Callback(hObject, eventdata, handles)
axis([ negativeX positiveX -inf inf])
grid on

set(handles.btnClc,'Enable','on')
set(handles.pmColour,'Enable','on')
set(handles.rbMarkNo,'Enable','on')
set(handles.rbMarkCircle,'Enable','on')
set(handles.rbMarkStars,'Enable','on')
set(handles.rbMarkDot,'Enable','on')
set(handles.chbxFix,'Enable','on')
% set(handles.pmColour,'Value',1)

set(handles.pmColourDot,'Enable','on')
set(handles.pmMarker,'Enable','on')
guidata(gcbo,handles);


set(handles.menuClear,'Enable','on')
set(handles.menuFix,'Enable','on')
set(handles.menuFix,'Enable','on')
set(handles.menuPlot,'Enable','off')




if get(handles.chbxFix, 'Value')==0
set(handles.btnGraph,'Enable','off')        
end

if get(handles.chbxFix,'Value')==1 & strcmp(get(handles.Ex2hChbx,'Checked'),'on')
    Ex2hChbx_Callback(handles.Ex2hChbx, eventdata, handles)
end

if get(handles.chbxFix,'Value')==1 & strcmp(get(handles.Ex2xChbx,'Checked'),'on')
  Ex2xChbx_Callback(handles.Ex2xChbx, eventdata, handles)
end
rbMarkNo_Callback(hObject, eventdata, handles)
set(handles.menuMarker,'Enable','on')
set(handles.menuColor,'Enable','on')

set(handles.Ex2Color,'Enable','on')
set(handles.Ex2Marker,'Enable','on')

% catch
%         errordlg('Данные введены неккоректно', 'Ошибка!')
% set(handles.xChckBox,'Enable','off')
% set(handles.Ex2xChbx,'Enable','off')
% set(handles.hChckBox,'Enable','off')
% set(handles.Ex2hChbx,'Enable','off')
% end


function btnClc_Callback(hObject, eventdata, handles)
button=questdlg('Очистить оси?','Очистка','Да','Нет','Да');
if strcmp(button,'Да')
menuColorBlue_Callback(handles.menuColorBlue, eventdata, handles)
menuMarkerNone_Callback(handles.menuMarkerNone, eventdata, handles)
cla
clc
set(hObject,'Enable','off')
set(handles.pmColour,'Enable','off')
set(handles.rbMarkNo,'Enable','off')
set(handles.rbMarkCircle,'Enable','off')
set(handles.rbMarkStars,'Enable','off')
set(handles.rbMarkDot,'Enable','off')
set(handles.chbxFix,'Enable','off')

set(handles.rbMarkNo,'Value',1)
% set(handles.pmColour,'Value',1)
set(handles.chbxFix,'Value',0)
grid off

set(handles.pmColourDot,'Enable','off')
set(handles.pmMarker,'Enable','off')
set(handles.Ex2hChbx,'Checked','off')
set(handles.Ex2xChbx,'Checked','off')
set(handles.Ex2hChbx,'Enable','off')
set(handles.Ex2xChbx,'Enable','off')

% set(handles.mnGraphH,'Enable','off')
% set(handles.mnGraphX,'Enable','off')
% set(handles.mnGraphH,'Checked','off')
% set(handles.mnGraphX,'Checked','off')
guidata(gcbo,handles);
set(handles.pmColourDot,'Value',1)


set(handles.hChckBox,'Enable','off')
set(handles.hChckBox,'Value',0)
set(handles.xChckBox,'Enable','off')
set(handles.xChckBox,'Value',0)

set(handles.menuMarker,'Enable','off')
set(handles.menuColor,'Enable','off')
set(handles.menuClear,'Enable','off')
set(handles.menuFix,'Enable','off')
set(handles.menuFix,'Enable','off')
set(handles.menuPlot,'Enable','on')

set(handles.btnGraph,'Enable','on')

handles.checkVarH =0;
handles.checkVarX =0;

set(handles.Ex2Color,'Enable','off')
set(handles.Ex2Marker,'Enable','off')

set(handles.menuFix,'Checked','off')
end

function aEditFun_Callback(hObject, eventdata, handles)
function aEditFun_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function bEditFun_Callback(hObject, eventdata, handles)
function bEditFun_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cEditFun_Callback(hObject, eventdata, handles)
function cEditFun_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nEditFun_Callback(hObject, eventdata, handles)
function nEditFun_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function weightX_Callback(hObject, eventdata, handles)
function weightX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function chbxFix_Callback(hObject, eventdata, handles)
if get(handles.chbxFix, 'Value')
hold on
set(handles.btnGraph,'Enable','on')
set(handles.menuFix,'Checked','on')
else
hold off
set(handles.btnGraph,'Enable','off')
set(handles.menuFix,'Checked','off')
end

function pmColour_Callback(hObject, eventdata, handles)
Num=get(handles.pmColour, 'Value');
switch Num
    case 1
        set(handles.Line, 'Color', 'b');
        set(handles.menuColorBlue,'Checked','on')
        set(handles.menuColorRed,'Checked','off')
        set(handles.menuColorGreen,'Checked','off')
        set(handles.menuColorBlack,'Checked','off')
    case 2
        set(handles.Line, 'Color', 'r');
        set(handles.menuColorBlue,'Checked','off')
        set(handles.menuColorRed,'Checked','on')
        set(handles.menuColorGreen,'Checked','off')
        set(handles.menuColorBlack,'Checked','off')
    case 3
        set(handles.Line, 'Color', 'g');
        set(handles.menuColorBlue,'Checked','off')
        set(handles.menuColorRed,'Checked','off')
        set(handles.menuColorGreen,'Checked','on')
        set(handles.menuColorBlack,'Checked','off')
    case 4
        set(handles.Line, 'Color', 'k');
        set(handles.menuColorBlue,'Checked','off')
        set(handles.menuColorRed,'Checked','off')
        set(handles.menuColorGreen,'Checked','off')
        set(handles.menuColorBlack,'Checked','on')
end
function pmColour_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rbMarkNo_Callback(hObject, eventdata, handles)
set(handles.Line, 'Marker','none')
set(handles.menuMarkerNone,'Checked','on')
set(handles.menuMarkerCirc,'Checked','off')
set(handles.menuMarkerStars,'Checked','off')
set(handles.menuMarkerDot,'Checked','off')
function rbMarkCircle_Callback(hObject, eventdata, handles)
set(handles.Line, 'Marker', 'o')
set(handles.menuMarkerCirc,'Checked','on')
set(handles.menuMarkerNone,'Checked','off')
set(handles.menuMarkerStars,'Checked','off')
set(handles.menuMarkerDot,'Checked','off')
function rbMarkStars_Callback(hObject, eventdata, handles)
set(handles.Line, 'Marker', '*')
set(handles.menuMarkerStars,'Checked','on')
set(handles.menuMarkerStars,'Checked','on')
set(handles.menuMarkerCirc,'Checked','off')
set(handles.menuMarkerNone,'Checked','off')
set(handles.menuMarkerDot,'Checked','off')
function rbMarkDot_Callback(hObject, eventdata, handles)
set(handles.Line, 'Marker', '.')
set(handles.menuMarkerDot,'Checked','on')
set(handles.menuMarkerStars,'Checked','off')
set(handles.menuMarkerCirc,'Checked','off')
set(handles.menuMarkerNone,'Checked','off')

function mnEx_Callback(hObject, eventdata, handles)
function mnPlot_Callback(hObject, eventdata, handles)
    
function menuMarker_Callback(hObject, eventdata, handles)
function menuColor_Callback(hObject, eventdata, handles)
function menuPlot_Callback(hObject, eventdata, handles)
    btnGraph_Callback(handles.btnGraph, eventdata, handles)
function menuClear_Callback(hObject, eventdata, handles)
    btnClc_Callback(handles.btnClc, eventdata, handles)
function menuFix_Callback(hObject, eventdata, handles)
   if strcmp(get(hObject,'Checked'),'on')
       set(hObject,'Checked','off')
       set(handles.chbxFix,'Value',0)
       hold off
       set(handles.btnGraph,'Enable','off')
   else
       set(hObject,'Checked','on')
       set(handles.chbxFix,'Value',1)
       hold on
       set(handles.btnGraph,'Enable','on')
   end

function ex1_Callback(hObject, eventdata, handles)
   set(handles.ex2,'Checked','off')
   set(hObject,'Checked','on')
   
%    set(handles.inputPanel,'Visible','on')
    set(handles.markerPanel,'Visible','on')
    set(handles.text10,'Visible','on')
    set(handles.pmColour,'Visible','on')
    set(handles.chbxFix,'Visible','on')
%    set(handles.btnGraph,'Visible','on')
%    set(handles.btnClc,'Visible','on')
    set(handles.mnPlot,'Visible','on')
   set(handles.text1ex,'Visible','on')
   set(handles.massive1,'Visible','on')
   set(handles.massive2,'Visible','on')
  
%    if get(handles.hChckBox,'Value')==1
%    Ex2hChbx_Callback(handles.Ex2hChbx, eventdata, handles)
%    end
%    if get(handles.xChckBox,'Value')==1
%    Ex2xChbx_Callback(handles.Ex2xChbx, eventdata, handles)
%    end
%    
%    set(handles.Ex2hChbx,'Checked','off')
%    set(handles.Ex2xChbx,'Checked','off')
  
   set(handles.hChckBox,'Visible','off')
   set(handles.xChckBox,'Visible','off')
   set(handles.text12,'Visible','off')
   set(handles.pmColourDot,'Visible','off')
   set(handles.pmMarker,'Visible','off')
    set(handles.text19,'Visible','off')
    set(handles.mnEx2,'Visible','off')
    set(handles.text23,'Visible','off')
   set(handles.text12,'Visible','off')
   set(handles.text24,'Visible','off')
    
function ex2_Callback(hObject, eventdata, handles)

  
    
   set(handles.ex1,'Checked','off')
   set(hObject,'Checked','on')
    
%    set(handles.inputPanel,'Visible','off')
    set(handles.markerPanel,'Visible','off')
    set(handles.text10,'Visible','off')
    set(handles.pmColour,'Visible','off')
    set(handles.chbxFix,'Visible','off')
%    set(handles.btnGraph,'Visible','off')
%    set(handles.btnClc,'Visible','off')
    set(handles.mnPlot,'Visible','off')
   set(handles.text1ex,'Visible','off')
   set(handles.massive1,'Visible','off')
   set(handles.massive2,'Visible','off')
%    
   set(handles.hChckBox,'Visible','on')
   set(handles.xChckBox,'Visible','on')
   set(handles.text12,'Visible','on')
   set(handles.text23,'Visible','on')
   set(handles.text24,'Visible','on')

   set(handles.pmColourDot,'Visible','on')
    set(handles.pmMarker,'Visible','on')
   set(handles.text19,'Visible','on')
   set(handles.mnEx2,'Visible','on')
   
   
  
%    set(handles.pmColourDot,'Enable','on')
%     set(handles.pmMarker,'Enable','on')
   
 
    guidata(gcbo,handles);

  
function menuColorBlue_Callback(hObject, eventdata, handles)
set(handles.pmColour,'Value',1)
pmColour_Callback(hObject, eventdata, handles)
function menuColorRed_Callback(hObject, eventdata, handles)
set(handles.pmColour,'Value',2)
pmColour_Callback(hObject, eventdata, handles)
function menuColorGreen_Callback(hObject, eventdata, handles)
set(handles.pmColour,'Value',3)
pmColour_Callback(hObject, eventdata, handles)
function menuColorBlack_Callback(hObject, eventdata, handles)
set(handles.pmColour,'Value',4)
pmColour_Callback(hObject, eventdata, handles)

function menuMarkerNone_Callback(hObject, eventdata, handles)
rbMarkNo_Callback(hObject, eventdata, handles)
set(handles.rbMarkNo,'Value',1)
function menuMarkerCirc_Callback(hObject, eventdata, handles)
rbMarkCircle_Callback(hObject, eventdata, handles)
set(handles.rbMarkCircle,'Value',1)
function menuMarkerStars_Callback(hObject, eventdata, handles)
rbMarkStars_Callback(hObject, eventdata, handles)
set(handles.rbMarkStars,'Value',1)
function menuMarkerDot_Callback(hObject, eventdata, handles)
rbMarkDot_Callback(hObject, eventdata, handles)
set(handles.rbMarkDot,'Value',1)

function hChckBox_Callback(hObject, eventdata, handles)
if get(hObject, 'Value')==1
    set(handles.Ex2hChbx,'Checked','on')
    handles.checkVarH=1;
    hold on
    h=load('h');
    handles.Line2=plot(h.hFun,f(h.hFun),'MarkerSize',10)
    handles.texth=text(h.hFun,f(h.hFun),'Вершина')
%     set(handles.Line2, 'Marker','+');
%     set(handles.Line2, 'Color', 'm');

    guidata(gcbo,handles);
%     hold off
    
   set(handles.hChckBox,'Enable','on')
   set(handles.pmColourDot,'Enable','on')
   set(handles.pmMarker,'Enable','on')
%    set(handles.mnGraphH,'Checked','on')
   
   pmMarker_Callback(hObject, eventdata, handles)
   pmColourDot_Callback(hObject, eventdata, handles)
else
%     set(handles.mnGraphH,'Checked','off')
    
    handles.checkVarH=0;
    guidata(gcbo,handles);
    
    delete(handles.Line2);
    delete(handles.texth);
    set(handles.Ex2hChbx,'Checked','off')
   if get(handles.xChckBox,'Value')==0
%    set(handles.pmColourDot,'Enable','off')
%     set(handles.pmMarker,'Enable','off')
   
   end
end

function xChckBox_Callback(hObject, eventdata, handles)
if get(hObject, 'Value')==1
     handles.checkVarX=1;
     set(handles.Ex2xChbx,'Checked','on')
    hold on
    xx=load('xx')
    handles.Line3=plot(xx.x1,f(xx.x1),'MarkerSize',10)
    handles.texts1=text(xx.x1,f(xx.x1),'Корень1')
    handles.Line4=plot(xx.x2,f(xx.x2),'MarkerSize',10)
    handles.texts2=text(xx.x2,f(xx.x2),'Корень2')
%     set(handles.Line3, 'Marker','+')
%     set(handles.Line4, 'Marker','+')
%     set(handles.Line3, 'Color', 'm');
%     set(handles.Line4, 'Color', 'm');
    guidata(gcbo,handles);
%     hold off
    
   set(handles.xChckBox,'Enable','on')
   set(handles.pmColourDot,'Enable','on')
   set(handles.pmMarker,'Enable','on')
   
%    set(handles.mnGraphX,'Checked','on')
   
   pmMarker_Callback(hObject, eventdata, handles)
   pmColourDot_Callback(hObject, eventdata, handles)
else
     handles.checkVarX=0;
     set(handles.Ex2xChbx,'Checked','off')
%      set(handles.mnGraphX,'Checked','off')
     guidata(gcbo,handles);
    
    delete(handles.Line3);
    delete(handles.Line4);
    delete(handles.texts1);
    delete(handles.texts2);
    
   if get(handles.hChckBox,'Value')==0
%    set(handles.pmColourDot,'Enable','off')
%    set(handles.pmMarker,'Enable','off')
   end
end

function pmColourDot_Callback(hObject, eventdata, handles)
    Num=get(handles.pmColourDot, 'Value');
switch Num
    case 1
    set(handles.menuColorPurple,'Checked','on')
    set(handles.menuColorBlue2,'Checked','off')
    set(handles.menuColorYellow,'Checked','off')
    set(handles.menuColorWhite,'Checked','off')
        if handles.checkVarH==1
        set(handles.Line2, 'Color', 'm');
        end
        if  handles.checkVarX ==1
           set(handles.Line3, 'Color', 'm');
           set(handles.Line4, 'Color', 'm');
        end
    case 2
    set(handles.menuColorPurple,'Checked','off')
    set(handles.menuColorBlue2,'Checked','on')
    set(handles.menuColorYellow,'Checked','off')
    set(handles.menuColorWhite,'Checked','off')
        if handles.checkVarH==1
        set(handles.Line2, 'Color', 'c');
        end
        if  handles.checkVarX ==1
           set(handles.Line3, 'Color', 'c');
           set(handles.Line4, 'Color', 'c');
        end
    case 3
    set(handles.menuColorPurple,'Checked','off')
    set(handles.menuColorBlue2,'Checked','off')
    set(handles.menuColorYellow,'Checked','on')
    set(handles.menuColorWhite,'Checked','off')
        if handles.checkVarH==1
        set(handles.Line2, 'Color', 'y');
        end
        if  handles.checkVarX ==1
           set(handles.Line3, 'Color', 'y');
           set(handles.Line4, 'Color', 'y');
        end
    case 4
    set(handles.menuColorPurple,'Checked','off')
    set(handles.menuColorBlue2,'Checked','off')
    set(handles.menuColorYellow,'Checked','off')
    set(handles.menuColorWhite,'Checked','on')
        if handles.checkVarH==1
        set(handles.Line2, 'Color', 'w');
        end
        if  handles.checkVarX ==1
           set(handles.Line3, 'Color', 'w');
           set(handles.Line4, 'Color', 'w');
        end
end

function pmColourDot_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mnEx2_Callback(hObject, eventdata, handles)
 


function Ex2hChbx_Callback(hObject, eventdata, handles)
if strcmp(get(hObject,'Checked'),'on')
       set(hObject,'Checked','off')
       set(handles.hChckBox, 'Value',0)
       hChckBox_Callback(handles.hChckBox, eventdata, handles)
   else
       set(hObject,'Checked','on')
       set(handles.hChckBox, 'Value',1)
       hChckBox_Callback(handles.hChckBox, eventdata, handles)
   end

function Ex2xChbx_Callback(hObject, eventdata, handles)
if strcmp(get(hObject,'Checked'),'on')
       set(hObject,'Checked','off')
       set(handles.xChckBox, 'Value',0)
       xChckBox_Callback(handles.xChckBox, eventdata, handles)
   else
       set(hObject,'Checked','on')
       set(handles.xChckBox, 'Value',1)
       xChckBox_Callback(handles.xChckBox, eventdata, handles)
   end

function Ex2Marker_Callback(hObject, eventdata, handles)

function Ex2Color_Callback(hObject, eventdata, handles)

function pmMarker_Callback(hObject, eventdata, handles)
    Num=get(handles.pmMarker, 'Value');
    switch Num
    case 1
    set(handles.menuMarkerPlus,'Checked','on')
    set(handles.menuMarkerCross,'Checked','off')
    set(handles.menuMarkerRhombus,'Checked','off')
   if handles.checkVarH==1
    set(handles.Line2,'Marker','+')
     end
if  handles.checkVarX ==1
    set(handles.Line3, 'Marker','+')
    set(handles.Line4, 'Marker','+')
end
    case 2
    set(handles.menuMarkerPlus,'Checked','off')
    set(handles.menuMarkerCross,'Checked','on')
    set(handles.menuMarkerRhombus,'Checked','off')
if handles.checkVarH==1
    set(handles.Line2, 'Marker', 'x')
    end
if  handles.checkVarX==1 
    set(handles.Line3, 'Marker','x')
    set(handles.Line4, 'Marker','x')
end
    case 3
    set(handles.menuMarkerPlus,'Checked','off')
    set(handles.menuMarkerCross,'Checked','off')
    set(handles.menuMarkerRhombus,'Checked','on')
if handles.checkVarH==1
    set(handles.Line2, 'Marker', 'd')
    end
if  handles.checkVarX==1 
    set(handles.Line3, 'Marker','d')
    set(handles.Line4, 'Marker','d')
end
    end

function pmMarker_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function y=f(x)
global a
global b
global c
y=a.*x.^2+b.*x+c


function massive1_Callback(hObject, eventdata, handles)
set(handles.aEditFun,'String',2)
set(handles.bEditFun,'String',3)
set(handles.cEditFun,'String',4)


function massive2_Callback(hObject, eventdata, handles)
set(handles.aEditFun,'String',1)
set(handles.bEditFun,'String',10)
set(handles.cEditFun,'String',2)



function menuColorPurple_Callback(hObject, eventdata, handles)
set(handles.pmColourDot,'Value',1)
pmColourDot_Callback(hObject, eventdata, handles)

function menuColorBlue2_Callback(hObject, eventdata, handles)
set(handles.pmColourDot,'Value',2)
pmColourDot_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function menuColorYellow_Callback(hObject, eventdata, handles)
set(handles.pmColourDot,'Value',3)
pmColourDot_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menuColorWhite_Callback(hObject, eventdata, handles)
set(handles.pmColourDot,'Value',4)
pmColourDot_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menuMarkerPlus_Callback(hObject, eventdata, handles)
set(handles.pmMarker,'Value',1)
pmMarker_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menuMarkerCross_Callback(hObject, eventdata, handles)
set(handles.pmMarker,'Value',2)
pmMarker_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function menuMarkerRhombus_Callback(hObject, eventdata, handles)
set(handles.pmMarker,'Value',3)
pmMarker_Callback(hObject, eventdata, handles)


% --- Executes on button press in btnGraph.

% hObject    handle to btnGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnClc.


% --- Executes on selection change in pmColourDot.


% --------------------------------------------------------------------
% function mnGraphH_Callback(hObject, eventdata, handles)
% hObject    handle to mnGraphH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Ex2hChbx_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
% function mnGraphX_Callback(hObject, eventdata, handles)
% Ex2xChbx_Callback(hObject, eventdata, handles)
% hObject    handle to mnGraphX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
