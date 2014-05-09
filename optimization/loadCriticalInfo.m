function[shortest_paths_matrix, TOP_FLOWS, linkIDMatrix, LINK] = loadCriticalInfo(networkID,...
     numRoutes)

% load graph
load([networkID, '-graph.mat']);

% load links
% map keys: linkIDs
% map structure: linkID, incomingNode, outgoingNode, lengthInMiles, fuelCost
[LINK] = loadLinks(linkMap);

% load linkID look up matrix
% linkIDMatrix(incomingNode, outgoingNode) = linkID
load('linkIDMatrix.mat');

% load shortest paths == all flow pairs
% matrix, each row: [O, D, cost, traveled nodes]
load('shortest_paths_matrix.mat');

% load unsorted flows
% matrix, each row: [flowID, flow volume]
load('generated_flows_all.mat');

% load sorted flows
% matrix, each row: [flowID, flow volume]
load('generated_flows_sorted.mat');
topFlowIDs = sortedFlows(1:numRoutes, 1);   % retrive candidate route/flow IDs

% retrieve top k flow info: nodes + links
% map keys: flowIDs
% map structure TOP_FLOWS: flowID, origin, destination, cost, nodes, links
% topFlowIDs = [1;2];  % for testing
[TOP_FLOWS] = retriveFlows(topFlowIDs, shortest_paths_matrix, linkIDMatrix);