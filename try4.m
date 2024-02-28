close all
A1_t = @(t) 0;
phi1_t = @(t) 0;
v10 = @(a) 2*sin(a);
w10 = 2*pi*1*10^12;

A2_t = @(t) 0;
phi2_t = @(t) 0.15*pi;
v20 = @(a) 2*sin(a);
w20 = 2*pi*1*10^12;
SNR = 10;

wa0 = 2*pi*1*10^12;
wb0 = 2*pi*1*10^12;

k_list = 0.39 * [1; -0.25; 0.25; 1];
tend = 80*10^-12;
tspan = 0 : tend/10^5/4 : tend;
y0 = [ 0; phi1_t(0); phi2_t(0); 0];
yita_rand1 = sqrt(2 * 10^-2) * randn(size(tspan));
yita_rand2 = sqrt(2 * 10^-2) * randn(size(tspan));
[t,y] = ode78(@(t,y) ...
    [wa0; ...
     (w10 - w10 * (k_list(1)) * sin(y(2) - y(1)) - w10 * (k_list(2)) * sin(y(2) - y(3))); ...
     (w20 - w20 * k_list(4) * sin(y(3) - y(4)) - w20 * (k_list(3)) * sin(y(3) - y(2))); ...
     wb0 ...
    ], tspan, y0);

figure()
hold on
plot(t, v10(y(:,2)),'-')
plot(t, v20(y(:,3))  ,'-')
legend('amplitude of y1','amplitude of y2')
figure()
hold on
plot(t, y(:,2),'-')
plot(t, y(:,3)  ,'-')
legend('phase of y1','phase of y2')
figure()
%plot(t,mod(y(:,1)-y(:,2), 2*pi ))
plot(t,y(:,2)-y(:,3))
title('phase difference')