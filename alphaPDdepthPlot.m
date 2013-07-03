function alphaPDdepthPlot(suffix, e_value, PD_depths, runs, window, k)

if (nargin < 6) || isempty(k),
    k = 1;
end;

if(nargin < 5) || isempty(window),
    window = 1801:2000;
end

if(nargin < 4) || isempty(runs),
    runs = 1:10;
end;

if(nargin < 3) || isempty(PD_depths),
    PD_depths = 0.1:0.1:1.0;
end;

for PD_depth = PD_depths,
        %Find which folder we're opening.
        game_point = [-PD_depth, 1 + PD_depth];
        name_start = strcat('../RationalityData/U', int2str(10 * game_point(1)), 'V', int2str(10 * game_point(2)), suffix);
        
        %Create a vector to hold each run's average alpha value across the
        %window of timesteps.
        alphas = zeros(length(runs),1);
        
        %Average and store the alpha values across the window of timesteps
        %for each run.
        for run = runs,
            data = dlmread(strcat(name_start, int2str(run), 'e', int2str(e_value), '/data.txt'));
            alphas(run) = mean(data(window, 12));
        end;
        
        %Get the standard error for the average alpha values across all
        %runs.
        stderr = std(alphas)/sqrt(length(alphas));
        
        %Plot the results.
        plot(alphas - stderr, 'b');
        hold on;
        plot(alphas + stderr, 'b');
        hold off;
        xlabel('Run');
        if(k == 1),
            ylabel(strcat('Average alpha'));
        elseif(k == 2),
            ylabel(strcat('Proportion of agents using alpha'));
        end;
end;

end