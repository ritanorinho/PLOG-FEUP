next_player(1,2).
next_player(2,1).
player_piece(1,'white').
player_piece(2,'black').
replace_in_list([_H|T],0,Value,[Value|T]).
replace_in_list([H|T],Column,Value,[H|T1]):-
    Column > -1,
    NewColumn is Column - 1,
    replace_in_list(T,NewColumn,Value,T1).

replace_in_matrix([H|T],0,Column,Value,[H1|T]):-
    replace_in_list(H,Column,Value,H1).

replace_in_matrix([H|T],Row,Column,Value,[H|T1]) :-
    Row > -1,
    NewRow is Row - 1,
    replace_in_matrix(T,NewRow,Column,Value,T1).
    
get_value_from_list([H|_T],0,Value):-
        Value= H.


get_value_from_list([_H|T],Column,Value):-
        Column > -1,
        NewColumn is Column - 1,
        get_value_from_list(T,NewColumn,Value).

get_value_from_matrix([H|_T],0,Column,Value):-
    get_value_from_list(H,Column,Value).

get_value_from_matrix([_H|T],Row,Column,Value):-
    Row > -1,
    Row < 8,
    NewRow is Row - 1,
    get_value_from_matrix(T,NewRow,Column,Value).
%percorrer o tabuleiro e a peça encontrada em (X,Y) não é preta, portanto não se faz as verificações
go_through_list([H|T],Piece1,Piece2,X,Y):-
                                get_value_from_matrix([H|T],X,Y,Value),
                                Value \= Piece1.
                           
go_through_list([H|T],Piece1,Piece2,X,Y):-  
                                X1 is X-1,
                                X2 is X+1,
                                Y1 is Y-1,
                                Y2 is Y+1,
                                get_value_from_matrix([H|T],X,Y,Value),
                                Value == Piece1,!,                         
                                (\+(get_value_from_matrix([H|T],X1,Y,Piece2))),!,
                                (\+(get_value_from_matrix([H|T],X2,Y,Piece2))),!,                               
                                (\+(get_value_from_matrix([H|T],X,Y1,Piece2))),!,
                                (\+(get_value_from_matrix([H|T],X,Y2,Piece2))).

%quando chega ao final da linha tem que passar para a linha seguinte e a coluna volta a 0
check_victory(Board,X,7,Player):- 
                            X1 is X+1,
                            Y is 0,
                            check_victory(Board,X1,Y,Player).
%quando chega ao final do tabuleiro
check_victory(Board,7,7,Player):- display_board(Board),write('Player '),write(Player),write(' won the game!!!\n').
%verificar se jogador1 ganhou
check_victory(Board, X,Y,Player):-
    player_piece(Player,Piece),
    next_player(Player,NextPlayer),
    player_piece(NextPlayer,Piece2),
    go_through_list(Board,Piece,Piece2,X,Y),
    Y1 is Y+1,
    check_victory(Board,X,Y1,Player).
  


check_game_state(Board,X,Y,Player,Bot,BotPlayer,BotPlayer2):- check_victory(Board,X,Y,Player).

check_game_state(Board,X,Y,Player,Bot,BotPlayer,BotPlayer2):- \+check_victory(Board,X,Y,Player),
                                    next_player(Player,NextPlayer),
                                    display_board(Board),
                                    loop_game(Board,NextPlayer,Player1,Bot,BotPlayer,BotPlayer2).


ask_new_play(Board, Player ,NextPlayer, NewBoard,Bot,BotPlayer1,BotPlayer2):-
        Bot == 'y',
        Player==BotPlayer1, 
        write('PLAYER '), write(Player),nl,
        generate_random_move(Player,Board,NewBoard2,BotPlayer1),
        check_game_state(NewBoard2,0,0,Player,'y',BotPlayer1,BotPlayer2).

ask_new_play(Board, Player ,NextPlayer, NewBoard,Bot,BotPlayer1,BotPlayer2):-
        Bot == 'y',
        Player==BotPlayer2, 
        write('PLAYER '), write(Player),nl,
        generate_random_move(Player,Board,NewBoard2,BotPlayer2),
        check_game_state(NewBoard2,0,0,Player,'y',BotPlayer1,BotPlayer2).

ask_new_play(Board, Player ,NextPlayer, NewBoard,Bot,BotPlayer1,BotPlayer2):-
        BotPlayer2 == 0,
        write('PLAYER '), write(Player),nl,
        ask_new_position(Player,Board,NewBoard2,BotPlayer1),
        check_game_state(NewBoard2,0,0,Player,Bot,BotPlayer1,BotPlayer2).


loop_game(Board,Player,NextPlayer,Bot,BotPlayer1,BotPlayer2):-
                   ask_new_play(Board, Player ,NextPlayer, NewBoard,Bot,BotPlayer1,BotPlayer2).