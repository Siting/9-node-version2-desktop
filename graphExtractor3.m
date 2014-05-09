% SENSOR, LINK, NODE
clear all
close all
networkId='5Node-network';

%% links
fid = fopen(['links-' networkId '.csv']);
%link_id,length_miles,in_node_id,out_node_id
linkToNodeData = textscan(fid, '%d64 %f %d64 %d64','delimiter',',','headerlines',1);
fclose(fid);

%this map will contain link-->node
%node is a struct with incoming and outgoing fields
linkMap = containers.Map( ...
   'KeyType', 'int64', 'ValueType', 'any');

numberOfLinks=size(linkToNodeData{1},1);

for ii=1:numberOfLinks
    linkId=linkToNodeData{1}(ii);
    lengthInMiles=linkToNodeData{2}(ii);
    inNode=linkToNodeData{3}(ii);
    outNode=linkToNodeData{4}(ii);
    
    link = struct('linkId',linkId,'incomingNode',inNode,'outgoingNode',outNode,'lengthInMiles',lengthInMiles);
    linkMap(linkId)=link;
end

% %% nodes
% %finally parse nodes
% 
% fid = fopen(['nodes-' networkId '.csv']);
% %node_id,out_link_ids,in_link_ids
% %link_ids are given in {1,2,3} form
% nodeToLinkData = textscan(fid, '%d64 %s %s','delimiter',',','headerlines',1);
% fclose(fid);
% nodeMap=containers.Map('KeyType','int64','ValueType','any');
% %parse nodes
% numberOfNodes=size(nodeToLinkData{1},1);
% for ii=1:numberOfNodes
%     nodeId=nodeToLinkData{1}(ii);
%     outgoingLinks=nodeToLinkData{2}(ii);
%     outgoingLinks=outgoingLinks{1};
%     %remove curly brackets
%     outgoingLinks(1)=[];
%     outgoingLinks(end)=[];
%     outgoingLinks=int64(strread(outgoingLinks,'%d','delimiter',';'));
%     incomingLinks=nodeToLinkData{3}(ii);
%     incomingLinks=incomingLinks{1};
%     incomingLinks(1)=[];
%     incomingLinks(end)=[];    
%     incomingLinks=int64(strread(incomingLinks,'%d','delimiter',';'));
%     sinks=[];
%     if (nodeToSinkMap.isKey(nodeId))
%         sinks=nodeToSinkMap(nodeId);
%     end
%     sources=[];    
%     if (nodeToSourceMap.isKey(nodeId))
%         sources=nodeToSourceMap(nodeId);
%     end
%     
%     node=struct('nodeId',nodeId,'outgoingLinks',outgoingLinks,'incomingLinks',incomingLinks,'sinks',sinks,'sources',sources);
%     nodeMap(nodeId)=node;
% end
% 
% 
% disp('checking nodes')
% nodeIds=nodeMap.keys;
% for ii=1:length(nodeIds)
%     nodeId=nodeIds{ii};
%     node=nodeMap(nodeId);
%     outgoingLinks=node.outgoingLinks;
%     incomingLinks=node.incomingLinks;
%     sinks=node.sinks;
%     sources=node.sources;
%     
%     if (isempty(outgoingLinks) && isempty(sinks))
%             disp(['warning, check node ' nodeId]);
%     end
%     
%     if (isempty(incomingLinks) && isempty(sources))
%             disp(['warning, check node ' nodeId]);
%     end
%     
% end
% disp('node checks finished')

save([networkId '-graph'],'linkMap') 

