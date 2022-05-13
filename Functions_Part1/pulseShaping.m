function outputSequence = pulseShaping(bitsVector, symbol_0, symbol_1, symbolPeriod, timeVector)

    lenSymb = length(symbol_0);
    if (lenSymb ~= length(symbol_1))
        error("The two symbols must have equal lengths");
    end
    lenBits = length(bitsVector);
    
    outputSequence = zeros(1,lenSymb);
    [~, symbolPeriodPlace] = min(abs(timeVector - symbolPeriod)); 
    for i=1:lenBits
        if ( bitsVector(i) == 0)
            outputSequence = outputSequence + circshift(symbol_0, (i-1)*symbolPeriodPlace);
        else
            outputSequence = outputSequence + circshift(symbol_1, (i-1)*symbolPeriodPlace);
        end
    end
end
