function densityPDdepthPlot(suffix,PD_depths,runs,epoch)

if (nargin < 4) || isempty(epoch),
    epoch = 2000;
end;

if (nargin < 3) || isempty(runs),
    runs = 1:10;
end;

if (nargin < 2) || isempty(PD_depths),
    PD_depths = 0.1:0.1:1.0;
end;

i = 1;


for offset = PD_depths,
    game_point = [-offset,1 + offset];
    name_dir = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)), suffix);
    
    genotypes = zeros(500*length(runs),3);
    for run = runs,
        genotypes(((run - 1)*500 + 1):(run*500),:) = dlmread(strcat(name_dir, int2str(run), 'e1/genotypes', int2str(epoch), '.txt'));
        %all_data(:,:,run,i) = dlmread(strcat(game_dir,'/bv',int2str(run),'/data.txt'));
    end;
    
    densityPlot(genotypes,[-2 2 -1 3],[],40,1,1);
    %caxis([0 120]);
    %title(strcat('Density plot of genotypes at epoch 2000 (U=', num2str(game_point(1)), ', V=', num2str(game_point(2)), ')'));
    %set(gca, 'Position', [1 - 0.3*i, 0.3*(i - 1), 0.3, 0.3]);

end;

end

