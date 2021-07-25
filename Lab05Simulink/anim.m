function [sys,x0]=anim(t,x,u,flag,par_ts)
global CAnim
global handle
global min_length % length of minute hand
global hour_length % length of hour hand

% update model
if flag==2, % sys = mdlUpdate(t,x,u,par_ts)
    if get(0,'Children')==1, % test, if plot exists
        set(0,'currentfigure',CAnim);
        x0=0; y0=0;
        yM = min_length*u(1);
        xM = min_length*u(2);
        yH = hour_length *u(3);
        xH = hour_length *u(4);
% Use NaNs to make the hands distinct
        x=[xH x0 NaN x0 xM];
        y=[yH y0 NaN y0 yM];
        if u(5)==1
            x = -x;
        end
        set(handle,'XData',x,'YData',y);
        drawnow expose; % update plot
    end
    sys=[];
% sys = mdlGetTimeOfNextVarHit(t,x,u,par_ts)

    elseif flag == 4 % Return next sample hit
    sys = t + par_ts; % the constant sample interval

    elseif flag==0, % [sys,x0,str,ts]=mdlInitializeSizes;
% Initialize the figure for use with this simulation
    CAnim = figure;
    axis([-5 5 -5 5]); % axis properties
    hold on

% Set up the geometry for the problem
    hour_length=1.8; min_length=3;
    x0=0; y0=0;
    xH=x0 - hour_length; yH=y0;
    xM = x0; yM = y0 + min_length;
% Use NaNs to make the hands distinct
    x=[xH x0 NaN x0 xM];
    y=[yH y0 NaN y0 yM];

% plot the clock and init setting
    handle=plot(x,y,'LineWidth',5);
% plot center point with size 30
    plot(x0,y0,' . ','MarkerSize',30);

% write hours on the clock
    text(-0.2,3.6,'12');
    text(-0.2,-3.6,'6');
    text(3.6,0,'3');
    text(-3.6,0,'9');
% plot a circle around in yellow color
    m = 4*sin(0:0.1:2*pi+0.1);
    n = 4*cos(0:0.1:2*pi+0.1);
    plot(m,n,'y','LineWidth',5);

% Set the relative scaling of the individual axis data values .
    set(gca,'DataAspectRatio',[1 1 1]);
    sys=[0 0 0 5 0 0]; % 5...number of inputs
    x0 = []; % No continuous states
    drawnow;
end;