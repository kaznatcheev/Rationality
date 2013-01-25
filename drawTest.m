%Run both simulations.
tic;
[d_i,g_i,m_i] = inviscidRun(100, 500, 10, [], 10, [1, -0.01 ; 1.01, 0]);
toc
tic;
[d_rr,g_rr,m_rr] = regRandRun(100, 500, 10, [], 10, [1, -0.01 ; 1.01, 0]);
toc

%Calculate the proportion of interactions that are cooperations.
prop_coop_i = (2*d_i(:,1) + d_i(:,2))./(2*(d_i(:,1) + d_i(:,2) + d_i(:,3)));
prop_coop_rr = (2*d_rr(:,1) + d_rr(:,2))./(2*(d_rr(:,1) + d_rr(:,2) + d_rr(:,3)));

%Plot the proportion of interactions that are cooperations.
plot(prop_coop_i, 'r');
hold on
plot(prop_coop_rr, 'b');

%Plot the genotypes as 2D histograms.
boundaries = [-2, 2, -1, 3];
for i = 1:11
    figure;
    subplot(1,2,1);
    densityPlot(g_i(:,:,i), boundaries);
    
    subplot(1,2,2);
    densityPlot(g_rr(:,:,i), boundaries);
end

%Plot the genotypes as bar graphs, according to which game the agents are
%playing.
for i = 1:11
    figure;
    bar([gameTypeCount(g_rr(:,:,i)), gameTypeCount(g_i(:,:,i))], 'grouped');
    axis([0, 13, 0, 100]);
end

%Plot the average p and q for inviscid agents.
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