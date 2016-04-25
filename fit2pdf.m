function pdf = fit2pdf( fitnesses, w)
%FIT2PDF
% fitnesses - the n-by-1 matrix of fitnesses
% w - the selection strength
% returns a probability density function


if (nargin < 2) || isempty(w), %set the default w
    if sum(fitnesses < 0) == 0, %if all fitnesses are non-negative then inf-w
        if sum(fitnesses) == 0,
            pdf = (fitnesses + 1)/length(fitnesses);
        else
            pdf = fitnesses/sum(fitnesses);
        end;
    else
        w = 1/abs(min(fitnesses));
        if (length(fitnesses) + w*sum(fitnesses)) > 0,
            pdf = (1 + w*fitnesses)/(length(fitnesses) + w*sum(fitnesses));
        else
            %this case triggers if all fitnesses are same and negative.
            pdf = ones(length(fitnesses),1)/length(fitnesses);
        end;
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
    'We are fucking negative'   
end;

%we might be off from a sum of 1 by a little bit due to rounding errors

end

