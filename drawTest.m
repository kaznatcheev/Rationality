%Run both simulations.
%[d_i,g_i,m_i] = inviscidRun(20, 200, 10, 0.5, [1, -0.01 ; 1.01, 0]);
%[d_rr,g_rr,m_rr] = regRandRun(100, 200, 10, [], 10, [1, -0.01 ; 1.01, 0]);

%Calculate the proportion of interactions that are cooperations.
prop_coop_i = (2*d_i(:,1) + d_i(:,2))./(2*(d_i(:,1) + d_i(:,2) + d_i(:,3)));
prop_coop_rr = (2*d_rr(:,1) + d_rr(:,2))./(2*(d_rr(:,1) + d_rr(:,2) + d_rr(:,3)));

%Plot the proportion of interactions that are cooperations.
plot(prop_coop_i, 'b');
hold on
plot(prop_coop_rr, 'r');

%Plot the genotypes as 3D histograms.
for i = 1:11
    figure;
    subplot(1,2,1);
    hist3(g_i(:,:,i));
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    %axis([-2, 2, -1, 3, 0, 100]);
    
    subplot(1,2,2);
    hist3(g_rr(:,:,i));
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    %axis([-2, 2, -1, 3, 0, 100]);
end

%Plot the genotypes as bar graphs, according to which game the agents are
%playing.
for i = 1:11
    figure;
    subplot(2,1,1);
    bar(gameTypeCount(g_i(:,:,i)), 'b');
    axis([0, 13, 0, 100]);
    
    subplot(2,1,2);
    bar(gameTypeCount(g_rr(:,:,i)), 'r');
    axis([0, 13, 0, 100]);
end