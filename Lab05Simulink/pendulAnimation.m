function [sys,x0]=pendulAnimation(t,x,u,flag,par_ts);
global PendAnim
global handle
global L Lm % length of Pendulum
global xHm yHm % coordinates of mass center

if flag==2,
    if get(0,'Children')==1, % test, if plot exists
        set(0,'currentfigure',PendAnim);
        plot(xHm,yHm,'.','MarkerSize',30);
        Lm=u(2); % pendulum length
        L=Lm-1; % pendulum length
        axis([-Lm-5 Lm+5 -Lm-5 Lm+5]); %axis properties
% Current coordinates of Pendulum
        xH = L *sin(u(1));
        yH = -L *cos(u(1));
        xHm = Lm *sin(u(1)); % x curr of mass center
        yHm = -Lm *cos(u(1)); % y curr of mass center
        x0=0; y0=0; % Center coordinates
% Draw the current position of Pendulum
        x=[xH x0];
        y=[yH y0];
        set(handle,'XData',x,'YData',y);
        drawnow expose; % update plot
    end
    sys=[];
    elseif flag == 4 % Return next sample hit
    sys = t + par_ts; % the constant sample interval
    elseif flag==0, 
% Initialize the figure for use with this simulation
    PendAnim = figure;
    axis([-45 45 -45 45]); % axis properties
    hold on
% Set up the geometry for the problem
    Lm=40; %u(2); % Pendulum length
    L=Lm-1; %u(2); % Pendulum length
    x0=0; y0=0; % Center coordinates
    xH=x0; yH=y0-L;
    xHm=x0; yHm=y0-Lm; % Coordinates of mass center
% Draw the current position of Pendulum
    x=[xH x0]; y=[yH y0];
% plot the Pendulum and init setting
    handle=plot(x,y,'LineWidth',5);
% plot center point with size 30
    plot(x0,y0,'.','MarkerSize',30);
% Set the relative scaling of
% the individual axis data values
    set(gca,'DataAspectRatio',[1 1 1]);
    sys=[0 0 0 2 0 0]; % 2 - number of inputs
    x0 = []; % No continuous states
end; 