clc;
clear;

%load wav
[y,Fs] = audioread('corrupted_voice.wav');


%def parameters
T = 1/Fs;             % Sampling period       
L = 2000;             % Length of signal
t = (0:L-1)*T;        % Time vector

% Next power of 2 from length of y
NFFT = 2^nextpow2(L); 
% Apply the fft
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

%plot the signal
plot(f,2*abs(Y(1:NFFT/2+1))) 

title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

signal = 2*abs(Y(1:NFFT/2+1));
peaks = maxk(signal,6);


%filter out signals Design a filter to remove the undesired frequencies you found the in the previous question. Pass the original audio signal through the filter and upload the resulting sound in a .wav file.

%Hint: Use a band-pass filter with a range that excludes the corrupting tones. Use trial and error to find a range that includes the desired audio (the man's voice), and attenuates the corrupting tones as much as possible.

%Hint: MATLAB function butter, filter, ..

