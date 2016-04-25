graph_loc_F = '../RationalityData/adjHadzaF.txt'
graph_loc_Fr = '../RationalityData/adjRRGF.txt'
graph_loc_M = '../RationalityData/adjHadzaM.txt'
graph_loc_Mr = '../RationalityData/adjRRGM.txt'

for PD_depth = [0.05,0.1,0.15,0.20,0.25,0.3]
	%set game
	game_point = [-PD_depth, 1 + PD_depth];

	%note that Hadza game_dir has 1000s not 10s
	game_dir = strcat('../RationalityData/U', int2str(1000*game_point(1)), ...
		'V', int2str(1000*game_point(2)));
	mkdir(game_dir)

	%use same steps and runs as conference version
	steps = [10 20 20 50 100 100 200 500 500 500];
	runs = 1:10;

	for run = runs,
    	%no Bayes viscous Hadza Female
    	t = tic;
    	recStepRun(graph_loc_F,strcat(game_dir, '/nv_F', int2str(run)), ...
    	    steps,game_point,0.1,0.05,0,0.1,0,0);
    	toc(t);
    	%no Bayes viscous on random regular graph like Hadza Female
    	t = tic;
    	recStepRun(graph_loc_Fr,strcat(game_dir, '/nv_Fr', int2str(run)), ...
    	    steps,game_point,0.1,0.05,0,0.1,0,0);
    	toc(t);
    	%no Bayes viscous Hadza Male
    	t = tic;
    	recStepRun(graph_loc_M,strcat(game_dir, '/nv_M', int2str(run)), ...
    	    steps,game_point,0.1,0.05,0,0.1,0,0);
    	toc(t);
    	%no Bayes viscous on random regular graph like Hadza Male
    	t = tic;
    	recStepRun(graph_loc_Mr,strcat(game_dir, '/nv_Mr', int2str(run)), ...
    	    steps,game_point,0.1,0.05,0,0.1,0,0);
    	toc(t);
	end;
end;
