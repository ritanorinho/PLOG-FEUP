

generate_random_move(Player,Board,NewBoard2,BotPlayer):-
            valid_moves(Board,Player,ListOfMoves),
            length(ListOfMoves,Size),
            random(0,Size,Position),
            get_value_from_list(ListOfMoves,Position,[X,Y,X1,Y1]),
            validate_input(X,X1,Y,Y1,Player,Board,NewBoard2,'y',BotPlayer,1).


choose_bot_player(Player):-
        random(1,3,Player).


generate_best_move(Player,X,Y,NewX,NewY,Board,NewBoard2,BotPlayer,BotPlayer2):-
                            valid_moves(Board,Player,ListOfMoves),
                            length(ListOfMoves,Size),
                            write(Size),nl,
                            check_best_move(Board,X,Y,NewX,NewY,1000,ListOfMoves,0,Size,BotPlayer,Player).

check_best_move(Board,X,Y,NewX,NewY,BestNextPlay,ListOfMoves,CurrentPosition,Size,BotPlayer,Player):-
                                                write('aaa'),
                                                CurrentPosition == Size,
                                                write(BestNextPlay),nl,
                                                validate_input(X,NewX,Y,NewY,Player,Board,NewBoard2,'y',BotPlayer,2),
                                                check_game_state(NewBoard2,0,0,Player,'y',BotPlayer,0,2).
                                               

check_best_move(Board,X,Y,NewX,NewY,BestNextPlay,ListOfMoves,CurrentPosition,Size,BotPlayer,Player):-
                                                CurrentPosition < Size,                                               
                                                get_value_from_list(ListOfMoves,CurrentPosition,[X1,Y1,X2,Y2]),
                                                Board1 = Board,
                                                validate_input(X1,X2,Y1,Y2,Player,Board,NewBoard,'y',BotPlayer,2),
                                                next_player(Player,NextPlayer),
                                                check_number_plays(NewBoard,0,0,NextPlayer,0,FinalNumber,[],List),
                                                check_best_play(Board1,X,Y,NewX,NewY,X1,Y1,X2,Y2,BestNextPlay,ListOfMoves,CurrentPosition,Size,BotPlayer,Player,FinalNumber).

                                                 

check_best_play(Board,X,Y,NewX,NewY,X1,Y1,X2,Y2,BestNextPlay,ListOfMoves,CurrentPosition,Size,BotPlayer,Player,FinalNumber):-
                                                CurrentPosition < Size,
                                                FinalNumber < BestNextPlay,
                                                CurrentPosition1 is CurrentPosition+1,
                                                check_best_move(Board,X1,Y1,X2,Y2,FinalNumber,ListOfMoves,CurrentPosition1,Size,BotPlayer,Player).
    
check_best_play(Board,X,Y,NewX,NewY,X1,Y1,X2,Y2,BestNextPlay,ListOfMoves,CurrentPosition,Size,BotPlayer,Player,FinalNumber):-
                                                FinalNumber >= BestNextPlay,
                                                CurrentPosition1 is CurrentPosition+1,
                                                check_best_move(Board,X,Y,NewX,NewY,BestNextPlay,ListOfMoves,CurrentPosition1,Size,BotPlayer,Player).
                                        

                