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