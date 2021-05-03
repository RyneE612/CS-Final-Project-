function [] = guiFinal()

global gui

gui.fig = figure('numbertitle','off','name','Graph');%Creates a figure with a blank plot and names it "Graph"
gui.plot = axes('Position', [0.15 0.15 0.7 0.7]);
gui.plot = plot(0,0);

gui.xVal = uicontrol('Style','edit','units','normalized','position',[0.15 0.007 0.15 0.05],'string','X values');%Creates input boxes for the x ad y values that will be plotted 
gui.yVal = uicontrol('Style','edit','units','normalized','position',[0.70 0.007 0.15 0.05],'string','Y values');

gui.xMax = uicontrol('Style','edit','units','normalized','position',[0.3 0.950 0.1 0.05],'string','X max');%Creates input boxes for the minimums and maximums for x and y
gui.xMin = uicontrol('Style','edit','units','normalized','position',[0.4 0.950 0.1 0.05],'string','X min');
gui.yMax = uicontrol('Style','edit','units','normalized','position',[0.5 0.950 0.1 0.05],'string','Y max');
gui.yMin = uicontrol('Style','edit','units','normalized','position',[0.6 0.950 0.1 0.05],'string','Y min');

gui.clear = uicontrol('Style','pushbutton','unit','normalized','position',[0.50 0.007 0.14 0.05],'string','clear','callback',{@clear});
%Above creates a clear button 
gui.plotButton = uicontrol('Style','pushbutton','units','normalized','position',[0.35 0.007 0.14 0.05],'string','Plot','callback',{@update});
%Above creates a plot button 
gui.colorBG = uibuttongroup('Visible','on','Position',[0.9 0.5 0.1 0.3]);%Positions the color button group on the page
gui.colorr1 = uicontrol(gui.colorBG,'Style','radiobutton','String','Red','units','normalized','Position',[0.01 0.90 0100 0.090], 'HandleVisibility','off');
gui.colorg1 = uicontrol(gui.colorBG,'Style','radiobutton','String','Green','units','normalized','Position',[0.01 0.50 0100 0.090], 'HandleVisibility','off');
gui.colorb1 = uicontrol(gui.colorBG,'Style','radiobutton','String','Blue','units','normalized','Position',[0.01 0.10 0100 0.090], 'HandleVisibility','off');

gui.lineBG = uibuttongroup('Visible','on','Position',[0 0.5 0.1 0.3]); %Positions the line type button group on the plot
gui.liner1 = uicontrol(gui.lineBG,'Style','radiobutton','String',':','units','normalized','Position',[0.01 0.90 0200 0.090],'HandleVisibility','off');
gui.lineg1 = uicontrol(gui.lineBG,'Style','radiobutton','String','--','units','normalized','Position',[0.01 0.60 0200 0.090],'HandleVisibility','off');
gui.lineb1 = uicontrol(gui.lineBG,'Style','radiobutton','String','-.','units','normalized','Position',[0.01 0.30 0200 0.090],'HandleVisibility','off');
gui.lineb1 = uicontrol(gui.lineBG,'Style','radiobutton','String','-','units','normalized','Position',[0.01 0.01 0200 0.090],'HandleVisibility','off');
end

function [] = update(src,event)

global gui

x = str2num(gui.xVal.String);%This changes the input strings into arrays 
y = str2num(gui.yVal.String);

xMax = str2num(gui.xMax.String);%Makes the input string into a number
xMin = str2num(gui.xMin.String);
yMax = str2num(gui.yMax.String);
yMin = str2num(gui.yMin.String);

if isempty(xMax)%Sets a value for the min and max if no min or max is entered by the user
    xMax = 1;
end 
if isempty(xMin)
    xMin = -1;
end
if isempty(yMax)
    yMax = 1;
end 
if isempty(yMin)
    yMin = -1;
end
 if length(x) == length(y) %This checks to see if any lengths of y are equal to the lengths of x
     color = gui.colorBG.SelectedObject.String;
     color = color(1) - ('A' - 'a');
     lineStyle = ([gui.lineBG.SelectedObject.String,color]);
     plot(x,y,lineStyle);
     if (yMax < yMin)||(xMax < xMin)%This creates an error message if the entered minimums are larges than the entered maximums
         msg('The X and Y maximums must be bigger than their respective minimums','Axis Limit Error','Error','Modal')
         if (yMax == 1) && (yMin == -1) && (xMax == 1) && (xMin == -1)
             axis auto   
         else 
             axis([xMin xMax yMin yMax]);
         end 
     end
 else
     msgbox('Arrays are of different lengths or have invalid inputs','Plotting Error','error','modal');
 end 
end 
function [] = clear(src,event)%Resets all of the input boxes and axises 

global gui

delete(gui.plot);
plot(0,0);

gui.xVal.String = 'X Values';
gui.yVal.String = 'Y Values';

gui.yMax.String = 'Y Max';
gui.yMin.String = 'Y Min';
gui.xMax.String = 'X Max';
gui.xMin.String = 'X Min';

end 
     


