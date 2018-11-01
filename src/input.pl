insert_row(NumberRow):- read_row(Row),
                 validate_row(Row,NumberRow).

insert_column(NumberColumn):- read_column(Column),
                       validate_column(Column,NumberColumn).

read_row(Row):- write('Row: '),nl,
               read(Row).

read_column(Column):- 
                    write('Column: '),nl,
                    read(Column).

validate_column(a,0).
validate_column(b,1).
validate_column(c,2).
validate_column(d,3).
validate_column(e,4).
validate_column(f,5).
validate_column(g,6).
validate_column(h,7).
validate_column(_Column,NumberColumn):- 
    write('Column invalid! Please insert a column between A-H!\n\n'),
    read_column(Input),
    validate_column(Input, NumberColumn).

validate_row(1,0).
validate_row(2,1).
validate_row(3,2).
validate_row(4,3).
validate_row(5,4).
validate_row(6,5).
validate_row(7,6).
validate_row(8,7).
validate_row(_Row,NumberRow):- 
    write('Row invalid! Please insert a row between 1-8!\n\n'),
    read_row(Input),
    validate_row(Input,NumberRow).

validate_move(Row,NewRow,Column,NewColumn,Player,Board):- 
        get_value_from_matrix(Board,Row,Column,Value),
        player_piece(Player,Piece),
        Value == Piece,
        get_value_from_matrix(Board,NewRow,NewColumn,Value1),
        next_player(Player,NextPlayer),
        player_piece(NextPlayer,NextPiece),
        Value1 == NextPiece.
validate_input(Row,NewRow,Column,NewColumn,Player,Board):-
        validate_move(Row,NewRow,Column,NewColumn,Player,Board),
        Row == NewRow,
        NewColumn =:= Column +1.
validate_input(Row,NewRow,Column,NewColumn,Player,Board):-
        validate_move(Row,NewRow,Column,NewColumn,Player,Board),
        Row==NewRow,
        NewColumn =:= Column - 1.
validate_input(Row,NewRow,Column,NewColumn,Player,Board):-
        validate_move(Row,NewRow,Column,NewColumn,Player,Board),
        Column==NewColumn,
         NewRow =:= Row -1.
validate_input(Row,NewRow,Column,NewColumn,Player,Board):-
        validate_move(Row,NewRow,Column,NewColumn,Player,Board),
        Column==NewColumn,
        NewRow =:= Row + 1.
validate_input(Row,NewRow,Column,NewColumn,Player,Board) :-
    write('Your new coordinates must be adjacent with actual position!\n'),
    ask_new_position(ActualRow,NRow,ActualColumn,NColumn).

ask_new_position(ActualRow,NewRow,ActualColumn,NewColumn,Player,Board):-
        insert_row(ActualRow),
        insert_column(ActualColumn),
        insert_row(NewRow),
        insert_column(NewColumn),
        validate_input(ActualRow,NewRow,ActualColumn,NewColumn,Player,Board).
