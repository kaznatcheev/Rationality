for n = 1:1
    [data, genotypes, minds] = regRandRun(200, 1000, 0.1, 10);
    scatterplot(genotypes);
    figure;
    hist(genotypes, 10);
    axis([-2, 2, 0, 100]);
end