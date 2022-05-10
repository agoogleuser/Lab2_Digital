function [outputSignal, t] = createSquareSignal(timeStart, timeOn, timeEnd, numOfSamples)

  t = linspace(0, timeEnd, numOfSamples);
  [~,T_end]   = min(abs(t - timeOn));     %Return the nearest index for the given timeOn in the vector t
  [~,T_start] = min(abs(t - timeStart));
  %T_end--;  %optimize it for the output signal
  %T_start--;%Makes the signal begins with 1 instead of 0 if timeStart == 0;
  outputSignal =[zeros(1,T_start) ones(1, T_end-T_start) zeros(1, numOfSamples - T_end)];

end

