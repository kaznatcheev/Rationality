function batchRunAlpha(graph_location,game_point,runs,output_flag)
%batchRunAlpha

%alpha [0, 1/2]

if (nargin < 4) || isempty(output_flag),
    output_flag = 0;
end;

if (nargin < 3) || isempty(runs),
    runs = 1:10;
end;

name_start = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
steps = [10 20 20 50 100 100 200 500 500 500];

for run = runs,
    %Bayes inviscid (alpha = [0 0.5])
    tic;
    recStepRun(graph_location,strcat(name_start, 'b2i', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,1,output_flag,0.05,[0 0.5]);
    toc;
    
    %Bayes inviscid (alpha = all)
    tic;
    recStepRun(graph_location,strcat(name_start, 'balli', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,1,output_flag,0.05,0.1);
    toc;
    
    %Bayes viscous (alpha = [0 0.5])
    tic;
    recStepRun(graph_location,strcat(name_start, 'b2v', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag,0.05,[0 0.5]);
    toc;
    
    %Bayes viscous (alpha = all)
    tic;
    recStepRun(graph_location,strcat(name_start, 'ballv', int2str(run)), ...
        steps,game_point,0.1,0.05,1,0.1,0,output_flag,0.05,0.1);
    toc;
end;

end