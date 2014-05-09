function[out_nodes] = makeRoundTrip_node(in_nodes)

back_trip = fliplr(in_nodes);

out_nodes = [in_nodes back_trip(2:end)];


