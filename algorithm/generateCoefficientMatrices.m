function[b_qh, a_hp] = generateCoefficientMatrices(shortest_paths_matrix,...
    TOP_FLOWS, numNodes, numStations, numPads, linkIDMatrix,...
    numRoutes, LINK)

% pre-generate b_qh, a_hp
[b_qh, a_hp] = pregenerateCoefficientMatrix(shortest_paths_matrix, TOP_FLOWS, numNodes,...
    numStations, numPads);

% retrieve all flows info: nodes + links
% map keys: flowIDs
% map structure ALL_FLOWS: flowID, origin, destination, cost, nodes, links
flowIDs = [1:size(shortest_paths_matrix,1)];
[ALL_FLOWS] = retriveFlows(flowIDs, shortest_paths_matrix, linkIDMatrix);

% filter out ineligible combinatinos
[b_qh, a_hp] = filterCombinations(b_qh, a_hp, ALL_FLOWS, TOP_FLOWS, numNodes, numRoutes, LINK);