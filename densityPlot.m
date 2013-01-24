function densityPlot(data, boundaries, n_bins)
%densityPlot(data, boundaries, n_bins)
%

if (nargin < 3) || isempty(n_bins),
    n_bins = 10;
end;

if (nargin < 2) || isempty(boundaries),
    boundaries = [min(data(:,1)), max(data(:,1)), min(data(:,2)), max(data(:,2))];
end;

xi = linspace(boundaries(1), boundaries(2), n_bins);
yi = linspace(boundaries(3), boundaries(4), n_bins);

xr = interp1(xi,1:numel(xi),data(:,1),'nearest')';
yr = interp1(yi,1:numel(yi),data(:,2),'nearest')';

z = accumarray([xr yr], 1, [n_bins n_bins]);

surf(z);

end

