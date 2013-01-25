[d,g,m] = inviscidRun(100, 20, 10, 0.5, [1, -0.2 ; 1.1, 0]);

prop_coop = (2*d(:,1) + d(:,2))./(2*(d(:,1) + d(:,2) + d(:,3)));
plot(prop_coop);

for i = 1:11
    figure;
    hist3(g(:,:,i));
end