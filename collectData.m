function [data] = collectData(genotypes, minds)
%[data] = collectData(genotypes, minds)
%input:
%   genotypes - N x 2 vector where [i, 1] is the ith agent's U value and
%       [i, 2] is the V value for the game the agent thinks they are playing
%   minds - N x 4 vector where
%       [i, 1] is the number of cooperations seen when the ith agent cooperated
%       [i, 2] is the number of defections seen when the ith agent
%           cooperated
%       [i, 3] is the number of cooperations seen when the ith agent
%           defected
%       [i, 4] is the number of defections seen when the ith agent defected
%output:
%   data - A vector of length 8 where
%       [1] is average U
%       [2] is average V
%       [3] is std of U
%       [4] is std of V
%       [5] is average p
%       [6] is average q
%       [7] is std of p
%       [8] is std of q

if size(genotypes,2) == 2,
    [p,q] = cellfun(@(m) mind2pq(m,0), num2cell(minds, 2));
else
    [p,q] = cellfun(@(m) mind2pq(m(1:4),m(5)), num2cell([minds'; genotypes(:,3)']', 2));
end;

avg_u = sum(genotypes(:, 1)) / length(genotypes(:, 1));
avg_v = sum(genotypes(:, 2)) / length(genotypes(:, 2));
std_u = std(genotypes(:, 1));
std_v = std(genotypes(:, 2));
avg_p = sum(p) / length(p);
avg_q = sum(q) / length(q);
std_p = std(p);
std_q = std(q);

data = [avg_u, avg_v, std_u, std_v, avg_p, avg_q, std_p, std_q];
end

