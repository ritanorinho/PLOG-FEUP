generate_random_move(Player,Board,NewBoard2,BotPlayer):-
    random(0,8,Row),
    random(0,8,Column),
    random(-1,2,IncrementRow),
    random(-1,2,IncrementColumn),
    NewRow is Row + IncrementRow,
    NewColumn is Column + IncrementColumn,
    validate_input(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,'y',BotPlayer,1).


choose_bot_player(Player):-
        random(1,3,Player).

generate_best_move(Player,X,Y,NewX,NewY,NextPlayerMoves,Board,NewBoard2,BotPlayer,BotPlayer2,Try):-
                            Try == 3,
                            validate_input(X,NewX,Y,NewY,Player,Board,NewBoard2,'y',BotPlayer,2,Try),
                            check_game_state(NewBoard2,0,0,Player,'y',BotPlayer,BotPlayer2,2).

generate_best_move(Player,X,Y,NewX,NewY,NextPlayerMoves,Board,NewBoard2,BotPlayer,BotPlayer2,Try):-
                            Try < 3,
                            random(0,8,Row),
                            random(0,8,Column),
                            random(-1,2,IncrementRow),
                            random(-1,2,IncrementColumn),
                            NewRow is Row + IncrementRow,
                            NewColumn is Column + IncrementColumn,
                            check_possible_move(Player,X,Y,NewX,NewY,Row,Column,NewRow,NewColumn,NextPlayerMoves,Board,NewBoard2,BotPlayer,Try).
check_possible_move(Player,X,Y,NewX,NewY,Row,Column,NewRow,NewColumn,NextPlayerMoves,Board,NewBoard2,BotPlayer,Try):-
                            ActualBoard = Board,
                            validate_input(Row,NewRow,Column,NewColumn,Player,Board,NewBoard,'y',BotPlayer,2,Try),    
                            next_player(Player,NextPlayer),
                            check_number_plays(NewBoard,0,0,NextPlayer,0,FinalNumber),
                            verify_best_move(Player,X,Y,NewX,NewY,Row,Column,NewRow,NewColumn,NextPlayerMoves,FinalNumber,BestNumberMoves,ActualBoard,BotPlayer,Try).

check_possible_move(Player,X,Y,NewX,NewY,Row,Column,NewRow,NewColumn,NextPlayerMoves,Board,NewBoard2,BotPlayer,Try):-
                            ActualBoard = Board,
                            \+validate_input(Row,NewRow,Column,NewColumn,Player,Board,NewBoard,'y',BotPlayer,2,Try),
                            generate_best_move(Player,X,Y,NewX,NewY,NextPlayerMoves,ActualBoard,NewBoard2,BotPlayer,Try).

 verify_best_move(Player,X,Y,NewX,NewY,Row,Column,NewRow,NewColumn,OldNextPlayerMoves,ActualNextPlayerMoves,BestNumberMoves,ActualBoard, BotPlayer,Try):-
                                                    OldNextPlayerMoves > ActualNextPlayerMoves,nl,
                                                    BestNumberMoves1 is ActualNextPlayerMoves,
                                                    X1 is Row,
                                                    Y1 is Column,
                                                    NewX1 is NewRow,
                                                    NewY1 is NewColumn,
                                                    Try1 is Try+1,
                                                    generate_best_move(Player,X1,Y1,NewX1,NewY1,BestNumberMoves1,ActualBoard,NewBoard2,BotPlayer,Try1).


verify_best_move(Player,X,Y,NewX,NewY,Row,Column,NewRow,NewColumn,OldNextPlayerMoves,ActualNextPlayerMoves,BestNumberMoves,ActualBoard,BotPlayer,Try):- 
                                                                        BestNumberMoves1 is OldNextPlayerMoves,
                                                                        Try1 is Try +1,
                                                                        generate_best_move(Player,X,Y,NewX,NewY,BestNumberMoves1,ActualBoard,NewBoard2,BotPlayer,Try1).
                                                                        
