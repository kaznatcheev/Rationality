function batchRun(graph_location,game_point,runs,output_flag)
%batchRun

if (nargin < 4) || isempty(output_flag),
    output_flag = 0;
end;

if (nargin < 3) || isempty(runs),
    runs = 1:10;
end;

name_start = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
steps = [10 20 20 50 100 100 200 500 500 500];

for run = runs,
    %no Bayes inviscid
    recStepRun(graph_location,strcat(name_start, 'ni', int2str(run)), ...
        steps,game_point,0.1,0.05,0,0.1,1,output_flag);
    %no Bayes viscous
    recStepRun(graph_location,strcat(name_start, 'nv', int2str(run)), ...
        steps,game_point,0.1,0.05,0,0.1,0,output_flag);
    %Bayes inviscid
    recStepRun(graph_location,strcat(name_start, 'bi', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,1,output_flag);
    %Bayes viscous
    recStepRun(graph_location,strcat(name_start, 'bv', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag);
end;

end

