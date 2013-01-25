function game_num = gameNum(U,V)

%game_num = gameNum(U,V)
%   Looks at the games given by (U),(V) and returns its number as provided
%   at http://egtheory.wordpress.com/2012/03/14/uv-space/. (game_num) is an
%   integer between 1 and 12.

if (U < 0),
    if (V > 1),
        game_num = 1; %Prisoner's dilemma
    elseif (V > 0),
        game_num = 5; %Assurance
    elseif (V > U),
        game_num = 9;
    else
        game_num = 10;
    end;
elseif (U < 1),
    if (V > 1),
        game_num = 2; %Hawk-Dove
    elseif (V > U),
        game_num = 6; %Harmony
    elseif (V > 0),
        game_num = 7;
    else
        game_num = 11;
    end;
else
    if (V > U),
        game_num = 3; %Leader
    elseif (V > 1),
        game_num = 4; %BotS
    elseif (V > 0),
        game_num = 8;
    else
        game_num = 12; %Deadlock
    end;
end;

end

