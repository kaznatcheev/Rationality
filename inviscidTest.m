for n = 1:10
    [data, genotypes, minds] = inviscidRun(200, 10, 0.1);
    scatterplot(genotypes);
    figure;
    hist(genotypes, 10);
    axis([-2, 2, 0, 100]);
end