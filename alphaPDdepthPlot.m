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

average = zeros(length(PD_depths),1);
std_error = zeros(length(PD_depths), 1);
for i = 1:length(PD_depths),
        game_point = [-PD_depths(i), 1 + PD_depths(i)];
        name_start = strcat('../RationalityData/U', int2str(10 * game_point(1)), 'V', int2str(10 * game_point(2)), suffix);
        
        alphas = zeros(length(runs),1);
        for run = runs,
            data = dlmread(strcat(name_start, int2str(run), 'e', int2str(e_value), '/data.txt'));
            alphas(run) = mean(data(window, 12));
        end;
        
        average(i) = mean(alphas);
        std_error(i) = std(alphas) / sqrt(length(alphas));
end;

%Plot the results.
figure;
plot(average - std_error, 'b');
hold on;
plot(average + std_error, 'b');
hold off;
xlabel('UV Depth');
if(k == 1),
    ylabel(strcat('Average alpha'));
elseif(k == 2),
    ylabel(strcat('Proportion of agents using alpha'));
end;

end