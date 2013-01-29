function plotCoop(data, line_spec, epsilon)
%plotCoop(data, line_spec, epsilon)
%input:
%   data - max_epoch x 11 matrix where (at timestep t)
%       [t, 1] is the number of mutual cooperations
%       [t, 2] is the number of unilateral defections
%       [t, 3] is the number of mutual defections
%       [t, 4] is average U
%       [t, 5] is average V
%       [t, 6] is std of U
%       [t, 7] is std of V
%       [t, 8] is average p
%       [t, 9] is average q
%       [t, 10] is std of p
%       [t, 11] is std of q
%   line_spec - what the line should look like (e.g., the color)
%   epsilon - the degree to which the agents' hands are shaky


if (nargin < 2) || isempty(line_spec),
    line_spec = 'b';
end;

if (nargin < 3) || isempty(epsilon),
    epsilon = 0.1;
end;

max_epoch = size(data, 1);
prop_coop = (2*data(:,1) + data(:,2))./(2*(data(:,1) + data(:,2) + data(:,3)));

figure;
plot(prop_coop, line_spec);
hold on;
plot([0, max_epoch], [epsilon, epsilon], 'k--');
hold on
plot([0, max_epoch], [1 - epsilon, 1 - epsilon], 'k--');
axis([0, max_epoch, 0, 1]);

end

