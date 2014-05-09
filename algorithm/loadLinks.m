function[LINK] = loadLinks(linkMap)

% load all links in a LINK map

LINK = containers.Map( ...
    'KeyType', 'int64', 'ValueType', 'any');

linkIds = linkMap.keys;

for i = 1 : length(linkIds)
    linkSingle = linkMap(linkIds{i});
    link = struct('linkID',linkSingle.linkId,'incomingNode',linkSingle.incomingNode,...
        'outgoingNode',linkSingle.outgoingNode, 'length',linkSingle.lengthInMiles,...
        'fuelCost', linkSingle.lengthInMiles);   
    LINK(linkIds{i}) = link;
end