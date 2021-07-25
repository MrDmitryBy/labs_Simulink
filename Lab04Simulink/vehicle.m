%  ирилло ƒмитрий 2 курс 5 группа
% cd - current direcitry

clear all;
clc;

%mass of car
m = 1000;
%velocity of car 
v = 20;
%stiffness of spring
%k = 1000;
k = input('Spring stiffness k= ');
%damping coefficient
%c = 100;
c = input('Damping parameter c= ');
%horizontal displacement before the tire enters the hole
hole_start = 450;
%length of hole
hole_width = 1;
%depth of hole
hole_depth = 0.15;
%time of which the tire enters the hole 
t1 = hole_start/v;
%time of which the tire comes out of the hole
t2 = (hole_start + hole_width)/v;

sim('L0401.mdl');
%load input displacement
load input_disp.mat;
%load result displacement 
load disp.mat; 
figure(1)
subplot(2,1,1);
plot(input_disp);
xlabel('t,sek');
ylabel('y1,m');
title(sprintf('Spring-Mass-Damper Dynamic System:k=%d c=%d',k,c));
subplot(2,1,2);
plot(disp);
xlabel('t,sek');
ylabel('h,m');