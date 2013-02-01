close all;

PDrange = 0.3:0.1:0.9;
runs = 1:10;

for offset = PDrange,
    game_point = [-offset,1 + offset];
    game_dir = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
    
    genotypes = zeros(500*length(runs),2);
    for run = runs,
        genotypes(((run - 1)*500 + 1):(run*500),:) = dlmread(strcat(game_dir,'/nv',int2str(run),'/genotypes2000.txt'));
    end;
    
    h = densityPlot(genotypes,[-2 2 -1 3],[],[],1);
    title(strcat('Density plot of genotypes at epoch 2000 (U=', num2str(game_point(1)), ', V=', num2str(game_point(2)), ')'));
    print(h,'-dpng',strcat('../RationalityData/images/genotypes', int2str(10*offset), '.png'));
    
    h = figure;
    bar(gameTypeCount(genotypes));
    title(strcat('Game type count of of genotypes at epoch 2000 (U=', num2str(game_point(1)), ', V=', num2str(game_point(2)), ')'));
    print(h,'-dpng',strcat('../RationalityData/images/gamebar', int2str(10*offset), '.png'));
end;
