function [ L_Mat ] = UpdateL( S_Mat,  Data, DataInvMat, alpha,beta,gamma)
%% Update L
% input:
% Dict: Dictionary D
% W_Mat : Adaptive Representations 
% Data: The original data array, each classify is an array matrix
% P_Mat: Dictionary array P, each classify is an array matrix
% DataInvMat :  (~X_i)*(~X_i)^T
% tau : Prevent matrix singular additions
% alpha : Robust projective parameter
% beta : discriminative adaptive representation parameter

%------------------------------------------------
% output:
% P_Mat : Dictionary array P, each classify is an array matrix
%============================================================
%% cumpater

ClassNum = size(S_Mat,2);
L_Mat = cell(1,ClassNum);
for i=1:ClassNum
    Temp_S = S_Mat{i};
    Temp_Data = Data{i};
    % (~X_l)*(~X_l)^T
    Temp_Da_i = DataInvMat{i};
    %======================================================

    Temp_A = alpha*Temp_Da_i+gamma*Temp_Data*Temp_Data'+beta*Temp_Data*Temp_Data'-...
        2*beta*Temp_Data*Temp_S'*Temp_S*Temp_Data'+beta*Temp_Data*Temp_S'*Temp_S*Temp_S'*Temp_S*Temp_Data';
    Temp_A = Temp_A + 1e-4*eye(size(Temp_A));
    Temp_B = gamma*(Temp_S*Temp_Data');
    % ===============================================
    L_Mat{i} = Temp_B/Temp_A;
end

