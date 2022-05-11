function outputSequence = pulseShaping(bitsVector, symbol_0, symbol_1)

    lenSymb = length(symbol_0);
    if (lenSymb ~= length(symbol_1))
        error("The two symbols must have equal lengths");
    end
    lenBits = length(bitsVector);
    
    outputSequence = zeros(1,lenBits*lenSymb);
    
    for i=1:lenBits
        if ( bitsVector(i) == 0)
            outputSequence((i-1)*lenSymb+1:(i)*lenSymb) = symbol_0;
        else
            outputSequence((i-1)*lenSymb+1:(i)*lenSymb) = symbol_1;
        end
    end
    plot(1:length(outputSequence), outputSequence)

    %%not efficient but reliable.
%     outputSequence = [];
% 
%     for i = bitsVector
%         if (i == 0)
%             outputSequence = [outputSequence symbol_0];
%         else
%             outputSequence = [outputSequence symbol_1];
%         end
%     end

end
