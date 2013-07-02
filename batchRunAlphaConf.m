function batchRunAlphaConf(PD_depth,evo_UV_flag,graph_location,runs,output_flag)
%batchRunConference
%   Code we ran to generate data for the SwarmFest conference.

if (nargin < 5) || isempty(output_flag),
    output_flag = 0;
end;

if (nargin < 4) || isempty(runs),
    runs = 1:10;
end;

if (nargin < 3) || isempty(graph_location),
    graph_location = '../RationalityData/graphBig1.txt';
end;

if (nargin < 2) || isempty(evo_UV_flag),
    evo_UV_flag = 1;
end;

%set game
game_point = [-PD_depth, 1 + PD_depth];

name_start = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
mkdir(name_start);
steps = [10 20 20 50 100 100 200 500 500 500];

for run = runs,
    %Bayes inviscid (alpha = [0 0.5])
    tic;
    recStepRun(graph_location,strcat(name_start, 'b2i', int2str(run), 'e', int2str(evo_UV_flag)), ...
        steps,game_point,0.1,0.05,1,0.1,1,output_flag,0.05,[0 0.5],evo_UV_flag);
    toc;
    
    %Bayes inviscid (alpha = all)
    tic;
    recStepRun(graph_location,strcat(name_start, 'balli', int2str(run), 'e', int2str(evo_UV_flag)), ...
        steps,game_point,0.1,0.05,1,0.1,1,output_flag,0.05,0.1,evo_UV_flag);
    toc;
    
    %Bayes viscous (alpha = [0 0.5])
    tic;
    recStepRun(graph_location,strcat(name_start, 'b2v', int2str(run), 'e', int2str(evo_UV_flag)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag,0.05,[0 0.5],evo_UV_flag);
    toc;
    
    %Bayes viscous (alpha = all)
    tic;
    recStepRun(graph_location,strcat(name_start, 'ballv', int2str(run), 'e', int2str(evo_UV_flag)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag,0.05,0.1,evo_UV_flag);
    toc;
end;

end

