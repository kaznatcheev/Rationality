function edge_list = adjmx2edge_list(adjmx)
%edge_list = adjmx2edge_list(adjmx)
%   Assumes that (adjmx) is a simple undirected graph, and returns the
%   corresponding (edge_list)

n_vert = length(adjmx);
edge_list = zeros(sum(sum(adjmx))/2,2);
k = 1;

for i = 1:n_vert,
    for j = i:n_vert,
        if adjmx(i,j),
            edge_list(k,1) = i;
            edge_list(k,2) = j;
            k = k + 1;
        end;
    end;
end;

end