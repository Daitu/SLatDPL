function [TrData,TtData,Trlabel,Ttlabel]=ExtractData(A,number,labels,rngseed)

%% split train data and test data 
% input:
% A : data matrix (teature number * sample number)
% number:each class train data number
% labels: vector,A's labels
% rngseed : random seed
% output
% TrData,: train data
% TtData,: test data
% Trlabel,:train data lables
% Ttlabel: test data labels
%% 
rng(rngseed,'twister')
featnum=size(A,1);
classnumber=length(unique(labels));
TrData=zeros(featnum,number*classnumber);
TtData=zeros(featnum,size(A,2)-number*classnumber);
Trlabel=zeros(1,number*classnumber);
Ttlabel=zeros(1,size(A,2)-number*classnumber);

%% split data
lab = unique(labels);
numstar_r = 1;
numstar_t = 1;
for i=1:classnumber
    T=find(labels==lab(i));
    Tempdatai = A(:,T);
    Templabeli = labels(T);
    Index=randperm(length(T));
    L = length(T); % each class number
    TrData(:,numstar_r:(numstar_r+number-1)) = Tempdatai(:,Index(1:number));
    Trlabel(:,numstar_r:(numstar_r+number-1)) = Templabeli(:,Index(1:number));
    TtData(:,numstar_t:(numstar_t+(L-number-1))) = Tempdatai(:,Index((number+1):end));
    Ttlabel(:,numstar_t:(numstar_t+(L-number-1))) = Templabeli(:,Index((number+1):end));
    numstar_r = numstar_r + number;
    numstar_t = numstar_t + L - number;
    
end