function genotype_new = repLocalMutate(genotype_old, mutation_rate, ...
    mutation_size, boundaries, alpha_mut_rate, alpha_values)
%genotype = repLocalMutate(genotype, mutation_rate, mutation_size)
%
%Takes the genotypes_old and mutates U,V with probability [mutation_rate],
%with the new values within boundaries and U,V +- [mutation_size]
%
%Input:
%   genotype_old - 1 x 2 vector where [1] is the  agent's U value and
%       [2] is its V value
%   mutation_rate - the probability that the agent experiences a mutation
%   mutation_size - the maximum size of a mutation "step"
%   boundaries - 1 x 4 vector that sets the boundaries for U and V, where
%       [1] is minimum value of U
%       [2] is the maximum value of U
%       [3] is the minimum value of V
%       [4] is the maximum value of V
%   alpha_mut_rate - mutation rate for alpha
%   alpha_values - allowed values for alpha

if (nargin < 6) || isempty(alpha_values),
    alpha_values = 0;
    alpha_mut_rate = 0;
end;

if (nargin < 5) || isempty (alpha_mut_rate),
    alpha_mut_rate = 0;
end;

if isempty(genotype_old),
    if (alpha_values == 0),
        genotype_old = [rand * (boundaries(2) - boundaries(1)) + boundaries(1), ...
            rand*(boundaries(4) - boundaries(3)) + boundaries(3)];
    elseif (length(alpha_values) == 1),
        genotype_old = [rand * (boundaries(2) - boundaries(1)) + boundaries(1), ...
            rand*(boundaries(4) - boundaries(3)) + boundaries(3), rand];
    else
        genotype_old = [rand * (boundaries(2) - boundaries(1)) + boundaries(1), ...
            rand*(boundaries(4) - boundaries(3)) + boundaries(3),
            alpha_values(randi(length(alpha_values)))];
    end;
end;

genotype_new = genotype_old;

%mutation in U,V
if rand < mutation_rate,
    for i = 1:2
        genotype_new(i) = genotype_new(i) + (rand * mutation_size * 2) - mutation_size;
    end;
    
    if (nargin == 4) && ~isempty(boundaries),
        genotype_new(1) = min(max(genotype_new(1), boundaries(1)), boundaries(2));
        genotype_new(2) = min(max(genotype_new(2), boundaries(3)), boundaries(4));
    end;
end;

%mutation in alpha
if rand < alpha_mut_rate,
    if (length(alpha_values) == 1), %mutation step size case
        genotype_new(3) = min(max(genotype_new(3) + ...
            (rand * alpha_mut_size * 2) - alpha_mut_size, 0), 1);
    else
        genotype_new(3) = alpha_values(randi(length(alpha_values)));
    end;
end;

end