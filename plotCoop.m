function prop_coop = plotCoop(data, epsilon, game_point, tocs_array, save_dir, line_spec)
%prop_coop = plotCoop(data, line_spec, gp, tocs, save_dir, line_spec)
%
%Plots a nice figure of the coop data given input:
%   data - max_epoch x 11 matrix where (at timestep t)
%       [t, 1] is the number of mutual cooperations
%       [t, 2] is the number of unilateral defections
%       [t, 3] is the number of mutual defections
%   epsilon - the degree to which the agents' hands are shaky
%   gp - game point [U,V] of real game
%   tocs - array of points at which to plot vertical yellow lines
%   save_dir    - directory where to save, if empty then no plot is made,
%               if 0 then plot made but not saved
%   line_spec - what the line should look like (e.g., the color)

if (nargin < 5) || isempty(line_spec),
    line_spec = 'b';
end;

if (nargin < 4) || isempty(save_dir),
    save_dir = [];
end;

if (nargin < 3) || isempty(game_point),
    game_point = [];
end;

if (nargin < 2) || isempty(epsilon),
    epsilon = [];
end;

max_epoch = size(data, 1);
prop_coop = (2*data(:,1) + data(:,2))./(2*(data(:,1) + data(:,2) + data(:,3)));


if ~isempty(save_dir),
    h = figure;
    
    plot(prop_coop,line_spec);
    
    hold on;
    
    for line_x = tocs_array, %add the vertical lines
        plot([line_x, line_x], [0, 1], 'y');
    end;
    
    if ~isempty(epsilon), %plot the epsilon bounds of shaky-hand
        fplot(@(x) 1 - epsilon,[0 max_epoch],'k');
        fplot(@(x) epsilon,[0 max_epoch],'k');
    end;
    
    hold off;
    axis([0, max_epoch, 0, 1]);
    
    %make the title
    title_text = 'Proportion of cooperative interactions';
    if ~isempty(game_point),
        title_text = strcat(title_text, ' (U=', num2str(game_point(1)), ...
            ' V=', num2str(game_point(2)), ')');
    end;
    title(title_text);
    
    if save_dir, %save the image
        print(h,'-dpng',strcat(save_directory, '/cooperation.png'));
    end;
end;

end

