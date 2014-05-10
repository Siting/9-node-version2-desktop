clear all
clc

dbstop if error

global full_range

% set parameters
numFacilities = 3;
networkID = '9Node-network';
numNodes = 9;
numRoutes = 5;       % number of candidate routes = maximum num of pads
full_range = 5;      % set full capacity vehicle range (in mile)

b_qh_all = [];
a_hp_all = [];


for numPads = 0 : numFacilities

    
    numStations = numFacilities - numPads;
        

        % load critical infomation
        [shortest_paths_matrix, TOP_FLOWS, linkIDMatrix, LINK] = loadCriticalInfo(networkID,...
            numRoutes);
        
        % generate b_qh, a_hp
        [b_qh, a_hp] = generateCoefficientMatrices(shortest_paths_matrix,...
            TOP_FLOWS, numNodes, numStations, numPads, linkIDMatrix,...
            numRoutes, LINK);
        
        b_qh_all = [b_qh_all b_qh];
        a_hp_all = [a_hp_all; a_hp];

end

% 
% % compute refuled flow for each combination
% % map keys: combinationID
% % map structure: combinationID, refuled total flow, refueled flow ids
% % comMatrix, each row: [combinationID, cost, totalRefueledFlow]
% [COMBINATION, comMatrix] = generateCombinations(b_qh, a_hp, flows, numNodes, TOP_FLOWS);
% 
% 
% % sort combinations
% comIDs_sorted = sort(comMatrix,2);
% comIDs_sorted = flipud(comIDs_sorted);

% save variables
save('./result/b_qh', 'b_qh_all');
dlmwrite('./result/b_qh.txt', b_qh_all);
save('./result/a_hp', 'a_hp_all');
dlmwrite('./result/a_hp.txt', a_hp_all);
% save('./result/COMBINATION', 'COMBINATION');
% save('./result/comIDs_sorted', 'comIDs_sorted');
% dlmwrite('./result/comIDs_sorted.txt', comIDs_sorted);


