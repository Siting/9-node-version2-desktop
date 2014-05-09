function[b_qh, a_hp] = pregenerateCoefficientMatrix(shor_paths, TOP_FLOWS,...
    numNodes, numStations, numPads)

numODPairsTotal = size(shor_paths,1);
numODPairsTop = length(TOP_FLOWS);

%% a_hp = 1 if a facility is assigned to potential location for combination
% h

% initialize all entries as 0
numColumns_a = numNodes + numODPairsTop;
if numStations == 0
    
    numRows_a = nchoosek(numODPairsTop, numPads);
    a_hp = zeros(numRows_a, numColumns_a); % pre-allocate space
    
    % for routes/flows (entire, not each unit)
    routeCombinationMatrix = zeros(numRows_a, numODPairsTop);
    indexCombinations_routes = nchoosek(1:numODPairsTop,numPads);
    for i = 1 : size(a_hp,1)
        routeCombinationMatrix(i,indexCombinations_routes(i,:)) = 1;
    end
    
    a_hp(:, numNodes+1:end) = routeCombinationMatrix;
    
elseif numPads == 0

    numRows_a = nchoosek(numNodes, numStations);
    a_hp = zeros(numRows_a, numColumns_a); % pre-allocate space
    
    % unit block for nodes
    % list out all combinations
    nodeCombinationMatrix = zeros(numRows_a,numNodes);
    indexCombinations_nodes = nchoosek(1:numNodes,numStations);
    for i = 1 : size(nodeCombinationMatrix,1)
        nodeCombinationMatrix(i,indexCombinations_nodes(i,:)) = 1;
    end
    
    a_hp(:, 1 : numNodes) = nodeCombinationMatrix;
    
else
    
    numRows_a = nchoosek(numNodes, numStations) * nchoosek(numODPairsTop, numPads);
    a_hp = zeros(numRows_a, numColumns_a); % pre-allocate space

    % unit block for nodes
    % list out all combinations
    nodeCombinationMatrix = zeros(nchoosek(numNodes, numStations),numNodes);
    indexCombinations_nodes = nchoosek(1:numNodes,numStations);
    for i = 1 : size(indexCombinations_nodes,1)
        nodeCombinationMatrix(i,indexCombinations_nodes(i,:)) = 1;
    end
    
    numCombination_pads = nchoosek(numODPairsTop, numPads);
    nodeCombinationMatrix = repmat(nodeCombinationMatrix,numCombination_pads,1);
    
    % for routes/flows (entire, not each unit)
    routeCombinationMatrix = zeros(numRows_a, numODPairsTop);
    indexCombinations_routes = nchoosek(1:numODPairsTop,numPads);
    
    indexCombinations_routes_replicated = kron(indexCombinations_routes,ones(nchoosek(numNodes, numStations),1));
    for i = 1 : length(indexCombinations_routes_replicated)
        routeCombinationMatrix(i, indexCombinations_routes_replicated(i,:)) = 1;
    end
    
    % first time generate a_hp
    a_hp = [nodeCombinationMatrix routeCombinationMatrix];
    
    % exclude combinations with overlapping charging station and charging pad
    [a_hp, removeComs] = excludeCombinations_a_hp(a_hp, TOP_FLOWS, numNodes);
end


%% b_qh = 1 if combination h can refule path q\
% for now, initialize all elements to 0
numColumns_b = size(a_hp,1);
numRows_b = numODPairsTotal;

b_qh = zeros(numRows_b, numColumns_b);


