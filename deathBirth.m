function [genotypesNew, dead] = deathBirth( adjmx, ...
    genotypesOld, w, fitnesses, pmod, reproduce)
%deathBirth(adjmx,genotypes,w,fitnesses,pmod,reproduce)
%   does deathBirth updating on (genotypes) with (fitnesses) given
%   reproduction graph (adjmx) and reproductive rule (reproduce).
%   reproduce is a function

genotypesNew = genotypesOld;

r = randperm(length(genotypesOld));

if isempty(pmod),
    n_killed = 1;
else
    n_killed = floor(length(genotypesOld)*pmod);
end;

dead = r(1:n_killed);
num_list = 1:length(genotypesOld);


for i = 1:n_killed
    neighbours_indices = num_list((adjmx(dead(i),:)==1));
    if ~isempty(neighbours_indices),
        neighbours_fitnesses=fitnesses(neighbours_indices);
        neighbours_cdf = cumsum(fit2pdf(neighbours_fitnesses,w));
        choices = neighbours_indices(neighbours_cdf > rand);
        if numel(choices) == 0,
        	genotypesNew(dead(i),:) = reproduce([]);
        else,
        	genotypesNew(dead(i),:) = reproduce(genotypesOld(choices(1),:));
        end;
    else,
        genotypesNew(dead(i),:) = reproduce([]);
    end;
end


    
