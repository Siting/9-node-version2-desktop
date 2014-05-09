function[round_links] = makeRoundTrip_link(links)

back_links = fliplr(links);

round_links = [links back_links];