close all;

PDrange = 0.2:0.1:0.9;
runs = 1:5;

for offset = PDrange,
    game_point = [-offset,1 + offset];
    game_dir = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
    
    genotypes = zeros(500*length(runs),2);
    for run = runs,
        genotypes(((run - 1)*500 + 1):(run*500),:) = dlmread(strcat(game_dir,'/nv',int2str(run),'/genotypes2000.txt'));
    end;
    
    densityPlot(genotypes,[-2 2 -1 3],[],[],1);
    figure;
    bar(gameTypeCount(genotypes));
end;