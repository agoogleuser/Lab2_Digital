%%PART 1: ISI effect in Band-Limited Channel;
%This file is without plots.
%Adding the folder path of the functions in order to run it.
addpath(genpath("Functions_Part1"));
%% Vars
figurenum=1;          % To make numbering figures easter
BW = 100e3;           % Channel Bandwidth
T = 2 / BW;           % Pulse On time
Ns= 10000;            % Number of samples
timeSequence = 3*T;   % Total time Period which the simulation will calculate
fs =Ns/timeSequence;  % Sampling Frequency
%% par1_1
%Creating Signal 1 and Signal 2 and converting them to frequency domain
[signal1_t, t] = createSquareSignal(0,T,timeSequence, Ns);
[signal2_t, ~] = createSquareSignal(T, 2*T, timeSequence, Ns);
t=t*1e6; %converting time to microseconds.
signal1_f = fftshift(fft(signal1_t));
signal2_f = fftshift(fft(signal2_t));
f = (-length(signal1_f)/2:length(signal1_f)/2-1) * (fs/Ns);

%Passing Signal 1 only into the channel.
[output1_t, output1_f, filter] = channel_A(BW, f, signal1_t); % true means print Channel Frequency response

%Passing Signal 2 only into the channel.
[output2_t, output2_f] = channel_A(BW, f, signal2_t);

%%Passing Both signal 1 and signal 2 into the channel and getting the output.
[output3_t, output3_f] = channel_A(BW, f, signal1_t, signal2_t);

%%TODO: Plot the variables.


%% Digital Source and convert it to analog, 1000 sample
signal1_t = createSquareSignal(0, T, T, Ns);
signal2_t = zeros(1, Ns);

Tx = pulseShaping([0 1 1 0 1 0 0 1], signal2_t, signal1_t);
Rx = ourDecoder(Tx, signal2_t, signal1_t)

