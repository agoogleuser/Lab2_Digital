%% PART 1: ISI effect in Band-Limited Channel;
%This file is without plots.
%Adding the folder path of the functions in order to run it.
addpath(genpath("Functions_Part1"));
%%Vars
BW = 100e3;                         % Channel Bandwidth
T  = 2 / BW;                        % Pulse On time
Ns = 1e6;                           % Number of samples
Fs = 10e6;                          % Sampling Frequency
Ts = 1/Fs;                          % Sampling Time

t  = (0:Ns-1) * Ts;                 % Time Vector
f  = (-0.5*Ns:0.5*Ns-1) * Fs/Ns;    % Frequency Vector

noisePower = 10;
bitsNum = 4000;
n=1:bitsNum;

%% par1_1
%Creating Signal 1 and Signal 2 and converting them to frequency domain
signal1_t = createSquareSignal(0,T,t);
signal2_t = createSquareSignal(T+Ts, 2*T, t);
signal1_f = fftshift(fft(signal1_t));
signal2_f = fftshift(fft(signal2_t));

%Passing Signal 1 only into the channel.
[output1_t, output1_f, filter] = channel_A(0,BW, f, signal1_t); % true means print Channel Frequency response

%Passing Signal 2 only into the channel.
[output2_t, output2_f] = channel_A(0,BW, f, signal2_t);

%%Passing Both signal 1 and signal 2 into the channel and getting the output.
[output12_t, output12_f] = channel_A(0,BW, f, signal1_t, signal2_t);

%% Part1_2:
%Using Raised Cosine Pulse insteade of a square pulse, same as above.
signal3_t = 100 * createRaisedCosine(T, 0, 1, 100e3, f, t);
signal4_t = 100 * createRaisedCosine(T, T, 1, 100e3, f, t);
signal3_f = fftshift(fft(signal3_t));
signal4_f = fftshift(fft(signal4_t));

[output3_t, output3_f] = channel_A(0,BW, f, signal3_t);
[output4_t, output4_f] = channel_A(0,BW, f, signal4_t);
[output34_t, output34_f] = channel_A(0,BW, f, signal3_t, signal4_t);

%% Digital Source and convert it to analog
signal5_t = -signal3_t;
signal5_f = fftshift(fft(signal5_t));


message = randi([0 1], 1, bitsNum);

Tx_t = pulseShaping(message, signal5_t, signal3_t, T, t);
Rx_t = channel_A(noisePower, BW, f, Tx_t);
%% Decoding Message and Computing BER
recvMsg = ourDecoder(Rx_t, signal5_t, signal3_t, T, t);
recvMsg = recvMsg(1:bitsNum);
BER = ComputeBER(message, recvMsg);

%% Repeating for square pulses

Tx_t2 = pulseShaping(message, signal1_t, -signal1_t, T, t);
Rx_t2 = channel_A(noisePower, BW, f, Tx_t);
%% Decoding Message and Computing BER
recvMsg2 = ourDecoder(Rx_t2, signal1_t, -signal3_t, T, t);
recvMsg2 = recvMsg2(1:bitsNum);
BER2 = ComputeBER(message, recvMsg);

