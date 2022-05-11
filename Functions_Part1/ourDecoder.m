function received_bits = ourDecoder(Rx_analog, symbol_0, symbol_1)
    %%%%No Filter Design
    %%1. Find optimal Vth* and T*
    Vopt=0; Topt=1;
    for i = 1:length(symbol_0)
        cmp = (abs(symbol_0(i)) - abs(symbol_1(i)));
        if (abs(cmp) > abs(Vopt) )
            Vopt =cmp; %Vopt here is used as a temporary value;
            Topt = i;
        end
    end
    Vopt = 0.5*(symbol_0(Topt) + symbol_1(Topt));
    %%2. Decoding
    received_bits = zeros(1,ceil(length(Rx_analog)/length(symbol_0)));
    k=1;
    for i=Topt:length(symbol_0):length(Rx_analog)
        if (Rx_analog(i) >= Vopt)
            received_bits(k) = 1;
        else
            received_bits(k) = 0;
        end 
        k = k + 1;
    end

end