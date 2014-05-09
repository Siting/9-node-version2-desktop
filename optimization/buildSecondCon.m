function[Q_2, P_2, H_2, A_2, b_2] = buildSecondCon(H, a_hp, numFacilities, Q)

P_2 = [];

for h = 1 : H
    a_row = -a_hp(h,:);
    a_unit = diag(a_row);
    P_2 = [P_2; a_unit];
end
% remove rows with all zeros
P_2(all(P_2==0,2),:) = [];
  
h_unit = eye(H,H);
H_2 = kron(h_unit, ones(numFacilities,1));

Q_2 = zeros(size(P_2,1),Q);

A_2 = [Q_2 P_2 H_2];
b_2 = zeros(size(P_2,1), 1);