clear all
clc

numNodes = 5;
networkID = '5Node-network';

% build linkID look up matrix
linkIDMatrix = -1 * ones(numNodes, numNodes);

% load graph
load([networkID, '-graph.mat']);

% load links
[LINK] = loadLinks(linkMap);

numLinks = length(LINK);

for i = 1 : numLinks
    origin = LINK(i).incomingNode;
    destination = LINK(i).outgoingNode;
    linkIDMatrix(origin, destination) = LINK(i).linkID;
    linkIDMatrix(destination, origin) = LINK(i).linkID;
end

save('linkIDMatrix.mat', 'linkIDMatrix');