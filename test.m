f = @(t,y) custom_function(t, y);

u = @(t,y)[ ...
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
    ];


n = 10;
w = ones(n,1);
k = ones(n);
ccc= cell(n,1);
for i = 1:n
    if i == 1
        ccc{i} = strcat('@(t,y)','[',give_w(i), '-', give_w(i), '*', give_k(i+1,i), '*', 'sin(', give_y(i), '-', give_y(i+1), ');');
    elseif i < n
        ccc{i} = strcat(give_w(i), '-', give_w(i), '*', give_k(i+1,i), '*', 'sin(', give_y(i), '-', give_y(i+1), ');', '-', give_w(i), '*', give_k(i-1,i), '*', 'sin(', give_y(i), '-', give_y(i-1), ');');
    else
        ccc{i} = strcat(give_w(i), '-', give_w(i), '*', give_k(i-1,i), '*', 'sin(', give_y(i), '-', give_y(i-1), ');]');
    end
    
end
disp(ccc)
new_func = str2func(strjoin(ccc, ';'));

function str = give_w(i)
    p1 = 'w(';
    p2 = num2str(i);
    p3 = ')';
    str = [p1 , p2 , p3];
end

function str = give_y(i)
    p1 = 'y(';
    p2 = num2str(i);
    p3 = ')';
    str = [p1 , p2 , p3];
end

function str = give_k(i,j)
    p1 = 'k(';
    p2 = num2str(i);
    p3 = ',';
    p4 = num2str(j);
    p5 = ')';
    str = [p1 , p2 , p3, p4 , p5];
end
