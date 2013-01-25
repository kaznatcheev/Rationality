function adjmx = makeRandomGraph(n,p)
%adjmx = makeRandomGraph(n,p)
%   Generates a random graph on (n) nodes with each edge present with
%   probability (p)

ps = sqrt(p);

adjmx = (rand(n) < ps);

adjmx = (adjmx & adjmx') & ~eye(n);

end

