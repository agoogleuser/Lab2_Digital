%%PART 1: ISI effect in Band-Limited Channel;

%Adding the folder path of the functions in order to run it.s
addpath(genpath("Functions_Part1"));

figurenum=1;          % To make numbering figures easter
BW = 100e3;           % Channel Bandwidth
T = 2 / BW;           % BitRate
Ns= 10000;            % Number of samples
timeSequence = 3*T;   % Total time Period which the simulation will calculate
fs =Ns/timeSequence;  % Sampling Frequency

%Creating Signal 1 and Signal 2
[signal1_t, t] = createSquareSignal(0,T,timeSequence, Ns);
[signal2_t, ~]= createSquareSignal(T, 2*T, timeSequence, Ns);
t=t*1e6;
%Plotting Signal 1 and Signal 2 in time domain

figure
%figure(figurenum++);
subplot(2,2,1)
plot(t, signal1_t)
grid on;
xlim([0 60])
ylim([0 1.5]);
title("Signal 1 in time domain");
xlabel("time (us)");
ylabel("Amplitude (v)");

subplot(2,2,3);
plot(t, signal2_t)
grid on;
xlim([0 60])
ylim([0 1.5]);
title("Signal 2 in time domain");
xlabel("time (us)");
ylabel("Amplitude (v)");

%Converting and Plotting Signal 1 and Signal 2 in Frequency Domain
signal1_f = fftshift(fft(signal1_t));
signal2_f = fftshift(fft(signal2_t));
f = (-length(signal1_f)/2:length(signal1_f)/2-1) * (fs/Ns);

subplot(2,2,2);
plot(f/1e3, abs(signal1_f));
xlim([-200 200]);
title("Signal 1 in Frequency Domain");
xlabel("frequency (kHz)");
ylabel("Amplitude (V)");

subplot(2,2,4)
plot(f/1e3, abs(signal2_f));
grid on
xlim([-200 200]);
title("Signal 2 in Frequency Domain");
xlabel("frequency (kHz)");
ylabel("Amplitude (V)");

%Passing Signal 1 only into the channel, then plotting it in time and frequency domains.
[output1_t, output1_f] = channel_A(true,BW, f, signal1_t); % true means print Channel Frequency response

figure
%figure(figurenum++);
subplot(2,2,1);
plot(t,output1_t);
xlim([0 60])
grid on;
title("Output1 1 in Time Domain");
xlabel("time (us)");
ylabel("Amplitude (V)");

subplot(2,2,2);
plot(f/1e3, abs(output1_f));
xlim([-200 200]);
grid on;
title("Signal 1 in Frequency Domain");
xlabel("frequency (kHz)");
ylabel("Amplitude (V)");

%Passing Signal 2 only into the channel, then plotting it in time and frequency domains.
[output2_t, output2_f] = channel_A(false, BW, f, signal2_t);

subplot(2,2,3);
plot(t, output2_t);
xlim([0 60])
grid on
title("Output1 2 in Time Domain");
xlabel("time (us)");
ylabel("Amplitude (V)");

subplot(2,2,4)
plot(f/1e3, abs(output2_f));
xlim([-200 200]);
grid on
title("Signal 2 in Frequency Domain");
xlabel("frequency (kHz)");
ylabel("Amplitude (V)");

%%Passing Both signal 1 and signal 2 into the channel and getting the output.
[output3_t, output3_f] = channel_A(false, BW, f, signal1_t, signal2_t);

figure
%figure(figurenum++);
subplot(1,2,1)
plot(t, output3_t, t, output1_t, '--', t, output2_t, '--');
legend("Signal 1 and 2", "Signal 1", "Signal 2");
grid on
xlabel("time (us)");
ylabel("Amplitude (V)");

subplot(1,2,2)
plot(f/1e3, abs(output3_f), f/1e3, abs(output1_f), '--', f/1e3 , abs(output2_f), '--');
xlim([-200 200]);
grid on
legend("Signal 1 and 2", "Signal 1", "Signal 2");
xlabel("frequency (kHz)");
ylabel("Amplitude (V)");

