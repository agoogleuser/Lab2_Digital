function received_bits = ourDecoder(Rx_analog, symbol_0, symbol_1, symbolPeriod, timeVector)
    %%1. Find optimal Vth* and T*
    Vopt=0; Topt=1;
    [~,T_end]   = min(abs(timeVector - symbolPeriod));
    %debugging   
    %plot(timeVector,symbol_0,timeVector,symbol_1); xlim([0 symbolPeriod]);
    for i = 1:T_end
        cmp = symbol_0(i) - symbol_1(i);
        if (abs(cmp) > abs(Vopt) )
            Vopt =cmp; %Vopt here is used as a temporary value;
            Topt = i;
        end
    end
    Vopt = 0.5*(symbol_0(Topt) + symbol_1(Topt));
    %%2. Decoding
    received_bits = zeros(1, ceil(timeVector(end)/symbolPeriod));
    k=1;
    %plot(timeVector, Rx_analog) debugging
    %hold on
    for i=Topt:T_end:length(Rx_analog)
        if (Rx_analog(i) >= Vopt)
            received_bits(k) = 1;
        else
            received_bits(k) = 0;
        end 
        k = k + 1;
        %plot(timeVector(i:i+1), [2 -2], 'r--'); %debugging
    end

end