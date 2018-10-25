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
    replace_in_matrix(H,NewRow,Column,Value,T1).
    
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
    NewRow is Row -1,
    get_value_from_matrix(T,NewRow,Column,Value).

ask_new_play(Boarder, Player,ActualRow,ActualColumn,NewRow, NewColumn, NewBoarder):-
        insertRow(ActualRow),
        insertColumn(ActualColumn),
        get_value_from_matrix(Boarder,ActualRow,ActualColumn,Value),
        insertRow(NewRow),
        insertColumn(NewColumn).


