function [minds, fitnesses] = playGame(adjmx, genotypes, minds, game)
%playGame(adjmx, genotypes, minds, base_fitnesses, game)
%	Agents given by (genotypes,minds) populate the vertices of the graphs given by (adjmx) and
%	play (game) between each other to determine (fitnesses) and update (minds).
fitnesses = zeros(length(genotypes),1);
for i = 1:length(genotypes)
    for j=i:length(genotypes)
        if adjmx(i,j),
            %this is where the interaction code goes
            end
        end
    end
end
