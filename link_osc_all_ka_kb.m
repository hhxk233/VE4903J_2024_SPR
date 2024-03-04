function new_k = link_osc_all_ka_kb(k,n,ka,kb)
    for i = 1:n-1
        k(i,i+1) = kb;
        k(i+1,i) = ka;
    end
    new_k = k;
end