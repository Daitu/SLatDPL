function [ S_Mat,P_Mat,L_Mat,DictMat] = TrainSLatDPL3( Data, Label,...
    DictSize, alpha, beta,gamma, Iter )
%% This is the RADPL training function
% Robust projective Dictionary pair learning by discriminative adapive 
% representations training code
% Input arguments:
%  Data : Train Data,every class is one of cell;Data{i} class i train data
%  Label : Train Label;example:[1,1,1,1,........,i,i,i,......,k,k]
%  DictSize : Dictionary size,The number of atoms per sub Dictionaries
%  Iter : max Iter times
% output:
% Dict_D : Dictionary D
% Dict_P : Dictionary P
% Iter : iter times
%%
% Initilize D and P , precompute the update W for one time 
[ DataMat, DictMat, P_Mat,L_Mat,S_Mat,DataInvMat] = Initilization2( Data , Label, DictSize);
% Alternatively update P, D and A
for i=1:Iter
    [ P_Mat ] = UpdateP(DictMat, S_Mat, DataMat, DataInvMat, alpha, beta);
    [ L_Mat ] = UpdateL(  S_Mat,  DataMat, DataInvMat, alpha,beta,gamma);
    [ S_Mat ] = UpdateS( DictMat, P_Mat, L_Mat, S_Mat,DataMat,beta,gamma);
    [ DictMat] = UpdateD(DictMat, S_Mat, P_Mat, DataMat);
end




    
