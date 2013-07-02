function data = recStepRun(graph_location,save_directory, step_array, ...
    game_point,p_death, mutation_rate, bayes_flag, epsilon, p_shuffle, ...
    output_flag,alpha_mut_rate,alpha_values,evo_UV_flag)
%data = recStepRun(G_loc,save_dir,steps,g_p,p_d,mut_rat,bayes_flag, epsilon,
%   p_s, out_flag,a_mr,alphas,UV_flag)
%
%This is the main wrapper for running the simulation, it has the following
%input variables:
%   G_loc       - location where interaction graph is stored as a adjacency
%               matrix
%   save_dir    - location where to save recorded data
%   steps       - array of number of evolutionary cycles between data 
%               collections of recordings of genotypes and minds
%   g_p         - 1-by-2 array; the game given by U = g_p(1) and V = g_p(2)
%   p_d         - proportion of agents killed at each time step for
%               death-birth updating
%   mut_rat     - mutation probability of (U,V) during reproduction, the
%               mutation size is fixed at 0.1
%   bayes_flag  - should the agent use bayesian updating of its beliefs in
%               p and q? 0 means that [decisionRule] is set to 'ratShaky',
%               and 1 means that [decisionRule] is set to 'ratBayShaky'.
%   epsilon     - probability of shaky hand; default 0.05
%   p_s         - probability that agents are randomly redistributed over
%               graph at each cycle (0 for static, and 1 for inviscid)
%   out_flag    - should we plot and save the figures of results? default 0
%   a_mr        - mutation probability of alphas; default 0.
%   alphas      - allowed values for self-absorption, if a single number
%               then it is interpreted as:
%                   0 - all agents are rational (default value)
%                   a - agents in [0 1] with mutation step size a.
%               if a matrix, then taken as possible values.
%   UV-flag     - if 0 then game is fixed at true game, else evolves;
%               default 1.
%
%Outputs [data] that is a num_cycles x 11 matrix where (at time step t):
%   [t, 1] is the number of mutual cooperations
%   [t, 2] is the number of unilateral defections
%   [t, 3] is the number of mutual defections
%   [t, 4] is average U
%   [t, 5] is average V
%   [t, 6] is std of U
%   [t, 7] is std of V
%   [t, 8] is average p
%   [t, 9] is average q
%   [t, 10] is std of p
%   [t, 11] is std of q
%   [t, 12] is average alpha (if alphas are used)
%   [t, 13] is std of alpha (if alphas are used)
%
%The results are saved in [save_dir] in a series of files:
%   steps.txt       - saves all initial parameters and seed in the order:
%       [initial_seed, g_p, p_d, mut_rat, bayes_flag, epsilon, p_s, steps]
%   genotypesX.txt  - list of agent genotypes at evolutionary cycle X.
%   mindsX.txt      - list of agent minds at evolutionary cycle X. A file
%                   is generated for both genotype and minds at X_0 = 0 and
%                   at X_{i + 1} = X_i + [steps(i + 1)]
%   data.txt        - output [data] as described above.
%
%If [out_flag] = 1 then the followed figures are also created:
%   genotypesX.png  - density plot generated by 'densityPlot' function of
%                   all the genotypes at cycle X (X as for genotypesX.txt).
%   cooperation.png - proportion of cooperative interactions in [data].

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

if (nargin < 12) || isempty(evo_UV_flag),
    evo_UV_flag = 1;
end;

if (nargin < 11) || isempty(alpha_values),
    alpha_values = 0;
    alpha_mut_rate = 0;
end;

if (nargin < 10) || isempty(alpha_mut_rate),
    alpha_mut_rate = 0;
end;

if (nargin < 9) || isempty(output_flag),
    output_flag = 0;
end;

if (nargin < 7) || isempty(epsilon),
    epsilon = 0.05
end;

%read the graph
adjmx = dlmread(graph_location);
n_agents = size(adjmx,1);

%create the directory for saving
mkdir(save_directory);
%saving the graph takes up too much space

%set the initial seed
current_time = clock;
initial_seed = randi(floor(1000000*current_time(6)))
dlmwrite(strcat(save_directory,'/steps.txt'), [initial_seed, game_point, p_death, mutation_rate, bayes_flag, epsilon, p_shuffle, step_array]);

%generate the initial genotypes and minds
if evo_UV_flag,
    genotypes = genoRandInit(n_agents,boundaries,alpha_values);
else
    genotypes = genoRandInit(n_agents,[game_point(1), game_point(1), game_point(2), game_point(2)],alpha_values);
end;
minds = zeros(n_agents, 4);

%record said genotypes and minds
dlmwrite(strcat(save_directory,'/genotypes0.txt'), genotypes);
dlmwrite(strcat(save_directory,'/minds0.txt'),minds); %kind of redundant since all zeros

%pick the reproduce rule
if evo_UV_flag,
    reproduce = @(genotype) repLocalMutate(genotype, mutation_rate, ...
        mutation_size, boundaries, alpha_mut_rate, alpha_values);
else
    reproduce = @(genotype) repSetMutate(genotype, mutation_rate, ...
        game_point, alpha_mut_rate, alpha_values);
end;

%Start running the simulations
data = zeros(sum(step_array),11 + 2 * (size(genotypes, 2) > 2));
finished_step = 0;
runs = 0;
for step_size = step_array,
    if output_flag,
        t_start = tic;
    end;
    %run the simulation
    [data((finished_step + 1):(finished_step + step_size),:), genotypes, ...
        minds] = subRat(adjmx, genotypes, minds, game, [], @deathBirth, ...
        step_size, p_death, reproduce,decisionRule, p_shuffle);
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
    prop_coop = plotCoop(data(:,1:3), epsilon, game_point, tocs_array, ...
        save_directory, 'b');
end;

end