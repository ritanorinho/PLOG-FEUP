insert_row(Row):- read_row(Row),
                 validate_row(Row).

insert_column(NumberColumn):- read_column(Column),
                       validate_column(Column,NumberColumn).

read_row(Row):- write('Row: \n'),
               read(Row).

read_column(Column):- 
                    write('Column: \n'),
                    read(Column).

validate_column(a,1).
validate_column(b,2).
validate_column(c,3).
validate_column(d,4).
validate_column(e,5).
validate_column(f,6).
validate_column(g,7).
validate_column(h,8).
validate_column(_Column,NumberColumn):- 
    write('Column invalid! Please insert a column between A-G!\n\n'),
    read_column(Input),
    validate_column(Input, NumberColumn).

validate_row(1).
validate_row(2).
validate_row(3).
validate_row(4).
validate_row(5).
validate_row(6).
validate_row(7).
validate_row(8).
validate_row(_Row):- 
    write('Row invalid! Please insert a row between 1-8!\n\n'),
    read_row(Input),
    validate_column(Input).