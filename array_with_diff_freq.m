close all
A1_t = @(t) 0;
phi1_t = @(t) 0;
v10 = @(a) 2*sin(a);
w10 = 2*pi*1*10^12;

A2_t = @(t) 0;
phi2_t = @(t) 0.15*pi;
v20 = @(a) 2*sin(a);
w20 = 2*pi*1.2*10^12;

A3_t = @(t) 0;
phi3_t = @(t) 0.25*pi;
v30 = @(a) 2*sin(a);
w30 = 2*pi*1*10^12;

A4_t = @(t) 0;
phi4_t = @(t) 0.35*pi;
v40 = @(a) 2*sin(a);
w40 = 2*pi*1.2*10^12;

A5_t = @(t) 0;
phi5_t = @(t) 0.15*pi;
v50 = @(a) 2*sin(a);
w50 = 2*pi*1*10^12;

A6_t = @(t) 0;
phi6_t = @(t) 0.15*pi;
v60 = @(a) 2*sin(a);
w60 = 2*pi*1.2*10^12;

A7_t = @(t) 0;
phi7_t = @(t) 0.05*pi;
v70 = @(a) 2*sin(a);
w70 = 2*pi*1*10^12;

A8_t = @(t) 0;
phi8_t = @(t) 0.35*pi;
v80 = @(a) 2*sin(a);
w80 = 2*pi*1.2*10^12;

A9_t = @(t) 0;
phi9_t = @(t) 0.05*pi;
v90 = @(a) 2*sin(a);
w90 = 2*pi*1*10^12;

A10_t = @(t) 0;
phi10_t = @(t) 0.35*pi;
v100 = @(a) 2*sin(a);
w100 = 2*pi*1.2*10^12;


ka = -0.1;
kb = 0.6;

k12 = kb;
k21 = ka;
k23 = kb;
k32 = ka;
k34 = kb;
k43 = ka;
k45 = kb;
k54 = ka;
k56 = kb;
k65 = ka;
k67 = kb;
k76 = ka;
k78 = kb;
k87 = ka;
k89 = kb;
k98 = ka;
k910 =kb;
k109 = ka;


k_time = 4;
tend = k_time * 40*10^-12;
tspan = 0 : tend/10^4/4/k_time : tend;
y0 = [phi1_t(0); phi2_t(0); phi3_t(0); phi4_t(0); phi5_t(0); phi6_t(0); phi7_t(0); phi8_t(0); phi9_t(0); phi10_t(0)];

[t,y] = ode78(@(t,y) ...
    [ ...
    w10 - w10 * k21 * sin(y(1) - y(2)); ...
    w20 - w20 * k12 * sin(y(2) - y(1)) - w20 * k32 * sin(y(2) - y(3)); ...
    w30 - w30 * k23 * sin(y(3) - y(2)) - w30 * k43 * sin(y(3) - y(4)); ...
    w40 - w40 * k34 * sin(y(4) - y(3)) - w40 * k54 * sin(y(4) - y(5));...
    w50 - w50 * k45 * sin(y(5) - y(4)) - w50 * k65 * sin(y(5) - y(6));...
    w60 - w60 * k56 * sin(y(6) - y(5)) - w60 * k76 * sin(y(6) - y(7));...
    w70 - w70 * k67 * sin(y(7) - y(6)) - w70 * k87 * sin(y(7) - y(8));...
    w80 - w80 * k78 * sin(y(8) - y(7)) - w80 * k98 * sin(y(8) - y(9));...
    w90 - w90 * k89 * sin(y(9) - y(8)) - w90 * k109 * sin(y(9) - y(10));...
    w100 - w100 * k910 * sin(y(10) - y(9))...
    ] ...
    , tspan, y0);

figure()
hold on
plot(t, v10(y(:,1)),'-')
plot(t, v20(y(:,2))  ,'-')
legend('amplitude of y1','amplitude of y2')
figure()
hold on
plot(t, y(:,1),'-',LineWidth=1)
plot(t, y(:,2)  ,'-',LineWidth=1)
plot(t, y(:,3),'-',LineWidth=1)
plot(t, y(:,4)  ,'-',LineWidth=1)
plot(t, y(:,5),'-',LineWidth=1)
plot(t, y(:,6)  ,'-',LineWidth=1)
plot(t, y(:,7),'-',LineWidth=1)
plot(t, y(:,8)  ,'-',LineWidth=1)
plot(t, y(:,9),'-',LineWidth=1)
plot(t, y(:,10)  ,'-',LineWidth=1)
legend('phase of y1','phase of y2','phase of y3','phase of y4','phase of y5','phase of y6','phase of y7','phase of y8','phase of y9','phase of y10')
figure()
hold on
%plot(t,mod(y(:,1)-y(:,2), 2*pi ))
plot(t,mod(y(:,1)-y(:,2), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,3), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,4), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,5), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,6), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,7), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,8), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,9), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,10), 2*pi ),LineWidth=1)
legend('phase difference 1,2','phase difference 1,4','phase difference 1,6','phase difference 1,8','phase difference 1,10')
figure()
hold on
plot(t,mod(y(:,1)-y(:,2), 2*pi ))
%plot(t,mod(y(:,1)-y(:,2), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,3), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,4), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,5), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,6), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,7), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,8), 2*pi ),LineWidth=1)
plot(t,mod(y(:,1)-y(:,9), 2*pi ),LineWidth=1)
%plot(t,mod(y(:,1)-y(:,10), 2*pi ),LineWidth=1)
legend('phase difference 1,2','phase difference 1,3','phase difference 1,5','phase difference 1,7','phase difference 1,9')
figure()
hold on
plot(t,mod(y(:,1)-y(:,2), 2*pi ),LineWidth=1);
plot(t,mod(y(:,2)-y(:,4), 2*pi ),LineWidth=1);
plot(t,mod(y(:,4)-y(:,6), 2*pi ),LineWidth=1);
plot(t,mod(y(:,6)-y(:,8), 2*pi ),LineWidth=1);
plot(t,mod(y(:,8)-y(:,10), 2*pi ),LineWidth=1);
plot(t,asin((w10-w20)/(w10*ka+w20*kb))*ones(size(t))+2*pi,LineWidth=2)
legend('phase difference 1,2','phase difference 2,4','phase difference 4,6','phase difference 6,8','phase difference 8,10','theoretical value')
title('difference betwen pairs')




