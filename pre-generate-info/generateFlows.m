clear all
clc

% This file generate:
% 1. flows for all OD pairs
% 2. sorted flows

% read txt file into matrix
shortest_paths_matrix = dlmread('shortest_paths.txt');

% extract information
OD_matrix = [shortest_paths_matrix(:, 1:2)];
Cost_values = shortest_paths_matrix(:, 3);

% get the number of rows
numRows = size(OD_matrix,1);

% read points' weight informaiton
matrix_points = dlmread('points_weight.txt');
point = matrix_points(:, 1);
weight = matrix_points(:,2);

% compute flows
flows = [];
for i = 1 : numRows 
    origin = OD_matrix(i, 1);
    destination = OD_matrix(i, 2);
    f = weight(origin) * weight(destination) / Cost_values(i) * 1.5;
    flows = [flows; i, f];
end

% sort flows in decreasing order
sortedFlows = sortrows(flows, 2);  % in ascending order
sortedFlows = flipud(sortedFlows);

% save shortest paths matrix
save('shortest_paths_matrix.mat', 'shortest_paths_matrix');

% save all flows
dlmwrite('generated_flow_all.txt', flows);
save('generated_flows_all.mat', 'flows');

% save sorted flows
dlmwrite('generated_flow_sorted.txt', sortedFlows);
save('generated_flows_sorted.mat', 'sortedFlows');

