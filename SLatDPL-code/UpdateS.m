function [ S_Matout ] = UpdateS( D_Mat, P_Mat, L_Mat, S_Mat,Data,beta,gamma)
%% Update S
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

ClassNum = size(Data,2);
S_Matout = cell(1,ClassNum);
eet = ones(size(S_Mat{1}'*S_Mat{1}));
% ===
for i=1:ClassNum
    Temp_P = P_Mat{i};
    Temp_D = D_Mat{i};
    Temp_L = L_Mat{i};
    Temp_S = S_Mat{i};
    Temp_Data = Data{i};

    %======================================================
    Temp_Mol = Temp_D'*Temp_Data+gamma*Temp_L*Temp_Data+beta*Temp_S*Temp_Data'*Temp_P'*Temp_P*Temp_Data+...
        2*beta*Temp_S*Temp_Data'*Temp_L'*Temp_L*Temp_Data+2*beta*Temp_S*eet;
    Temp_Den = Temp_D'*Temp_D*Temp_S+Temp_D'*Temp_P*Temp_Data+...
        gamma*Temp_S+beta*Temp_S*Temp_S'*Temp_S*Temp_Data'*Temp_P'*Temp_P*Temp_Data+...
        beta*Temp_S*Temp_Data'*Temp_P'*Temp_P*Temp_Data*Temp_S'*Temp_S+...
        beta*Temp_S*Temp_S'*Temp_S*eet+beta*Temp_S*eet*Temp_S'*Temp_S;
    
    S_Matout{i} = Temp_S .*(Temp_Mol./Temp_Den);
    % ===============================================
end

