function [sys,x0] = flowPlotAnim(t,x,u,flag,par_ts)
global FlPlotAnim       
if flag==2,
    if  get(0,'Children')==1,     % test, if plot exists
        set(0,'currentfigure',FlPlotAnim);
        nextView(par_ts,u(1));
        drawnow;                % update plot
    end
    sys=[];
elseif flag==4                  % Return next sample hit
    sys = t + 10*par_ts;        % the constant sample interval
elseif flag==0
% Initialize the figure for use with this simulation

    FlPlotAnim = figure;
    initializ([0 200]);
    hold on;

% Init structure for Simulink
    sys=[0 0 0 1 0 0]; %1...number of inputs
    x0 = []; % No continuous states
end;

function initializ(xLim)
global FP

% new axis
axis([xLim -1 1]); axis on;

% structure initialisation
FP= struct('axes',cla,'data',[xLim(1) NaN],'xLim',xLim,'yLim',[-1 1]);
set(FP . axes,'DrawMode','fast','Color','none','xLimMode','manual','yLimMode','manual');
FP . line=line(0,NaN,'Erase','none');

% show current point
function nextView(dx,y)
global FP

% add new point
x1=FP . data(end,1)+dx;
FP . data= [FP . data; x1 y];

% right shift
if FP . xLim(2) < x1
    dx= x1-FP . xLim(2);
    FP . xLim= FP . xLim + dx;
    I=FP . data(:,1) < FP . xLim(1);
    FP . data(I,:)=[];
    set(FP . axes,'xLim',FP . xLim);
end

% new values of yMin & yMax
if y < FP . yLim(1)|| FP . yLim(2) < y
    y= [y FP . yLim];
    FP . yLim=[min(y) max(y)];
    set(FP . axes,'yLim',FP . yLim);
end

% coordinates writing
set(FP . line,'xData',FP . data(:,1),'yData',FP . data(:,2));

