%% PART 1: ISI effect in Band-Limited Channel;
%This file is without plots.
%Adding the folder path of the functions in order to run it.
addpath(genpath("Functions_Part1"));
%%Vars
figurenum=1;                        % To make numbering figures easter
BW = 100e3;                         % Channel Bandwidth
T  = 2 / BW;                        % Pulse On time
Ns = 1e6;                           % Number of samples
Fs = 10e6;                          % Sampling Frequency
Ts = 1/Fs;                          % Sampling Time

t  = (0:Ns-1) * Ts;                 % Time Vector
f  = (-0.5*Ns:0.5*Ns-1) * Fs/Ns;    % Frequency Vector

%% par1_1
%Creating Signal 1 and Signal 2 and converting them to frequency domain
signal1_t = createSquareSignal(0,T,t);
signal2_t = createSquareSignal(T, 2*T, t);
signal1_f = fftshift(fft(signal1_t));
signal2_f = fftshift(fft(signal2_t));

%Passing Signal 1 only into the channel.
[output1_t, output1_f, filter] = channel_A(0,BW, f, signal1_t); % true means print Channel Frequency response

%Passing Signal 2 only into the channel.
[output2_t, output2_f] = channel_A(0,BW, f, signal2_t);

%%Passing Both signal 1 and signal 2 into the channel and getting the output.
[output3_t, output3_f] = channel_A(0,BW, f, signal1_t, signal2_t);

%% TODO: Plot the variables.


%% Digital Source and convert it to analog
signal1_t = createSquareSignal(0, T, t);
signal2_t = zeros(1, Ns);
message = [1 1 0 0 1 1 0 1 0 1];

Tx_t = pulseShaping(message, signal2_t, signal1_t, T, t);
Rx_t = channel_A(10, BW, f, Tx_t);

figure;
subplot(2,2,1)
plot(t, Tx_t)
xlim([0 T*length(message)])
grid on;

subplot(2,2,3)
plot(t, Rx_t)
xlim([0 T*length(message)])
grid on;
