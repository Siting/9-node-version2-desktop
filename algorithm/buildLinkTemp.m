function[LINK_TEMP]= buildLinkTemp(LINK)

linkIDs = LINK.keys;

LINK_TEMP = containers.Map( ...
    'KeyType', 'int64', 'ValueType', 'any');

for i = 1 : length(linkIDs)
    linkSingle = LINK(linkIDs{i});
    link = struct('linkID',linkSingle.linkID,'incomingNode',linkSingle.incomingNode,...
        'outgoingNode',linkSingle.outgoingNode, 'length',linkSingle.length,...
        'fuelCost', linkSingle.fuelCost);   
    LINK_TEMP(linkIDs{i}) = link;
end