function decision = ratShaky(genotype,mind,epsilon)
%decision = ratShaky
%   genotype(1) - U value of game agent percieves
%   genotype(2) - V value of game agent percieves
%   mind - 1x4 vector representing agent's mind
%   epsilon - shakiness parameter
%agent uses genotype to calculate the rational strategy and then follows it
%doing the opposite with probability (epsilon).

U = genotype(1);
V = genotype(2);

if (U <= 0) && (V >= 1),
    decision = 2;
elseif (U >= 0) && (V <= 1),
    decision = 1;
else
    p = U/(U + V - 1);
    decision = 1 + (rand > p);
end;
        

end

