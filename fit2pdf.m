function pdf = fit2pdf( fitnesses, w)
%FIT2PDF
% fitnesses - the n-by-1 matrix of fitnesses
% w - the selection strength
% returns a probability density function


if (nargin < 2) || isempty(w), %set the default w
    if ~sum(fitnesses < 0), %if all fitnesses are non-zero then inf-w
        if sum(fitnesses) == 0,
            pdf = (fitnesses + 1)/length(fitnesses);
        else
            pdf = fitnesses/sum(fitnesses);
        end;
    else
        w = 1/abs(min(fitnesses));
        pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
    end;   
else
    if (length(fitnesses) + w*sum(fitnesses)) > 0,
        pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
    else
        'Non-positive normalizer'
        pdf = ones(length(fitnesses),1)/length(fitnesses);
    end;
end;

if (min(pdf) < 0),
    'We're fucking negative'   
end;

if ~(sum(pdf) == 1),
    'We're not fucking summing'
end;

end

