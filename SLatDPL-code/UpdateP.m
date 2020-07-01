function [ P_Mat ] = UpdateP(DictMat, S_Mat, Data, DataInvMat, alpha, beta)
%% Update P
% input:
% Dict: Dictionary D
% W_Mat : Adaptive Representations 
% Data: The original data array, each classify is an array matrix
% P_Mat: Dictionary array P, each classify is an array matrix
% DataInvMat :  (~X_i)*(~X_i)^T

%------------------------------------------------
% output:
% P_Mat : Dictionary array P, each classify is an array matrix
%============================================================
%% cumpater
ClassNum = size(S_Mat,2);
P_Mat = cell(1,ClassNum);
for i=1:ClassNum
    Temp_D = DictMat{i};
    Temp_S = S_Mat{i};
    Temp_Data = Data{i};
    % (~X_l)*(~X_l)^T
    Temp_Da_i = DataInvMat{i};
    %======================================================
    % ===============================================
    Temp_A = Temp_Data*Temp_Data'-Temp_D*Temp_S*Temp_Data';
    Temp_B = Temp_Data*Temp_Data'+alpha*Temp_Da_i+...
        beta*Temp_Data*Temp_Data'-2 *beta*Temp_Data*(Temp_S'*Temp_S)*Temp_Data'+...
        beta*Temp_Data*Temp_S'*Temp_S*Temp_S'*Temp_S*Temp_Data';
    Temp_B = Temp_B + 1e-4*eye(size(Temp_B));
    
    P_Mat{i} = Temp_A/Temp_B;
end

