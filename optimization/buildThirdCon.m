function[Q_3, P_3, H_3, Aeq, beq] = buildThirdCon(Q, P, H, numFacilities)

Q_3 = zeros(1, Q);
P_3 = ones(1, P);
H_3 = zeros(1, H);
Aeq = [Q_3 P_3 H_3];
beq = numFacilities;