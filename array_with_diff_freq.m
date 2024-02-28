close all

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
for i = 1:n-1
    k(i,i+1) = kb;
    k(i+1,i) = ka;
end

k_time = 4;
tend = k_time * 40*10^-12;
tspan = 0 : tend/10^4/4/k_time : tend;

%give a ramdom initial phase
y0 = 0.5*pi*rand(10,1);

[t,y] = ode78(@(t,y)get_func(t,y,w,k,n) ...
    , tspan, y0);


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

figure()
hold on
for i = 1:n/2
    plot(t,mod(y(:,1)-y(:,2*i), 2*pi ),'-',LineWidth=1,DisplayName=strcat('phase difference 1,',num2str(2*i)));
end

legend
xlabel('time(s)')
ylabel('phase(rad)')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')

figure()
hold on
hold on
for i = 1:n/2-1
    plot(t,mod(y(:,1)-y(:,2*i+1), 2*pi ),'-',LineWidth=1,DisplayName=strcat('phase difference 1,',num2str(2*i+1)));
end
legend
xlabel('time(s)')
ylabel('phase(rad)')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')

figure()
hold on
for i = 1:n/2
    if i == 1
        plot(t,mod(y(:,1)-y(:,2*i), 2*pi ),'-',LineWidth=1,DisplayName=strcat('phase difference 1,',num2str(2*i)));
    else
        plot(t,mod(y(:,2*(i-1))-y(:,2*i), 2*pi ),'-',LineWidth=1,DisplayName=strcat("phase difference"+" ",num2str(2*(i-1)),', ' ,num2str(2*i)));

    end
end

plot(t,asin((w10-w20)/(w10*ka+w20*kb))*ones(size(t))+2*pi,LineWidth=2,DisplayName='theoretical value')
legend
xlabel('time(s)')
ylabel('phase(rad)')
title('difference betwen pairs')
set(gca, 'linewidth', 1.1, 'fontsize', 16, 'fontname', 'times')


function func = get_func(t,y,w,k,n)
    func= zeros(n,1);
    for i = 1:n
        if i == 1
            func(1)= w(1) - w(1) * k(2,1) * sin(y(1) - y(2));
        elseif i < n
            func(i) = w(i) - w(i) * k(i-1,i) * sin(y(i) - y(i-1)) - w(i) * k(i+1,i) * sin(y(i) - y(i+1));
        else
            func(n) = w(i) - w(i) * k(i-1,i) * sin(y(i) - y(i-1));
        end
        
    end
    %disp(ccc)
    %func = str2func(strjoin(ccc, ';'));
end

