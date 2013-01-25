function game_type_count = gameTypeCount(genotypes)
%game_type_count = gameTypeCount(genotypes)
%   Looks at the games the agents in (genotypes) think they are playing and
%   counts how many belong to each game cooperate-defect game type as given
%   in http://egtheory.wordpress.com/2012/03/14/uv-space/. The i-th index
%   (from 1 to 12) of the output reports the number of agents who have the
%   corresponding game type.

game_type_count = zeros(12,1);

for i = 1:size(genotypes,1),
    game_num = gameNum(genotypes(i,1),genotypes(i,2));
    game_type_count(game_num) = game_type_count(game_num) + 1;
end;

end

