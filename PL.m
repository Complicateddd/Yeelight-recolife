%PL函数输出序列峰值平均间期PP和谷值平均间期LL
function PP=PL(test)
% peak=find(diff(sign(diff(test)))<0)+1;%峰值点位置
% lowwest=find(diff(sign(diff(test)))>0)+1;%谷值点位置
% peak_length=length(peak);
% lowwest_length=length(lowwest);
% lowwestsum=0;
% peaksum=0;
[pks,~]=findpeaks(test);
time=2;%测量时间

PP=time*60/length(pks);
% LL=time*60/length(lowwest);
% for i=1:peak_length-1
%     peaksum=peaksum+abs(peak(i+1)-peak(i));
% end
% PP=peaksum/(peak_length-1);
% 
% for i=1:lowwest_length-1
%     lowwestsum=lowwestsum+abs(lowwest(i+1)-lowwest(i));
% end
% LL=lowwestsum/(lowwest_length-1);
% end