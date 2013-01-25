function densityPlot(data, boundaries, n_bins)
%densityPlot(data, boundaries, n_bins)
%

if (nargin < 3) || isempty(n_bins),
    n_bins = floor(sqrt(length(data)));
end;

if (nargin < 2) || isempty(boundaries),
    boundaries = [min(data(:,1)), max(data(:,1)), min(data(:,2)), max(data(:,2))];
end;

xi = linspace(boundaries(1), boundaries(2), n_bins);
yi = linspace(boundaries(3), boundaries(4), n_bins);

C = {xi, yi};

z = hist3(data,C);
pcolor(xi,yi,z);
caxis([0 0.5*length(data)]);
colormap(flipud(gray));
shading interp;
end

