function [rate,RR]=RRjianqi(data,samplefrequency)
%RR间期单位为s
Fs = samplefrequency;           % Sampling Frequency
N    = 32;          % Order
Fc1  = 20;           % First Cutoff Frequency
Fc2  = 30;          % Second Cutoff Frequency
flag = 'scale';     % Sampling Flag
win = hamming(N+1); % Create the window vector for the design algorithm.
b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag); % Calculate the coefficients using the FIR1 function.
filteredA = filtfilt(b,1,data);
plot(filteredA);

Threshold = (max(filteredA) - min(filteredA))*0.7 + min(filteredA);
[R_pks,R_locs]=findpeaks(filteredA,50,'MinPeakDistance',0.5,'MinPeakHeight',Threshold);
rate=length(R_pks)/2;
time=1;%测量时间
RR=time*60/length(R_pks);
% RRsum=0;
% for i=1:length(R_locs)-1
%     RRsum=RRsum+abs(R_locs(i+1)-R_locs(i));
% end
% RR=RRsum/(length(R_locs)-1);
plot(filteredA);
% title(['第',num2str(time_watch),' 分钟 EEG'])
hold on
plot(R_locs*50,R_pks,'x');