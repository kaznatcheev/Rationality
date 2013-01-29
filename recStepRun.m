function data = recStepRun(graph_location,save_directory, step_array, ...
    game_point,p_death, mutation_rate, bayes_flag, epsilon, p_shuffle, ...
    output_flag)
%STEPRUN Summary of this function goes here
%   Detailed explanation goes here

%set some global variables and flip flags
boundaries = [-2, 2, -1, 3];
mutation_size = 0.1;

game = [1, game_point(1); game_point(2), 0];

if bayes_flag,
    decisionRule = @(genotype,mind) ratBayShaky(genotype, mind, epsilon);
else
    decisionRule = @(Genotype,mind) ratShaky(genotype, mind, epsilon);
end;

if (nargin < 9) || isempty(output_flag),
    output_flag = 0;
end;

%read the graph
adjmx = dlmread(graph_location);
n_agents = size(adjmx,1);

%create the directory for saving
mkdir(save_directory);

%set the initial seed
initial_seed = randi(1000)
dlmwrite(strcat(save_directory,'/steps.txt'), [initial_seed, step_array]);

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
for step_size = step_array,
    tic;
    %run the simulation
    [data((finished_step + 1):(finished_step + step_size),:), genotypes, ...
        minds] = subRat(adjmx, genotypes, minds, game, [], @deathBirth, ...
        step_size, p_death, ... 
        @(genotype) repLocalMutate(genotype, mutation_rate, mutation_size, boundaries),...
        decisionRule, p_shuffle);
    finished_step = finished_step + step_size;
    
    %record the genotypes and minds
    dlmwrite(strcat(save_directory, '/genotypes', int2str(finished_step), '.txt'), ...
        genotypes);
    dlmwrite(strcat(save_directory, '/minds', int2str(finished_step), '.txt'), ...
        minds);
    
    %output if flag is flipped
    if output_flag,
        toc;
        h = densityPlot(genotypes,boundaries,game_point,[],1);
        title(strcat('Density plot of genotypes at epoch ', int2str(finished_step)));
        print(h,'-dpng',strcat(save_directory, '/genotypes', int2str(finished_step), '.png'));
    end;
end;

%record the data
dlmwrite(strcat(save_directory, '/data.txt'), data);

if output_flag,
    prop_coop = (2*data(:,1) + data(:,2))./(2*(data(:,1) + data(:,2) + data(:,3)));
    h = plot(prop_coop);
    title(strcat('Proportion of cooperative interactions'));
    print(h,'-dpng',strcat(save_directory, '/cooperation.png'));
end;

end

