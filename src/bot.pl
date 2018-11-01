generate_random_move(Row,Column,NewRow,NewColumn,Player,Board):-
    random(0,7,Row),
    random(0,7,Column),
    random(-1,1,IncrementRow),
    random(-1,1,IncrementColumn),
    NewRow is Row + IncrementRow,
    NewColumn is Column + IncrementColumn,
    validate_input(Row,NewRow,Column,NewColumn,Player,Board,'y').


