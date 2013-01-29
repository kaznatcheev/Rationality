function visParam(game_point,runs)
%visParam

if (nargin < 2) || isempty(runs),
    runs = 1:5;
end;

game_dir = strcat('../RationalityData/U', int2str(10*game_point(1)), 'V', int2str(10*game_point(2)));

for run = runs,
    data_bi(:,:,run) = dlmread(strcat(game_dir,'/bi',int2str(run),'/data.txt'));
    data_bv(:,:,run) = dlmread(strcat(game_dir,'/bv',int2str(run),'/data.txt'));
    data_ni(:,:,run) = dlmread(strcat(game_dir,'/ni',int2str(run),'/data.txt'));
    data_nv(:,:,run) = dlmread(strcat(game_dir,'/nv',int2str(run),'/data.txt'));
end;

figure;
hold on;
for run = runs,
    prop_coop = (2*data_bv(:,1,run) + data_bv(:,2,run))./(2*(data_bv(:,1,run) + data_bv(:,2,run) + data_bv(:,3,run)));
    plot(prop_coop,'b');
    prop_coop = (2*data_nv(:,1,run) + data_nv(:,2,run))./(2*(data_nv(:,1,run) + data_nv(:,2,run) + data_nv(:,3,run)));
    plot(prop_coop,'g');
    prop_coop = (2*data_bi(:,1,run) + data_bi(:,2,run))./(2*(data_bi(:,1,run) + data_bi(:,2,run) + data_bi(:,3,run)));
    plot(prop_coop,'y')
    prop_coop = (2*data_ni(:,1,run) + data_ni(:,2,run))./(2*(data_ni(:,1,run) + data_ni(:,2,run) + data_ni(:,3,run)));
    plot(prop_coop,'r')
end;
hold off;

figure;
hold on;
for run = runs,
   plot(data_bv(:,4,run),'b');
   plot(data_bv(:,5,run),'g');
   
   plot(data_ni(:,4,run),'y');
   plot(data_ni(:,5,run),'r');
end;
plot([0 size(data_bv,1)],[0 0], 'k-');
plot([0 size(data_bv,1)],[1 1], 'k-');
plot([0 size(data_bv,1)],[game_point(1),game_point(1)],'k--');
plot([0 size(data_bv,1)],[game_point(2),game_point(2)],'k--');
hold off;

end

