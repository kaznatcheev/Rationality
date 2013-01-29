function adjmx = saveRegRandGraph(location,n_agents,degree)
%adjmx = saveRegRandGraph(location,n_agents,degree)
%   This function generates a random (degree)-regular graph on (n_agents)
%   many vertices and saves it to the file specified by (location).

adjmx = full(createRandRegGraph(n_agents, degree));

dlmwrite(location,adjmx);

end

