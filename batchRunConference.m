function batchRunConference(PD_depth,graph_location,runs,output_flag)
%batchRunConference
%   Code we ran to generate data for the conference.

if (nargin < 4) || isempty(output_flag),
    output_flag = 0;
end;

if (nargin < 3) || isempty(runs),
    runs = 1:5;
end;

if (nargin < 2) || isempty(graph_location),
    graph_location = '../RationalityData/graphBig1.txt';
end;

%set game
game_point = [-PD_depth, 1 + PD_depth];

game_dir = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
mkdir(game_dir);
steps = [10 20 20 50 100 100 200 500 500 500];

for run = runs,
    %no Bayes inviscid
    t = tic;
    recStepRun(graph_location,strcat(game_dir, '/ni', int2str(run)), ...
        steps,game_point,0.1,0.05,0,0.1,1,output_flag);
    toc(t);
    %no Bayes viscous
    t = tic;
    recStepRun(graph_location,strcat(game_dir, '/nv', int2str(run)), ...
        steps,game_point,0.1,0.05,0,0.1,0,output_flag);
    toc(t);
    %Bayes inviscid
    t = tic;
    recStepRun(graph_location,strcat(game_dir, '/bi', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,1,output_flag);
    toc(t);
    %Bayes viscous
    t = tic;
    recStepRun(graph_location,strcat(game_dir, '/bv', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag);
    toc(t);
end;

end

