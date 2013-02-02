close all;

%runs = [2 3 4 5 7 8 9 10];
%runs = [ 2 4 5 7 8 10];
runs = 1:5;
i = 1;

h = figure;
set(h, 'Position', [0 0 300 900]);

for offset = [0.2,0.5,0.6],
    game_point = [-offset,1 + offset];
    game_dir = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));
    
    genotypes = zeros(500*length(runs),2);
    for run = runs,
        genotypes(((run - 1)*500 + 1):(run*500),:) = dlmread(strcat(game_dir,'/bv',int2str(run),'/genotypes2000.txt'));
        all_data(:,:,run,i) = dlmread(strcat(game_dir,'/bv',int2str(run),'/data.txt'));
    end;
    
    subplot(3,1,i);
    densityPlot(genotypes,[-2 2 -1 3],[],40,0,0);
    %caxis([0 120]);
    %title(strcat('Density plot of genotypes at epoch 2000 (U=', num2str(game_point(1)), ', V=', num2str(game_point(2)), ')'));
    %set(gca, 'Position', [1 - 0.3*i, 0.3*(i - 1), 0.3, 0.3]);
    
    i = i + 1;
end;


axes('Position', [0.13 0.03 0.77 0.8], 'Visible', 'off');
%caxis([0 120]);
colorbar('SouthOutside');

figure;
hold on;
for run = runs,
    prop_coop = plotCoop(all_data(:,:,run,1),[],[],0);
    plot(prop_coop,'b');
    
    prop_coop = plotCoop(all_data(:,:,run,2),[],[],0);
    plot(prop_coop,'g');
    
    prop_coop = plotCoop(all_data(:,:,run,3),[],[],0);
    plot(prop_coop,'r');
end;

max_epoch = 2000;
epsilon = 0.1;
plot([0, max_epoch], [epsilon, epsilon], 'k--');
plot([0, max_epoch], [1 - epsilon, 1 - epsilon], 'k--');
axis([0, max_epoch, 0, 1]);
hold off;