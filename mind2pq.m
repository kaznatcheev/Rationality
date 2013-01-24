function [p,q] = mind2pq(mind)
%[p,q] = mind2pq(mind)
%   Takes the (mind) an agent (which is a 1x4 array) and produces:
%       p - expected probability of cooperation if he cooperates
%       q - expected probability of defection if he defects

p = (mind(1) + 1)/(mind(1) + mind(2) + 1);
q = (mind(3) + 1)/(mind(3) + mind(4) + 1);

end

