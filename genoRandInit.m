function genotypes = genoRandInit(n_agents,boundaries,alpha_values)
%creates an initial seed of random genotypes.

if (alpha_values == 0),
    genotypes = rand(n_agents, 2);
elseif (length(alpha_values) == 1), %alpha with mutation size
    genotypes = rand(n_agents, 3);
else %alpha with specific values
    genotypes = rand(n_agents, 3);
    genotypes(:,3) = alpha_values(ceil(length(alpha_values)*genotypes(:,3)));
end;

genotypes(:, 1) = genotypes(:, 1) .* (boundaries(2) - boundaries(1)) + boundaries(1);
genotypes(:, 2) = genotypes(:, 2) .* (boundaries(4) - boundaries(3)) + boundaries(3);


end

