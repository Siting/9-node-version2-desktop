function[COMBINATION, comMatrix] = generateCombinations(b_qh, a_hp, unsortedFlows, numNodes, TOP_FLOWS)

numCombinations = size(b_qh,2);

candidateRouteIDs = TOP_FLOWS.keys;

comMatrix = [];

COMBINATION = containers.Map( ...
    'KeyType', 'int64', 'ValueType', 'any');

for j = 1 : numCombinations % loop through combinations

    % get the flow IDs which could be refueled by the combination
    refueled_flowIDs = find(b_qh(:,j)==1);
    
    % compute refuled flow in total
    flow_volumes = unsortedFlows(refueled_flowIDs,2);
    total_refueled = sum(flow_volumes,1);

    % nodeIDs which get assigned charging stations
    nodes_com = find(a_hp(j, 1: numNodes)==1);
    
    % routeIDs which get assigned charging pads
    route_MatrixIndices_com = find(a_hp(j, numNodes+1:end)==1);
    routeIDs = candidateRouteIDs(route_MatrixIndices_com);
    
    % get linkIDs from route IDs
    links_com = [];
    for i = 1 : length(routeIDs)
        routeID = routeIDs{i};
        links = TOP_FLOWS(routeID).links;
        links_com = [links_com links];
    end
    links_com = unique(links_com);
    
    com = struct('comID',j,'totalRefueledFlow',total_refueled,...
        'refueledFlowIDs', refueled_flowIDs, 'stations_nodes', nodes_com,...
        'pads_links', links_com);
    
    COMBINATION(j) = com;
    
    comMatrix = [comMatrix; j total_refueled];
end