function [pq_avg,pq_std] = pqPDdepthPlot(suffix,e_val,PD_depths,runs,window)

if (nargin < 5) || isempty(window),
    window = 1801:2000;
end;

if (nargin < 4) || isempty(runs),
    runs = 1:10;
end;

if (nargin < 3) || isempty(PD_depths),
    PD_depths = 0.1:0.1:1.0;
end;

pq_avg = zeros(length(PD_depth),1);
pq_std = zeros(length(PD_depth),1);

for i = 1:length(PD_depths),
    game_point = [-PD_depths(i),1 + PD_depths(i)];
    %reset data stores
    data = zeros(max(window),13,max(runs));
    %read the files into data
    for run = runs,
        file_name = strcat('../RationalityData/U', int2str(10*game_point(1)), ...
            'V', int2str(10*game_point(2)), suffix, int2str(run), 'e', ...
            int2str(e_val), '/data.txt');
         data(:,:,run) = dlmread(file_name);
    end;
    
    %reset pqs stores
    pq = zeros(max(window),max(runs));
    pq = data(:,8,:) - data(:,9,:);
    
    %pq_std = zeros(max(window),max(runs));
    %pq_std = data(:,10,:) + data(:,11,:);
    
    pq_smooth = zeros(max(runs),1);
    pq_smooth = mean(pq(window,:),1);
    
    pq_avg(i) = mean(pq_smooth);
    pq_std(i) = std(pq_smooth);
end;

figure;
hold;
plot(PD_depts, pq_avg + pq_std/sqrt(max(runs)));
plot(PD_depts, pq_avg - pq_std/sqrt{max(runs)));
hold;

end
