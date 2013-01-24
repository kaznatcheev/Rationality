function genotype_new = repLocalMutate(genotype_old, mutation_rate, mutation_size, boundaries)
%genotype = repLocalMutate(genotype, mutation_rate, mutation_size)
%input:
%   genotype_old - 1 x 2 vector where [1] is the  agent's U value and
%       [2] is its V value
%   mutation_rate - the probability that the agent experiences a mutation
%   mutation_size - the size of mutation "step" the agent took, if any
%   boundaries - 1 x 4 vector sets the boundaries for U and V, where
%       [1] is minimum value of U
%       [2] is the maximum value of U
%       [3] is the minimum value of V
%       [4] is the maximum value of V

genotype_new = genotype_old

if rand() < mutation_rate
    for i = 1:2
        genotype_new(i) = genotype_new(i) + (rand() * mutation_size * 2) - mutation_size;
    end
    
    if (nargin == 5 && ~isempty(boundaries))
        genotype_new(1) = min(max(genotype_new(1), boundaries(1)), boundaries(2));
        genotype_new(2) = min(max(genotype_new(2), boundaries(3)), boundaries(4));
    end
end

end