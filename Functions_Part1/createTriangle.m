function output = createTriangle(timeStart, timeOn, timeVector)
  numOfSamples = length(timeVector);
  [~,T_end]   = min(abs(timeVector - timeOn));     %Return the nearest index for the given timeOn in the vector t
  [~,T_start] = min(abs(timeVector - timeStart));
  Ts = timeVector(2)-timeVector(1);
  output = zeros(1,length(timeVector));
  period = T_end - T_start;
  rampUp  = linspace(0,1,period*0.5+1);
  rampDown= rampUp(end-1:-1:1);
  
  output(T_start:T_end) = [rampUp rampDown];
end