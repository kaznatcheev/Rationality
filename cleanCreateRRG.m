function adjmx = cleanCreateRRG(n_agents,avg_deg)
%function adjmx = cleanCreateRRG(n_agents,avg_deg)
%	A wrapper for createRandRegGraph that takes can take non-integer (avg_deg)
%and produces a random regular(-ish) graph even if (n_agents)*round(avg_deg) 
%isn't even.

if mod(n_agents*round(avg_deg),2) 
	%if odd then can't make regular graph, so make the closest we can
	big_rand = full(createRandRegGraph(n_agents + 1, round(avg_deg)));

	%throw away one row
	adjmx = big_rand(1:n_agents,1:n_agents);
else
	adjmx = full(createRandRegGraph(n_agents, round(avg_deg)));
end