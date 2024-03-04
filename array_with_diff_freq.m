close all
n = 20;
ka = -0.1;
kb = 0.6;

wa = 2*pi*1*10^12;
wb = 2*pi*1.2*10^12;
% here set w(frequency)
w = zeros(n,1);
for i = 1:n
    if mod(i,2) == 1
        w(i) = wa; 
    else
        w(i) = wb; 
    end
end
% here set k(interaction)
k = zeros(n);
k = link_osc_all_ka_kb(k,n,ka,kb);

for i = 1:n/2
    k(2*i,2*i-1)=0;
end


k_time = 4;
tend = k_time * 40*10^-12;
tspan = 0 : tend/10^4/4/k_time : tend;

%give a ramdom initial phase
y0 = 0.5*pi*rand(n,1);
y0(1) = 0;
[t,y] = ode78(@(t,y)get_func(t,y,w,k,n), tspan, y0);

reference = 1;

figure()
hold on
for i = 1:n
    plot(t, y(:,i),'-',LineWidth=1,DisplayName=strcat('phase of y',num2str(i)));
end
legend
%legend({'phase of y1','phase of y2','phase of y3','phase of y4','phase of y5','phase of y6','phase of y7','phase of y8','phase of y9'})
xlabel('time(s)')
ylabel('phase(rad)')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')

if n > 20
    plot_number = 20;
else
    plot_number = n;
end
plot_number = 10;
figure()
hold on
for i = 1:plot_number /2
    plot(t,mod(y(:,reference)-y(:,2*i), 0 ),'-',LineWidth=1,DisplayName=strcat("phase difference ",num2str(reference),", ",num2str(2*i)));
end

legend
xlabel('time(s)')
ylabel('phase(rad)')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')



for i = 1:plot_number /2-1
    plot(t,mod(y(:,2)-y(:,2*i+1), 0),'-',LineWidth=1,DisplayName=strcat("phase difference ",num2str(reference),", ",num2str(2*i+1)));
end
legend
xlabel('time(s)')
ylabel('phase(rad)')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')

figure()
hold on
for i = reference:plot_number-1
        plot(t,mod(y(:,i)-y(:,i+1), 0),'-',LineWidth=1,DisplayName=strcat("phase difference"+" ",num2str(i),', ' ,num2str(i+1)));
end

%plot(t,asin((wa-wb)/(wb*kb))*ones(size(t)),'k',LineWidth=2,DisplayName='theoretical value1')
%plot(t,asin((wa-wb)*ka/(wb*kb^2))*ones(size(t)),LineWidth=2,DisplayName='theoretical value2')
%plot(t,asin((wa-wb)*(1+ka^2/kb^2)/(wb*kb))*ones(size(t)),LineWidth=2,DisplayName='theoretical value3')
disp(asin((wa-wb)/(wb*kb)))
disp(asin((wa-wb)*ka/(wb*kb^2)))
disp(asin((wa-wb)*(1+ka^2/kb^2)/(wb*kb)))
legend
xlabel('time(s)')
ylabel('phase(rad)')
title('difference betwen pairs')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')




