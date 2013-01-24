function [minds, fitnesses, interactions] = playGame(edge_list, genotypes, minds, game, decisionRule)
%playGame(adjmx, genotypes, minds, base_fitnesses, game)
%	Agents given by (genotypes,minds) populate the vertices of the graphs given by (adjmx) and
%	play (game) between each other to determine (fitnesses) and update (minds).
%   (decision) is a function (genotype,mind --> strat) that decides if the
%   agent will cooperate or defect.
fitnesses = zeros(length(genotypes),1);
n_edges = length(edge_list);

edge_list = edge_list(randperm(n_edges),:); %permute the order of interactions

for i = 1:n_edges,
    a1 = edge_list(i,1);
    [a1_p, a1_q] = mind2pq(minds(a1,:));
    a1_util_C = a1_p + genotypes(a1,1)*(1 - a1_p);
    a1_util_D = a1_q*genotypes(a1,2);
    
    a2 = edge_list(i,2);
    [a2_p, a2_q] = mind2pq(minds(a2,:));
    a2_util_C = a2_p + genotypes(a2,1)*(1 - a2_p);
    a2_util_D = a2_q*genotypes(a2,2);
end;
