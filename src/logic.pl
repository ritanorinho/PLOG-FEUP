next_player(1,2).
next_player(2,1).

replace_in_list([_H|T],0,Value,[Value|T]).
replace_in_list([H|T],Index,Value,[H|T1]):-
    Index > 0,
    NewIndex is Index - 1,
    replace_in_list(T,NewIndex,Value,T1).

replace_in_matrix([H|T],0,Column,Value,[H1|T]):-
    replace_in_list(H,Column,Value,H1).

replace_in_matrix([H|T],Row,Column,Value,[H|T1]) :-
    Row > 0,
    NewRow is Row - 1,
    replace_in_matrix(T,NewRow,Column,Value,T1).
    
get_value_from_list([H|_T],0,Value):-
        Value= H.


get_value_from_list([_H|T],Index,Value):-
        Index > 0,
        NewIndex is Index - 1,
        get_value_from_list(T,NewIndex,Value).

get_value_from_matrix([H|_T],0,Column,Value):-
    get_value_from_list(H,Column,Value).

get_value_from_matrix([_H|T],Row,Column,Value):-
    Row > 0,
    NewRow is Row - 1,
    get_value_from_matrix(T,NewRow,Column,Value).

go_through_matrix([H|T]):-
    go_through_list(H),
    go_through_matrix(T).
go_through_matrix([]).

go_through_list([],Value).
%go_through_list([H|T],Value):-


check_victory(Board,1):-

ask_new_play(Board, 1 ,NextPlayer,ActualRow,ActualColumn,NewRow, NewColumn, NewBoard):-
        write('PLAYER 1\n'),
        ask_new_position(ActualRow,NewRow,ActualColumn,NewColumn),
        replace_in_matrix(Board,NewRow,NewColumn,'white',NewBoard),
        replace_in_matrix(NewBoard,ActualRow,ActualColumn,'empty',NewBoard2),
        next_player(1,NextPlayer),
        display_board(NewBoard2),
         loop_game(NewBoard2,NextPlayer,Player1).

ask_new_play(Board, 2 ,NextPlayer,ActualRow,ActualColumn,NewRow, NewColumn, NewBoard):-
        write('PLAYER 2\n'),
        ask_new_position(ActualRow,NewRow,ActualColumn,NewColumn),
        replace_in_matrix(Board,NewRow,NewColumn,'black',NewBoard),
        replace_in_matrix(NewBoard,ActualRow,ActualColumn,'empty',NewBoard2),
        next_player(2,NextPlayer),
        display_board(NewBoard2),
         loop_game(NewBoard2,NextPlayer,Player1).

loop_game(Board,Player,NextPlayer):-
                    ask_new_play(Board, Player ,NextPlayer,ActualRow,ActualColumn,NewRow, NewColumn, NewBoard).