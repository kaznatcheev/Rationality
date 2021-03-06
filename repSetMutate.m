function genotype_new = repSetMutate(genotype_old, UV_mut_rate, ...
    UV_values, alpha_mut_rate, alpha_values)
%genotype = repSetMutate(genotype, mr_UV, UVs, bounds, mr_a, alphas)
%
%This is a (reproduce) rule that takes the old [genotype] and mutates U,V 
%with probability [mr_UV], with new values selected from the list [UVs].
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
%   UVs         - n x 2 verctor of the n allowed (U,V) pairs
%   mr_a        - mutation rate for alpha
%   alphas      - allowed values for alpha

if (nargin < 5) || isempty(alpha_values),
    alpha_values = 0;
    alpha_mut_rate = 0;
end;

if (nargin < 4) || isempty (alpha_mut_rate),
    alpha_mut_rate = 0;
end;

if isempty(genotype_old),
    rand_UV = randi(size(UV_values,1));
    rand_U = UV_values(rand_UV,1);
    rand_V = UV_values(rand_UV,2);
    genotype_old = genoRandInit(1,[rand_U, rand_U, rand_V, rand_V],alpha_values);
end;

genotype_new = genotype_old;

%mutation in U,V
if rand < UV_mut_rate,
    rand_UV = randi(size(UV_values,1));
    genotype_new(1) = UV_values(rand_UV,1);
    genotype_new(2) = UV_values(rand_UV,2);
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

