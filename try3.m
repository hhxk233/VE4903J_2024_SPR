close all
A1_t = @(t) 0;
phi1_t = @(t) 0;
v10 = @(a) 2*sin(a);
w10 = 2*pi*1*10^12;

A2_t = @(t) 0;
phi2_t = @(t) 0.15*pi;
v20 = @(a) 2*sin(a);
w20 = 2*pi*1.2*10^12;

k1 = 0.6;
k2 = -0.1;
tend = 40*10^-12;
tspan = 0 : tend/10^4/4 : tend;
y0 = [phi1_t(0); phi2_t(0)];

[t,y] = ode78(@(t,y) [w10 - w10 * k2 * sin(y(1) - y(2)) ;w20 - w20 * k1 * sin(y(2) - y(1))], tspan, y0);

figure()
hold on
plot(t, v10(y(:,1)),'-')
plot(t, v20(y(:,2))  ,'-')
legend('amplitude of y1','amplitude of y2')
figure()
hold on
plot(t, y(:,1),'-',LineWidth=2)
plot(t, y(:,2)  ,'-',LineWidth=2)
legend('phase of y1','phase of y2')
figure()
plot(t,mod(y(:,1)-y(:,2), 2*pi ),LineWidth=2)
%plot(t,y(:,1)-y(:,2))
title('phase difference')
figure()
hold on
plot(t,(w10-w20)/(w10*k2+w20*k1)*ones(size(t)),LineWidth=2)
plot(t,sin(y(:,1)-y(:,2)),LineWidth=2)
%plot(t,y(:,1)-y(:,2))
h = legend('$\frac{\omega_1-\omega_2}{\omega_1 k_{2,1} + \omega_2 k_{1,2}}$' ,'$sin(\theta_1 - \theta_2)$');
set(h,'Interpreter','latex')
title('sin phase difference and the theoretical value')