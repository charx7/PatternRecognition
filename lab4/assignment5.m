clc;
clear;

%load wav
[y,Fs] = audioread('corrupted_voice.wav');

%apply fft
Y = fft(y);

%def parameters
T = 1/Fs;             % Sampling period       
L = 2000;             % Length of signal
t = (0:L-1)*T;        % Time vector


%plot the signal
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%filter out signals Design a filter to remove the undesired frequencies you found the in the previous question. Pass the original audio signal through the filter and upload the resulting sound in a .wav file.

Hint: Use a band-pass filter with a range that excludes the corrupting tones. Use trial and error to find a range that includes the desired audio (the man's voice), and attenuates the corrupting tones as much as possible.

Hint: MATLAB function butter, filter, ..

