function[checkResult] = comCheck_1(nodes_flow, links_flow, nodes_com, links_com)

% check if any overlap nodes, yes = 1
overlap_node = any(ismember(nodes_flow, nodes_com));

% check if any overlap links, yes = 1
overlap_link = any(ismember(links_flow, links_com));

% get final result
r = overlap_node || overlap_link;

if r == 1
    checkResult = 1; % overlap
else
    checkResult = 0; % no overlap
end