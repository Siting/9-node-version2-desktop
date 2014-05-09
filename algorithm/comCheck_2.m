function[checkResult] = comCheck_2(nodes_flow, links_flow, nodes_com, links_com, LINK)

global full_range

origin_node = nodes_flow(1); 

% initialize fuel range
% only set full fuel range when there's a charging station at origin
if any(ismember(origin_node, nodes_com))
    remain_fuel = full_range;
else
    remain_fuel = full_range / 2;
end

% move EV from node to node
for i = 2 : length(nodes_flow)
    
    % get current node ID
    current_node = nodes_flow(i);
    
    % get just traveled link ID
    traveled_link = links_flow(i-1);
    
    % update remaining fuel range
    remain_fuel = remain_fuel - LINK(traveled_link).fuelCost;
    
    if remain_fuel < 0
        checkResult = 0;
        break
    else
        if i == (length(nodes_flow)/2+1)  % node is the round-trip destination
            if any(ismember(current_node,nodes_com)) || any(ismember(traveled_link, links_com))
                % if a charging station is located at destination or the
                % last link is assigned with charging pad, combination is
                % OK
                checkResult = 1;
                break
            else
                continue
            end
        end
        
        if i == length(nodes_flow)  % node is origin
            checkResult = 1;
            break
        end
        
        if ismember(current_node, nodes_com)   % node has a station
            remain_fuel = full_range;
        end

    end
           
end
    
