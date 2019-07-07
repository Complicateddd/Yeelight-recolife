clear;
tic
%读文件、数组a为数据文件（格式为cell）
file=dir('D:\大四\毕设\生理数据采集\LJR\*.csv');
a=cell(1,12);
for i=1:12
    a{i}=zeros(12000,2);
end
for i=1:size(file,1)
     file_name=['D:\大四\毕设\生理数据采集\LJR\',file(i).name];
     file_data=csvread(file_name,7,1);
     a{i}=file_data;
end
% b=cell(1,12);
ecg_result=cell(1,12);
rsp_result=cell(1,12);
for data_number=1:12
 
  %定义时域指标为10
time_index_number=13;


%取序列长度值length=12000
length=6000;
data_first_column=a{data_number}(1:length,1);%取ecg信号
ecg_result{data_number}(1)=mean(data_first_column);%均值
ecg_result{data_number}(2)=var(data_first_column);%方差
ecg_result{data_number}(3)=std(data_first_column);%标准差
ecg_result{data_number}(4)=max(data_first_column);%最大值
ecg_result{data_number}(5)=min(data_first_column);%最小值
ecg_result{data_number}(6)=sum(data_first_column);%面积
ecg_result{data_number}(7)=sum(abs(diff(data_first_column)))/(length-1);%一阶差分
ecg_result{data_number}(8)=sum(abs(diff(diff(data_first_column))))/(length-2);%二阶差分

%%%[PP1,LL1]=PL(data_first_column);%计算平均峰峰值间隔PP和谷谷值间隔LL
% tau1=zi_xiangguan(data_first_column);%计算时间延迟
% m1=cao(data_first_column,tau1);%计算嵌入维数

%%%
%     [rate,RR]=RRjianqi(data_first_column,100);
%     ecg_result{9}=RR;
%
ecg_result{data_number}(9)=skewness(data_first_column);% 偏度
ecg_result{data_number}(10)= kurtosis(data_first_column);% 峰度
ecg_result{data_number}(11)=rms(data_first_column)/mean(abs(data_first_column))    ;% 波形因子
ecg_result{data_number}(12)=(max(data_first_column)-min(data_first_column))/mean(abs(data_first_column));%峰值因子
ecg_result{data_number}(13)=sum(data_first_column.^4)/sqrt(sum(data_first_column.^2))	;%峭度因子
[rate,RR]=RRjianqi(data_first_column,100);
ecg_result{data_number}(14)=RR;
% % pp1=round(RR);%PP值取整
% %%%ecg_result{9}=lyapunov(data_first_column,length,m1,tau1,pp1);%李雅诺夫指数
% 
% %%取ecg信号
data_second_column=a{data_number}(1:length,2);
rsp_result{data_number}(1)=mean(data_second_column);%均值
rsp_result{data_number}(2)=var(data_second_column);%方差
rsp_result{data_number}(3)=std(data_second_column);%标准差
rsp_result{data_number}(4)=max(data_second_column);%最大值
rsp_result{data_number}(5)=min(data_second_column);%最小值
rsp_result{data_number}(6)=sum(data_second_column);%面积
rsp_result{data_number}(7)=sum(abs(diff(data_second_column)))/(length-1);%一阶差分
rsp_result{data_number}(8)=sum(abs(diff(diff(data_second_column))))/(length-2);%二阶差分


% [rate,RR]=RRjianqi(data_first_column,100);
% ecg_result{9}=RR;
%
rsp_result{data_number}(9)=skewness(data_second_column);% 偏度
rsp_result{data_number}(10)= kurtosis(data_second_column);% 峰度
rsp_result{data_number}(11)=rms(data_second_column)/mean(abs(data_second_column))    ;% 波形因子
rsp_result{data_number}(12)=(max(data_second_column)-min(data_second_column))/mean(abs(data_second_column));%峰值因子
rsp_result{data_number}(13)=sum(data_second_column.^4)/sqrt(sum(data_second_column.^2))	;%峭度因子
PP1=PL(data_second_column);
rsp_result{data_number}(14)=PP1;

end
ecg=[12,28];
for u=1:12
    ecg(u,1:14)=ecg_result{u};
    ecg(u,15:28)=rsp_result{u};
end