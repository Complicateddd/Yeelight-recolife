clear;
%读文件、数组a为数据文件（格式为cell）
file=dir('D:\大四\毕设\data\*.csv');
a=cell(1,12);
for i=1:12
    a{i}=zeros(12000,2);
end
for i=1:size(file,1)
     file_name=['D:\大四\毕设\data\',file(i).name];
     file_data=csvread(file_name,7,1);
     a{i}=file_data;
end
test=a{2}(1:500,1);
% plot(test);
% mph=0.1;
% tset1=test.';
% 
% [pks1,locs1]=findpeaks(test);
%  pp1=2*60/length(pks1);
% pp=PL(test);
% data=[3 3 3 4 5 1 7 9 8 13 78 45 6 4 9 14 32 68];
% [pks,locs]=findpeaks(test,'minpeakheight',20);  
% [rate,RR]=RRjianqi(test,100);
Fs = 100;           % Sampling Frequency
N    = 32;          % Order
Fc1  = 20;           % First Cutoff Frequency
Fc2  = 30;          % Second Cutoff Frequency
flag = 'scale';     % Sampling Flag
win = hamming(N+1); % Create the window vector for the design algorithm.
b  = fir1(N, [Fc1 Fc2]/(Fs/2), 'bandpass', win, flag); % Calculate the coefficients using the FIR1 function.
filteredA = filtfilt(b,1,test);
% plot(filteredA);
plot(test);



% Threshold = (max(filteredA) - min(filteredA))*0.7 + min(filteredA);
% [R_pks,R_locs]=findpeaks(filteredA,50,'MinPeakDistance',0.5,'MinPeakHeight',Threshold);
% rate=length(R_pks)/2;
% plot(filteredA);
%title(['第',num2str(time_watch),' 分钟 EEG'])
hold on
plot(R_locs*50,R_pks,'x');





%----mph %设定峰值的最小高度
% ef=cell(2,2);
% ef=findpeaks(test);
% [PP,LL]=PL(test);
% %[s,delt_s,s_cor]=C_CMethod(test);
% %maxlyapunov=lyapunov(test,12000,m,tau,P);
% tau=zi_xiangguan(test);
% m=cao(test,tau);
% pp=round(PP);
% lambda_1=lyapunov(test,12000,m,tau,pp);

%pks= findpeaks(test,x);