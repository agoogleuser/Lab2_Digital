function op_f = raisedFilter(r,Bandwidth, f)
    

%Constants for Equation
    f0 = Bandwidth/(1+r);
    fd = Bandwidth-f0;
    f1 = f0 - fd;

    op_f = zeros(1,length(f));
    for i = 1:length(f)
        if (abs(f(i)) < f1)
            op_f(i)=1;
        elseif (abs(f(i))>= f1 && abs(f(i)) < Bandwidth)
            op_f(i) = 0.5*(1+cos(pi/2/fd*(abs(f(i))-f1)));
        else
            op_f(i) = 0;
        end
    end
end
