%% =========================================================================
% DL
% Daitu
% 进行一次测试，查看函数是否正确运行
%% =========================================================================
clear;
close all; 
clc;
% Load training and testing data
DataPath   = 'Random_face_features_AR.mat';
load(DataPath);
% Column normalization   6450，123
A = normcol_equal(A);
[TrData,TtData,TrLabel,TtLabel]=ExtractData(A,20,labels,6450);
DictSize = 5;
alpha = 0.0005;
beta  = 0.005;
gamma = 0.5;
Iter = 20;
% SLatDPL trainig
tic
[ S_Mat,P_Mat,L_Mat,D_Mat] = TrainSLatDPL3( TrData, TrLabel,DictSize, alpha, beta,gamma, Iter );
TrTime = toc
% SLatDPL testing
tic
[~,PredictLabel] = ClassificationSLatDPL( TtData , D_Mat,L_Mat,P_Mat);
TtTime = toc
% Show accuracy and time
Acc = sum(TtLabel==PredictLabel)/size(TtLabel,2);
disp(['最大值Acc：',num2str(Acc),'   alpha:',num2str(alpha),'   beta:',num2str(beta)])
