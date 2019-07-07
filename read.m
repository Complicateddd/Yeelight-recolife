clear;
tic
%读文件、数组a为数据文件（格式为cell）
clear;
tic
%读文件、数组a为数据文件（格式为cell）
file=dir('D:\大四\毕设\生理数据采集\陆竹风\*.csv');
a=cell(1,12);
for i=1:12
    a{i}=zeros(12000,2);
end
for i=1:size(file,1)
     file_name=['D:\大四\毕设\生理数据采集\陆竹风\',file(i).name];
     file_data=csvread(file_name,7,1);
     a{i}=file_data;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for data_number=1:12
 
  %定义时域指标为10
time_index_number=10;
%定义名称数组
% time_index_name={'平均值', '方差','标准差','最大值','最小值','面积','一阶差分','二阶差分','RR间期s','偏度','峰度'};
% %定义ecg信号、rsp信号result数组，长度为（time_index)
ecg_result=cell(1,time_index_number);
rsp_result=cell(1,time_index_number);

%取序列长度值length=12000
length=12000;
data_first_column=a{data_number}(1:length,1);%取ecg信号
ecg_result{1}=mean(data_first_column);%均值
ecg_result{2}=var(data_first_column);%方差
ecg_result{3}=std(data_first_column);%标准差
ecg_result{4}=max(data_first_column);%最大值
ecg_result{5}=min(data_first_column);%最小值
ecg_result{6}=sum(data_first_column);%面积
ecg_result{7}=sum(abs(diff(data_first_column)))/(length-1);%一阶差分
ecg_result{8}=sum(abs(diff(diff(data_first_column))))/(length-2);%二阶差分
ecg_result{9}=skewness(data_first_column);% 偏度
ecg_result{10}= kurtosis(data_first_column);% 峰度




%%%[PP1,LL1]=PL(data_first_column);%计算平均峰峰值间隔PP和谷谷值间隔LL
% tau1=zi_xiangguan(data_first_column);%计算时间延迟
% m1=cao(data_first_column,tau1);%计算嵌入维数

%%%
%     [rate,RR]=RRjianqi(data_first_column,100);
%     ecg_result{9}=RR;
%

 
% pp1=round(RR);%PP值取整
%%%ecg_result{9}=lyapunov(data_first_column,length,m1,tau1,pp1);%李雅诺夫指数

%%取ecg信号
data_second_column=a{data_number}(1:length,2);
rsp_result{1}=mean(data_second_column);%均值
rsp_result{2}=var(data_second_column);%方差
rsp_result{3}=std(data_second_column);%标准差
rsp_result{4}=max(data_second_column);%最大值
rsp_result{5}=min(data_second_column);%最小值
rsp_result{6}=sum(data_second_column);%面积
rsp_result{7}=sum(abs(diff(data_second_column)))/(length-1);%一阶差分
rsp_result{8}=sum(abs(diff(diff(data_second_column))))/(length-2);%二阶差分


% [rate,RR]=RRjianqi(data_first_column,100);
% ecg_result{9}=RR;
%
rsp_result{9}=skewness(data_second_column);% 偏度
rsp_result{10}= kurtosis(data_second_column);% 峰度
%
% PP2=PL(data_second_column);%计算平均峰峰值间隔PP
% tau2=zi_xiangguan(data_second_column);%计算时间延迟
% m2=cao(data_second_column,tau2);%计算嵌入维数
% pp2=round(PP2);%PP值取整
%
% rsp_result{9}=lyapunov(data_second_column,length,m2,tau2,pp2);%李雅诺夫指数
% %峰峰值

% rsp_result{9}=PP2;

txt_file_name=['D:\大四\毕设\data\',file(data_number).name,'.txt'];
%%%%%%%%%%%%写出数值
fp = fopen(txt_file_name,'wt');
fprintf(fp,'%s','ecg');

for j=1:time_index_number
    
    fprintf(fp,'\r\n');
    fprintf(fp, '%s', time_index_name{j});
    fprintf(fp,'\r\n');
    fprintf(fp, '%g',ecg_result{j});
    fprintf(fp,'\r\n');
   
    
end
fprintf(fp,'%s','rsp');
fprintf(fp,'\r\n');

for k=1:time_index_number
  
%     fprintf(fp,'\r\n');
%     fprintf(fp, '%s', time_index_name{k});
%     fprintf(fp,'\r\n');
    fprintf(fp, '%g',rsp_result{k});
    fprintf(fp,'\r\n');
  
end
fclose(fp);
end
toc

    
%%%%%%%%%%%%






% %数据导入
% data=xlsread('E:\排球\原始数据 z方向.xlsx',1)';
% %初始参数设置
% [m,n]=size(data);
% D=[];
% DA=[];
% %求解特征
% for i=1:1:m
%     d=data(i,:)
%     d=d(~isnan(d));%去除NAN值 
%     ave=mean(d);%均值
%     u=std(d);%标准差
%     time=length(d);%时间
%     theta=var(d);%方差
%     area=sum(abs(d));%面积
%     maxv=max(d);%最大值
%     minv=min(d);%最小值
%     [dd,minp,maxp]=premnmx(d);  %求解信息熵
%     entropy=yyshang(dd,9);%信息熵
%     D=[D;ave;maxv;minv;u;area;time;theta;entropy];
%     DA=[DA,D];
%     D=[];
% end
% DA=DA';
% 
% --------------------- 
% 作者：Melo0705 
% 来源：CSDN 
% 原文：https://blog.csdn.net/Melo0705/article/details/80888803 
% 版权声明：本文为博主原创文章，转载请附上博文链接！
 
