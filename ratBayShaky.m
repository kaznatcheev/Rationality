function decision = ratBayShaky(genotype,mind,epsilon)
%decision = ratBayShaky
%   genotype(1) - U value of game agent percieves
%   genotype(2) - V value of game agent percieves
%   mind - 1x4 vector representing agent's mind
%   epsilon - shakiness parameter
%   alpha - self-absorption coefficient between 0 - rational, and 1 -
%       superrational; default value is 0.
%agent uses genotype and mind to calculate which action has a higher
%expected utility and does that action with probability 1 - epsilon. With
%probability epsilon the agent does the other action

if length(genotype) == 2,
    alpha = 0;
else
    alpha = genotype(3);
end;

[p,q] = mind2pq(mind,alpha);

util_C = p + genotype(1)*(1 - p);
util_D = q*genotype(2);

if (rand > epsilon),
    decision = 1 + (util_C < util_D);
else
    decision = 1 + (util_C > util_D);
end;

end

