function genotype_new = repLocalMutate(genotype_old, UV_mut_rate, ...
    UV_mutation_size, boundaries, alpha_mut_rate, alpha_values)
%genotype = repLocalMutate(genotype, mr_UV, ms_UV, bounds, mr_a, alphas)
%
%This is a (reproduce) rule that takes the old [genotype] and mutates U,V 
%with probability [mr_UV], with the new values within boundaries given by
%[bounds] and U,V +- [ms_UV].
%
%If [mr_a] and [alphas] are given (but default they are 0) then with
%probability [mr_a] the alpha of genotype is modified such that
%   If [alphas] is an array then new alpha is a random element of [alphas]
%   If [alphas] is in (0,1) then new alpha is generated at random within
%       boundaries given by alpha +- [alphas] and (0,1).
%
%Input:
%   genotype    - 1 x 2 vector where 
%                   [1] is the agent's U value, and
%                   [2] is its V value
%   mr_UV       - the probability that the agent experiences a mutation
%   ms_UV       - the maximum size of a mutation "step"
%   bounds      - 1 x 4 vector that sets the boundaries for U and V, where
%                   [1] is minimum value of U
%                   [2] is the maximum value of U
%                   [3] is the minimum value of V
%                   [4] is the maximum value of V
%   mr_a        - mutation rate for alpha
%   alphas      - allowed values for alpha

if (nargin < 6) || isempty(alpha_values),
    alpha_values = 0;
    alpha_mut_rate = 0;
end;

if (nargin < 5) || isempty (alpha_mut_rate),
    alpha_mut_rate = 0;
end;

if isempty(genotype_old),
    genotype_old = genoRandInit(1,boundaries,alpha_values);
end;

genotype_new = genotype_old;

%mutation in U,V
if rand < UV_mut_rate,
    for i = 1:2
        genotype_new(i) = genotype_new(i) + (rand * UV_mutation_size * 2) - UV_mutation_size;
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
            (rand * alpha_values * 2) - alpha_values, 0), 1);
    else
        genotype_new(3) = alpha_values(randi(length(alpha_values)));
    end;
end;

end