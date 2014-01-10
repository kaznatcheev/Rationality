close all;

runs = 1:10;

offset_red = 0.3;
offset_blue = 0.9;
gp_red = [-offset_red,1 + offset_red];
gp_blue = [-offset_blue,1 + offset_blue];

%add red
game_dir = strcat('../RationalityData/U', int2str(10*gp_red(1)), 'V', int2str(10*gp_red(2)));

genotypes = zeros(500*length(runs),2);
for run = runs,
   genotypes(((run - 1)*500 + 1):(run*500),:) = dlmread(strcat(game_dir,'bnov',int2str(run),'e1/genotypes2000.txt'));
end;
    
h = densityPlot(genotypes,[-2 2 -1 3],[],[],1,1);
title('Density plot of genotypes at epoch 2000');

%add blue
game_dir = strcat('../RationalityData/U', int2str(10*gp_blue(1)), 'V', int2str(10*gp_blue(2)));

genotypes = zeros(500*length(runs),2);
for run = runs,
   genotypes(((run - 1)*500 + 1):(run*500),:) = dlmread(strcat(game_dir,'bnov',int2str(run),'e1/genotypes2000.txt'));
end;

h = densityPlot(genotypes,[-2 2 -1 3],[],[],1,0);
%title('Density plot of genotypes at epoch 2000');

print(h,'-dpng',strcat('../RationalityData/images/genotypesRedBlue.png'));
