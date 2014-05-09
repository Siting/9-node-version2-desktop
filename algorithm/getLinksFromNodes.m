function[links] = getLinksFromNodes(nodes, linkIDMatrix)

% This function could take in more than 2 nodes

numNodes = length(nodes);

links = [];

for i = 1 : (numNodes - 1)
    origin = nodes(i);
    destination = nodes(i+1);
    linkID = linkIDMatrix(origin, destination);
    links = [links linkID];
end