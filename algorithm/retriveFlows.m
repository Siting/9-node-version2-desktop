function[TOP_FLOWS] = retriveFlows(flowIDs, shor_paths, linkIDMatrix)

% retrive flow information from file shor_paths

numFlows = length(flowIDs);

TOP_FLOWS = containers.Map( ...
    'KeyType', 'int64', 'ValueType', 'any');

for i = 1 : numFlows
    
    flowID = flowIDs(i);
    
    % get nodes
    allNodes = shor_paths(flowID, 4:end);
    nodes = allNodes(allNodes~=-1);
    
    % get links
    links = getLinksFromNodes(nodes, linkIDMatrix);
    
    % store in structure
    flow = struct('flowID',flowID,'origin',shor_paths(flowID,1),...
        'destination', shor_paths(flowID,2), 'cost',shor_paths(flowID,3),...
        'nodes', nodes, 'links', links);   
    
    TOP_FLOWS(flowID) = flow;
end