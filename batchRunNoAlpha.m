function batchRunNoAlpha(PD_depth,graph_location,runs,output_flag)
%batchRunConference
%   Code we ran to generate data for alpha off, but UV on or off.

if (nargin < 4) || isempty(output_flag),
    output_flag = 0;
end;

if (nargin < 3) || isempty(runs),
    runs = 1:10;
end;

if (nargin < 2) || isempty(graph_location),
    graph_location = '../RationalityData/graphBig1.txt';
end;


%set game
game_point = [-PD_depth, 1 + PD_depth];

name_start = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
%mkdir(name_start);
steps = [10 20 20 50 100 100 200 500 500 500];

for run = runs,    
    %Bayes viscous (alpha = no, evo_UV_flag = 0)
    tic;
    evo_UV_flag = 0
    recStepRun(graph_location,strcat(name_start, 'bnov', int2str(run), 'e', int2str(evo_UV_flag)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag,0,0,evo_UV_flag);
    toc;
    
    %Bayes viscous (alpha = no, evo_UV_flag = 1)
    tic;
    evo_UV_flag = 1
    recStepRun(graph_location,strcat(name_start, 'bnov', int2str(run), 'e', int2str(evo_UV_flag)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag,0,0,evo_UV_flag);
    toc;
end;

end

