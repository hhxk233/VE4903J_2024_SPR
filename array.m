close all


phi1_t = @(t) 0*pi;
v10 = @(a) 2*sin(a);
w10 = 2*pi*1*10^12;

phi2_t = @(t) 0.25*pi;
v20 = @(a) 2*sin(a);
w20 = 2*pi*1*10^12;

phi3_t = @(t) 0.15*pi;
v30 = @(a) 2*sin(a);
w30 = 2*pi*1*10^12;

phi4_t = @(t) 0.05*pi;
v40 = @(a) 2*sin(a);
w40 = 2*pi*1*10^12;

phi5_t = @(t) 0.35*pi;
v50 = @(a) 2*sin(a);
w50 = 2*pi*1*10^12;

w = [w10; w20; w30; w40; w50];


k12 = 0.5;
k21 = -0.0;
k23 = 0.5;
k32 = -0.5;
k34 = 0.0;
k43 = -0.0;
k45 = 0.0;
k54 = -0.0;

k13 = 0.5;
k31 = -0.5;

n = 5; 
K = ones(n); 
K = triu(K); 
K = K - eye(n); 
K = K - (K < 0.5); 
K = 0.5 * K;

K(2,:) = 0;
K(5,:) = 0;

K = 0.5*[ 0 1 0 0 0;
          0 0 1 0 0;
          0 -1 0 1 0;
          0 0 -1 0 0;
          0 0 0 -1 0
        ];

k_time = 20;
tend = k_time*1*10^-12;
tspan = 0 : tend/10^5/k_time : tend;
y0 = [phi1_t(0); phi2_t(0); phi3_t(0); phi4_t(0); phi5_t(0)];

[t,y] = ode78(@(t,y) [ ...
    w10 - w10 * (K(2,1) * sin(y(1) - y(2)) + K(3,1) * sin(y(1) - y(3)) + K(4,1) * sin(y(1) - y(4)) + K(5,1) * sin(y(1) - y(5))); ...
    w20 - w20 * (K(1,2) * sin(y(2) - y(1)) + K(3,2) * sin(y(2) - y(3)) + K(4,2) * sin(y(2) - y(4)) + K(5,2) * sin(y(2) - y(5))); ...
    w30 - w30 * (K(1,3) * sin(y(3) - y(1)) + K(2,3) * sin(y(3) - y(2)) + K(4,3) * sin(y(3) - y(4)) + K(5,3) * sin(y(3) - y(5))); ...
    w40 - w40 * (K(1,4) * sin(y(4) - y(1)) + K(2,4) * sin(y(4) - y(2)) + K(3,4) * sin(y(4) - y(3)) + K(5,4) * sin(y(4) - y(5)));...
    w50 - w50 * (K(1,5) * sin(y(5) - y(1)) + K(2,5) * sin(y(5) - y(2)) + K(3,5) * sin(y(5) - y(3)) + K(4,5) * sin(y(5) - y(4)));...
    ], tspan, y0);

figure()
hold on
plot(t, v10(y(:,1)),'-')
plot(t, v20(y(:,2))  ,'-')
plot(t, v30(y(:,3))  ,'-')
plot(t, v40(y(:,4))  ,'-')
plot(t, v50(y(:,5))  ,'-')
legend('amplitude of y1','amplitude of y2','amplitude of y3','amplitude of y4','amplitude of y5')
figure()
hold on
plot(t, y(:,1),'-')
plot(t, y(:,2)  ,'-')
plot(t, y(:,3)  ,'-')
plot(t, y(:,4)  ,'-')
plot(t, y(:,5)  ,'-')
legend('phase of y1','phase of y2','phase of y3','phase of y4','phase of y5')
figure()
hold on
%plot(t,mod(y(:,1)-y(:,2), 2*pi ))
plot(t,(y(:,1)-y(:,2))./pi.*180)
plot(t,(y(:,1)-y(:,3))./pi.*180)
plot(t,(y(:,1)-y(:,4))./pi.*180)
plot(t,(y(:,1)-y(:,5))./pi.*180)
legend('phase difference 1,2','phase difference 1,3','phase difference 1,4','phase difference 1,5')

