function [ D_Mat] = UpdateD(DictMat, S_Mat, P_Mat, Data)
%% Update Dictionary D
% input:
% Dict: Dictionary D_(t-1)
% Data: The original data array, each classify is an array matrix
% P_Mat:Dictionary array P, each classify is an array matrix
% tau : Prevent matrix singular additions
%------------------------------------------------
% output:
% D_Mat : Adaptive Representations W
% errorD : Previous Dictionary
%============================================================

%%
[ ClassNum] = size(Data,2);
D_Mat = DictMat;
for i=1:ClassNum
    Temp_S       = S_Mat{i};
    TempData       = Data{i};
    Temp_P = P_Mat{i};
    Temp_A = TempData*Temp_S'-Temp_P*TempData*Temp_S';
    Temp_B = Temp_S*Temp_S';
    Temp_B = Temp_B + 1e-4*eye(size(Temp_B));
    TempD = Temp_A/Temp_B;  
    D_Mat{i}       = TempD;

end




