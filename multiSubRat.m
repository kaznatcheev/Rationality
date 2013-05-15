function [data, many_genotypes, many_minds] = multiSubRat(adjmx, genotypes, minds, ...
    game, w, updateRule, max_epoch, pmod, reproduce, decisionRule, ...,
    p_shuffle, n_runs)
%[data, many_genotypes, many_minds] = multiSubRat(adjmx, genotypes, minds,
%   game, w, updateRule, max_epoch, pmod, reproduce, decisionRule, n_runs,
%   ) 
%   
%   The first 10 parameters are the same as subRat, type "help subRat" to
%   learn more. The 11th parameter (n_runs) is optional, if empty then will
%   just run subRat, else will run subRat (n_runs) many times, saving
%   genotypes and minds between each run. Thus, the total number of
%   timesteps is (n_runs)*(max_epoch).

if (nargin < 12) || isempty(n_runs),
    n_runs = 1;
end;

data = zeros(max_epoch*n_runs, 11);
    
many_genotypes = zeros(size(genotypes,1),size(genotypes,2),n_runs + 1);
many_genotypes(:,:,1) = genotypes;
    
many_minds = zeros(size(minds,1),size(minds,2),n_runs + 1);
many_minds(:,:,1) = minds;

for i = 1:n_runs,
    [data(((i - 1)*max_epoch + 1):i*max_epoch,:), ...
        many_genotypes(:,:,i + 1), many_minds(:,:,i + 1)] = ...
        subRat(adjmx, many_genotypes(:,:,i), many_minds(:,:,i), game, ...
        w, updateRule, max_epoch, pmod, reproduce, decisionRule, p_shuffle);
end;

end

