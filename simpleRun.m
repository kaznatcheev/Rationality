function [data,genotypes,minds] = simpleRun(n_agents,n_epochs,game,alpha_values)
%The goal of simpleRun is to provide a way to quickly test run the code
%and look at its outputs

%set the default parameters
degree = 3;
boundaries = [-2, 2, -1, 3];
p_death = 0.1;
mutation_rate = 0.05;
mutation_size = 0.1;
if (alpha_values == 0)
    alpha_mut_rate = 0;
else
    alpha_mut_rate = 0.05;
end;
p_shuffle = 0;
epsilon = 0.05;

%First we make a random graph of degree
adjmx = full(createRandRegGraph(n_agents, degree));

genotypes = genoRandInit(n_agents,boundaries,alpha_values);

minds = zeros(n_agents, 4);

[data,genotypes,minds] = subRat(adjmx, genotypes, minds, game, [], ...
    @deathBirth, n_epochs, p_death,...
    @(genotype) repLocalMutate(genotype, mutation_rate, mutation_size, ...
            boundaries, alpha_mut_rate, alpha_values),...
    @(genotype,mind) ratBayShaky(genotype, mind, epsilon), p_shuffle);

end

