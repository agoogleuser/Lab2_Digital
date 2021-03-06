function [outputSignal] = createSquareSignal(timeStart, timeOn, timeVecotr)

  t = timeVecotr;
  numOfSamples = length(t);
  [~,T_end]   = min(abs(t - timeOn));     %Return the nearest index for the given timeOn in the vector t
  [~,T_start] = min(abs(t - timeStart));
  %T_end = T_end - 1 ;  %optimize it for the output signal
  T_start = T_start-1;%Makes the signal begins with 1 instead of 0 if timeStart == 0;
  outputSignal =[zeros(1,T_start) ones(1, T_end-T_start) zeros(1, numOfSamples - T_end)];

end

