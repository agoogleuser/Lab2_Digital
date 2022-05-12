function [op_f,f] = Raisedfilter(T,B, Ns)
    f = 0:ceil(Ns/2)-1;
    limit1 = (1-B)/(2*T);
    limit2 = (1+B)/(2*T);
    const1 = (pi*T/B);

    op_f = zeros(1, Ns/2);
    for i = f+1
        if (i<=limit1)
            op_f(i) = 1;
        elseif (i <= limit2 && i > limit1)
            op_f(i) = 0.5*(1+cos(const1*(f(i) - limit1)));
        else
            break;
        end
    end
    op_f = [op_f(end:-1:2) op_f(1:end) 0];
    f = -Ns/2:Ns/2-1;
    
end
