function data = recStepRun(graph_location,save_directory, step_array, ...
    game_point,p_death, mutation_rate, bayes_flag, epsilon, p_shuffle, ...
    output_flag)
%STEPRUN Summary of this function goes here
%   Detailed explanation goes here

%set some global variables and flip flags
boundaries = [-2, 2, -1, 3];
mutation_size = 0.1;
tics_array = zeros(1,length(step_array));

game = [1, game_point(1); game_point(2), 0];

if bayes_flag,
    decisionRule = @(genotype,mind) ratBayShaky(genotype, mind, epsilon);
else
    decisionRule = @(genotype,mind) ratShaky(genotype, mind, epsilon);
end;

if (nargin < 9) || isempty(output_flag),
    output_flag = 0;
end;

%read the graph
adjmx = dlmread(graph_location);
n_agents = size(adjmx,1);

%create the directory for saving, and record graph
mkdir(save_directory);
%saving the graph takes up too much space
%dlmwrite(strcat(save_directory, '/graph.txt'), adjmx);

%set the initial seed
current_time = clock;
initial_seed = randi(floor(1000000*current_time(6)))
dlmwrite(strcat(save_directory,'/steps.txt'), [initial_seed, game_point, p_death, mutation_rate, bayes_flag, epsilon, p_shuffle, step_array]);

%generate the initial genotypes and minds
genotypes = rand(n_agents, 2);
genotypes(:, 1) = genotypes(:, 1) .* (boundaries(2) - boundaries(1)) + boundaries(1);
genotypes(:, 2) = genotypes(:, 2) .* (boundaries(4) - boundaries(3)) + boundaries(3);

minds = zeros(n_agents, 4);

%record said genotypes and minds
dlmwrite(strcat(save_directory,'/genotypes0.txt'), genotypes);
dlmwrite(strcat(save_directory,'/minds0.txt'),minds); %kind of redundant since all zeros

%Start running the simulations
data = zeros(sum(step_array),11);
finished_step = 0;
runs = 0;
for step_size = step_array,
    if output_flag,
        t_start = tic;
    end;
    %run the simulation
    [data((finished_step + 1):(finished_step + step_size),:), genotypes, ...
        minds] = subRat(adjmx, genotypes, minds, game, [], @deathBirth, ...
        step_size, p_death, ... 
        @(genotype) repLocalMutate(genotype, mutation_rate, mutation_size, boundaries),...
        decisionRule, p_shuffle);
    finished_step = finished_step + step_size;
    runs = runs + 1;
    
    %record the genotypes and minds
    dlmwrite(strcat(save_directory, '/genotypes', int2str(finished_step), '.txt'), ...
        genotypes);
    dlmwrite(strcat(save_directory, '/minds', int2str(finished_step), '.txt'), ...
        minds);
    
    %output if flag is flipped
    if output_flag,
        toc(t_start);
        h = densityPlot(genotypes,boundaries,game_point,[],1);
        title(strcat('Density plot of genotypes at epoch ', int2str(finished_step)));
        print(h,'-dpng',strcat(save_directory, '/genotypes', int2str(finished_step), '.png'));
        tocs_array(runs) = finished_step;
    end;
end;

%record the data
dlmwrite(strcat(save_directory, '/data.txt'), data);

if output_flag,
    prop_coop = (2*data(:,1) + data(:,2))./(2*(data(:,1) + data(:,2) + data(:,3)));
    h = figure;
    plot(prop_coop);
    hold on;
    for i = 1:runs,
        plot([tocs_array(i), tocs_array(i)], [0, 1], 'y');
    end;
    fplot(@(x) 1 - epsilon,[0 finished_step],'k');
    fplot(@(x) epsilon,[0 finished_step],'k');
    hold off;
    axis([0, finished_step, 0, 1]);
    title(strcat('Proportion of cooperative interactions (U=', ...
        num2str(game_point(1)), ' V=', num2str(game_point(2)), ')'));
    print(h,'-dpng',strcat(save_directory, '/cooperation.png'));
end;

end

