function[a_hp, markRows] = excludeCombinations_a_hp(a_hp, TOP_FLOWS, numNodes)

% This function marks the rows that need to be deleted due to overlapping
% stations and pads

numRows = size(a_hp, 1);
candidateRouteIDs = TOP_FLOWS.keys;
markRows = [];  % rows that need to be deleted

for i = 1 : numRows

    combination = a_hp(i,:); % retrieve the combination
    
    routes_matrixIndecies = find(combination(numNodes+1:end)==1);  % locate the assigned route
    
    routeIDs = candidateRouteIDs(routes_matrixIndecies);
    
    % list nodes that assigned charging stations
    nodeIDs_station = find(combination(1:numNodes)==1);
    
    % list charging pad nodes
    nodeIDs_pad = [];
    for j = 1 : length(routeIDs)
        routeID = routeIDs{j};
        nodeIDs = TOP_FLOWS(routeID).nodes;
        nodeIDs_pad = [nodeIDs_pad nodeIDs];
    end  
    
    % check if any overlap
    overlap = any(ismember(nodeIDs_station, nodeIDs_pad));
    
    % if there is overlap, mark the row
    if overlap == 1
        markRows = [markRows; i];
    end
end

% remove the marked rows
a_hp(markRows,:) = [];
    
    