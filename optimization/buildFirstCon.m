function[Q_1, P_1, H_1, A_1, b_1] = buildFirstCon(Q, P, b_qh)

Q_1 = eye(Q, Q);
P_1 = zeros(Q, P);
H_1 = -b_qh;
A_1 = [Q_1 P_1 H_1];
b_1 = zeros(Q, 1);