%% Plotting the variables
figurenum=1;
%Square Wave Test
figure(figurenum)
figurenum=figurenum+1;
subplot(2,2,1)
plot(t, signal1_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 1 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal1_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 1 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, signal2_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(signal2_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%------------------------%
figure(figurenum)
figurenum=figurenum+1;

subplot(1,2,1)
plot(t, signal1_t, t, signal2_t, '--')
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 1 and 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(1,2,2)
plot(f, abs(signal1_f), f, abs(signal2_f), '--')
xlim([-2*BW 2*BW]);
grid on;
title('Signal 1 and 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%----------channel--------------%
figure(figurenum)
figurenum=figurenum+1;
plot(f, abs(filter))
xlim([-2*BW 2*BW]);
ylim([0 1.5])
grid on;
title('Channel Effect')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%--------input and output--------%
figure(figurenum)
figurenum=figurenum+1;

%---inputs
subplot(4,2,1)
plot(t, signal1_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 1 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,3)
plot(f, abs(signal1_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 1 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(4,2,5)
plot(t, signal2_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,7)
plot(f, abs(signal2_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%----outputs
subplot(4,2,2)
plot(t, output1_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 1 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,4)
plot(f, abs(output1_f))
xlim([-2*BW 2*BW]);
grid on;
title('Output 1 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(4,2,6)
plot(t, output2_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,8)
plot(f, abs(output2_f))
xlim([-2*BW 2*BW]);
grid on;
title('Output 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%---------both inputs and outputs---------%
figure(figurenum)
figurenum=figurenum+1;

subplot(2,2,1)
plot(t, signal1_t, t, signal2_t, '--')
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 1 and 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal1_f), f, abs(signal2_f), '--')
xlim([-2*BW 2*BW]);
grid on;
title('Signal 1 and 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, output1_t, t, output2_t, '--')
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 1 and 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(output1_f), f, abs(output2_f), '--')
xlim([-2*BW 2*BW]);
grid on;
title('Output 1 and 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

figure(figurenum)
figurenum=figurenum+1;

subplot(2,2,1)
plot(t, signal1_t + signal2_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 1 and 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal1_f + signal2_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 1 and 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, output12_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 1 and 2 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(output12_f))
xlim([-2*BW 2*BW]);
grid on;
title('Output 1 and 2 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%
%-------------Raised Cosine Filter-------------%

figure(figurenum)
figurenum=figurenum+1;
subplot(2,2,1)
plot(t, signal3_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 3in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal3_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 3 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, signal4_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(signal4_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%------------------------%
figure(figurenum)
figurenum=figurenum+1;

subplot(1,2,1)
plot(t, signal3_t, t, signal4_t, '--')
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 3 and 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(1,2,2)
plot(f, abs(signal3_f), f, abs(signal4_f), '--')
xlim([-2*BW 2*BW]);
grid on;
title('Signal 3 and 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%--------input and output--------%
figure(figurenum)
figurenum=figurenum+1;

%---inputs
subplot(4,2,1)
plot(t, signal3_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 3 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,3)
plot(f, abs(signal3_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 3 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(4,2,5)
plot(t, signal4_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,7)
plot(f, abs(signal4_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%----outputs
subplot(4,2,2)
plot(t, output3_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 3 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,4)
plot(f, abs(output3_f))
xlim([-2*BW 2*BW]);
grid on;
title('Output 3 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(4,2,6)
plot(t, output4_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(4,2,8)
plot(f, abs(output4_f))
xlim([-2*BW 2*BW]);
grid on;
title('Output 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%---------both inputs and outputs---------%
figure(figurenum)
figurenum=figurenum+1;

subplot(2,2,1)
plot(t, signal3_t, t, signal4_t, '--')
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 3 and 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal3_f), f, abs(signal4_f), '--')
xlim([-2*BW 2*BW]);
grid on;
title('Signal 3 and 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, output3_t, t, output4_t, '--')
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 3 and 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(output3_f), f, abs(output4_f), '--')
xlim([-2*BW 2*BW]);
grid on;
title('Output 3 and 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

figure(figurenum)
figurenum=figurenum+1;

subplot(2,2,1)
plot(t, signal3_t + signal4_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Signal 3 and 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal3_f + signal4_f))
xlim([-2*BW 2*BW]);
grid on;
title('Signal 3 and 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, output34_t)
ylim([-1.5 1.5]);
xlim([0 3*T]);
grid on;
title('Output 3 and 4 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(output34_f))
xlim([-2*BW 2*BW]);
grid on;
title('Output 3 and 4 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%----------------Pulse Shaping----------------%
%----Signals used in Pulse Shaping
figure(figurenum)
figurenum=figurenum+1;
subplot(2,2,1)
plot(t, signal3_t)
ylim([-1.5 1.5]);
xlim([0 2*T]);
grid on;
title('Symbol for 1 in Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,3)
plot(f, abs(signal3_f))
xlim([-2*BW 2*BW]);
grid on;
title('Symbol for 1 in Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

subplot(2,2,2)
plot(t, signal5_t)
ylim([-1.5 1.5]);
xlim([0 2*T]);
grid on;
title('Symbol for 0 Time Domain')
xlabel('time (sec)')
ylabel('Amplitude (v)')

subplot(2,2,4)
plot(f, abs(signal5_f))
xlim([-2*BW 2*BW]);
grid on;
title('Symbol for 0 Frequency Domain')
xlabel('Frequency (Hz)')
ylabel('Amplitude (v)')

%-----sample of pulse shaping-----%

figure(figurenum)
figurenum=figurenum+1;
subplot(2,1,1)
plot(t,Tx_t,'--', t, Rx_t)
xlim([0 15*T])
ylim([-1.5 1.5])
grid on;
title ("Pulse Shaping A random signal using Raised Cosine Pulse")
xlabel('time (sec)')
ylabel('Amplitude (v)')
legend('Transmitted Signal', 'Received Signal')

subplot(2,1,2)
plot(t,Tx_t2,'--', t, Rx_t2)
xlim([0 15*T])
ylim([-1.5 1.5])
grid on;
title ("Pulse Shaping A random signal using Square Pulse")
xlabel('time (sec)')
ylabel('Amplitude (v)')
legend('Transmitted Signal', 'Received Signal')

%-Error bits in both messages-%

figure(figurenum)
figurenum=figurenum+1;
plot(n, xor(message,recvMsg), 'bo',n, xor(message,recvMsg2)-0.1, 'ro')
ylim([0.5 1.5])
grid on;
title('Error bits in Received signal')
xlabel('position (n)');
legend('Raised Cosine Filter', 'Square Wave');
