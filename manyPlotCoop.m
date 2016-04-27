function prop_coops = manyPlotCoop(game_point,suffix,gp_name_factor,runs,c_edges,step_size)

window = 1801:2000;
max_epoch = 2000;

dir_name = strcat('../RationalityData/', ...
    'U', int2str(gp_name_factor*game_point(1)), ...
    'V', int2str(gp_name_factor*game_point(2)), suffix);

%create empty data array to fill
data = zeros(max_epoch,11,max(runs));

%read the files into data
for run = runs,
    file_name = strcat(dir_name,int2str(run),'/data.txt'); %generate file name

    data(:,:,run) = dlmread(file_name); %read data
end;

%calculate proportion of cooperators
prop_coop = zeros(max_epoch,max(runs));
prop_coop = (2*data(:,1,:) + data(:,2,:))./(2*(data(:,1,:) + data(:,2,:) + data(:,3,:)));

prop_end_means = mean(prop_coop(window,:),1)

figure;
hold;
for run = runs,
	if prop_end_means(run) < c_edges(1),
		plot(1:step_size:max_epoch,prop_coop(1:step_size:max_epoch,run),'r-')
	elseif prop_end_means(run) > c_edges(2)
		plot(1:step_size:max_epoch,prop_coop(1:step_size:max_epoch,run),'g-')
	else
		plot(1:step_size:max_epoch,prop_coop(1:step_size:max_epoch,run),'y-')
    end;
end;
axis([0 max_epoch 0 1]);
xlabel('Evolutionary cycle')
ylabel('Proportion of cooperative interactions');
grid;
hold;