function [prop_coop_avg,prop_coop_std] = coopPDdepthPlot(suffix,e_val,PD_depths,runs,window)

if (nargin < 5) || isempty(window),
    window = 1801:2000;
end;

if (nargin < 4) || isempty(runs),
    runs = 1:10;
end;

if (nargin < 3) || isempty(PD_depths),
    PD_depths = 0.1:0.1:1.0;
end;

prop_coop_avg = zeros(length(PD_depths),1);
prop_coop_std = zeros(length(PD_depths),1);

for i = 1:length(PD_depths),
    game_point = [-PD_depths(i),1 + PD_depths(i)];
    %reset data stores
    if strcmp(suffix(2:3),'no'),
        %if there is no alpha variance then only 11 columns in data
        data = zeros(max(window),11,max(runs));
    else
        data = zeros(max(window),13,max(runs));
    end;
    %read the files into data
    for run = runs,
        file_name = strcat('../RationalityData/U', int2str(10*game_point(1)), ...
            'V', int2str(10*game_point(2)), suffix, int2str(run), 'e', ...
            int2str(e_val), '/data.txt');
         data(:,:,run) = dlmread(file_name);
    end;
    
    %reset prop_coop stores
    prop_coop = zeros(max(window),max(runs));
    prop_coop = (2*data(:,1,:) + data(:,2,:))./(2*(data(:,1,:) + data(:,2,:) + data(:,3,:)));
    
    prop_coop_smooth = zeros(max(runs),1);
    prop_coop_smooth = mean(prop_coop(window,:),1);
    
    prop_coop_avg(i) = mean(prop_coop_smooth);
    prop_coop_std(i) = std(prop_coop_smooth);
end;

figure;
hold;
plot(PD_depths, prop_coop_avg + prop_coop_std/sqrt(max(runs)), 'k.-');
plot(PD_depths, prop_coop_avg, 'k--');
plot(PD_depths, prop_coop_avg - prop_coop_std/sqrt(max(runs)), 'k.-');
axis([min(PD_depths) max(PD_depths) 0 1]);
xlabel('c/(b - c) -- inverse of PD`s specialization coefficient');
ylabel('Proportion of cooperative interactions');
grid;
hold;

end

