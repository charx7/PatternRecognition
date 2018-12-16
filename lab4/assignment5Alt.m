clc;
clear;

%load wav
[sample_data,sample_rate] = audioread('corrupted_voice.wav');
% Plot it

% Get the sample rate
sample_period = 1/sample_rate;
t = (0:sample_period:(length(sample_data)-1)/sample_rate);
plot(t,sample_data)

% Plot the unfiltered sound
title('Time Domain Representation - Unfiltered Sound')
xlabel('Time (seconds)')
ylabel('Amplitude')
xlim([0 t(end)])

% Original sample length.
m = length(sample_data); 
% Transforming the length so that the number of 
% samples is a power of 2. 
n = pow2(nextpow2(m)); 

% Do the fft
y = fft(sample_data, n);

% Plot stuff
f = (0:n-1)*(sample_rate/n);
% Find peaks
peaks = maxk(f,2);

amplitude = abs(y)/n;
% Plot the freq domain rep
plot(f(1:floor(n/2)),amplitude(1:floor(n/2)))
title('Frequency Domain Representation - Unfiltered Sound')
xlabel('Frequency')
ylabel('Amplitude')

% Plot the corrupted one
%sound(sample_data, sample_rate)

% Filter the audio sample data to remove the noise from the signal
order = 10;
[b,a] = butter(order,[0.15, .80],'stop');
filtered_sound = filter(b,a,sample_data);
sound(filtered_sound, sample_rate)

% Write the file
%audiowrite('normal_voice.wav', filtered_sound, sample_rate);
