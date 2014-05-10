% This file contains the optimization problem
clear all
clc

% set parameters
numFacilities = 3;
numNodes = 9;       % number of nodes on the network
numRoutes = 5;      % number of candidate routes

% load b_qh, a_hp, flow
load('./result/b_qh');
load('./result/a_hp');
load('generated_flows_all.mat');
b_qh = b_qh_all;
a_hp = a_hp_all;

% compute numFlows
numFlows = size(b_qh,1);

Q = numFlows;
P = numNodes + numRoutes;
H = size(b_qh, 2);

% assign variables into opt
% f, A, b, Aeq, beq

% first constraint: with b_qh
[Q_1, P_1, H_1, A_1, b_1] = buildFirstCon(Q, P, b_qh);

% second constraint: with a_hp
[Q_2, P_2, H_2, A_2, b_2] = buildSecondCon(H, a_hp, numFacilities, Q);

% form inequality constraint
A = [A_1; A_2];
b = [b_1; b_2];

% third constraint: number of facilities
[Q_3, P_3, H_3, Aeq, beq] = buildThirdCon(Q, P, H, numFacilities);

% objective function
Q_4 = flows(:,2);
P_4 = zeros(P,1);
H_4 = zeros(H,1);
f = -[Q_4; P_4; H_4];

% optimize
[x, fval] = bintprog(f,A,b,Aeq,beq);

% save result
save('./result/opt_result','x', 'fval', 'Q', 'P', 'H');

