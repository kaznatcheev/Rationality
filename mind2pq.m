function [p,q] = mind2pq(mind,alpha)
%[p,q] = mind2pq(mind,alpha)
%
%Takes the (mind) an agent (which is a 1x4 array) and produces:
%   p - expected probability of cooperation if he cooperates
%   q - expected probability of defection if he defects
%Given that the agent is alpha-self-absorbed as described in:
%   http://egtheory.wordpress.com/2013/05/13/...
%   ...quasi-magical-thinking-and-superrational-bayesian/

p = (mind(1) + alpha*mind(2) + 1)/(mind(1) + mind(2) + 2);
q = ((1 - alpha)*mind(3) + 1)/(mind(3) + mind(4) + 2);

end