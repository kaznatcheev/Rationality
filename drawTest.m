%Run both simulations.
offset = 0.15;
epsilon = 0.1;
max_epoch = 200;

tic;
[d_i,g_i,m_i] = inviscidRun(200, max_epoch, 10, 0.1, 3, [1, -offset ; 1 + offset, 0], epsilon);
toc
tic;
[d_rr,g_rr,m_rr] = regRandRun(200, max_epoch, 10, 0.1, 3, [1, -offset ; 1 + offset, 0], epsilon);
toc

%Calculate the proportion of interactions that are cooperations.
prop_coop_i = (2*d_i(:,1) + d_i(:,2))./(2*(d_i(:,1) + d_i(:,2) + d_i(:,3)));
prop_coop_rr = (2*d_rr(:,1) + d_rr(:,2))./(2*(d_rr(:,1) + d_rr(:,2) + d_rr(:,3)));

%Plot the proportion of interactions that are cooperations.
plot(prop_coop_i, 'r');
hold on
plot(prop_coop_rr, 'b');
fplot(@(x) 1 - epsilon, [0 max_epoch*10], 'k--');
fplot(@(x) epsilon, [0 max_epoch*10], 'k--');
axis([0, max_epoch * 10, 0, 1]);
hold off

%Plot the genotypes as 2D histograms, and as bar graphs according wo which
%game the agents think they are playing
boundaries = [-2, 2, -1, 3];
for i = 1:11
    figure;
    subplot(2,2,1);
    densityPlot(g_i(:,:,i), boundaries, [-offset, 1 + offset], [], 1);
    title('Density plot of inviscid run');
    
    subplot(2,2,2);
    densityPlot(g_rr(:,:,i), boundaries, [-offset, 1 + offset], [], 1);
    title('Density plot of viscous run');
    
    subplot(2,2,[3 4]);
    bar([gameTypeCount(g_rr(:,:,i)), gameTypeCount(g_i(:,:,i))], 'grouped');
    axis([0, 13, 0, length(g_i(:,:,i))]);
end

%Plot the average p and q for inviscid agents.
figure;
plot(d_i(:,8), 'r');
hold on
plot(d_i(:,8) - d_i(:,10), 'r');
hold on
plot(d_i(:,8) + d_i(:,10), 'r');

hold on
plot(d_i(:,9), 'b');
hold on
plot(d_i(:,9) - d_i(:,11), 'b');
hold on
plot(d_i(:,9) + d_i(:,11), 'b');

hold on
plot(prop_coop_i, 'k');

%Plot the average p and q for regular random graph agents.
figure;
plot(d_rr(:,8), 'r');
hold on
plot(d_rr(:,8) - d_rr(:,10), 'r');
hold on
plot(d_rr(:,8) + d_rr(:,10), 'r');

hold on
plot(d_rr(:,9), 'b');
hold on
plot(d_rr(:,9) - d_rr(:,11), 'b');
hold on
plot(d_rr(:,9) + d_rr(:,11), 'b');

hold on
plot(prop_coop_rr, 'k');