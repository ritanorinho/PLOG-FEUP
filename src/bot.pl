generate_random_move(Player,Board,NewBoard2,BotPlayer):-
    random(0,8,Row),
    random(0,8,Column),
    random(-1,2,IncrementRow),
    random(-1,2,IncrementColumn),
    NewRow is Row + IncrementRow,
    NewColumn is Column + IncrementColumn,
    validate_input(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,'y',BotPlayer).


choose_bot_player(Player):-
        random(1,3,Player).