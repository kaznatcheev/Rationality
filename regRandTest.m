[d,g,m] = regRandRun(100, 100, 10, [], 3, [1, -0.2 ; 1.1, 0]);

prop_coop = (2*d(:,1) + d(:,2))./(2*(d(:,1) + d(:,2) + d(:,3)));
plot(prop_coop);

for i = 1:10
    figure;
    hist3(g(:,:,i));
end