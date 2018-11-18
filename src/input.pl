
/* Predicado que vai receber o input de fila do jogador e ve se é válido */
insert_row(NumberRow):- read_row(Row),
                        validate_row(Row,NumberRow).

                        

/* Predicado que vai receber o input de coluna do jogador e ve se é válido */
insert_column(NumberColumn):- read_column(Column),
                       validate_column(Column,NumberColumn).

/* Pede um input de fila ao utilizador, recebe-o e confirma se é um número inteiro */
read_row(Row):- write('Row: '),nl,
               read(Row),
               integer(Row).

/* Caso o input não tenha sido válido, pede-o novamente */
read_row(Row):-  write('Row invalid! Your row must be an integer between 1-8!\n\n'),
                 read_row(Row).

/* Pede um input de coluna ao utilizador, recebe-o e confirma se é um átomo(letra) */
read_column(Column):- 
                    write('Column: '),nl,
                    read(Column),
                    atom(Column).

/* Caso o input não tenha sido válido, pede-o novamente */
read_column(Column):-    write('Column invalid! Your column must be a letter between 1-8!\n\n'),
                         read_column(Column).

/*Factos que validam o input das colunas, faz a tradução das letras de cada coluna para indices de números*/
validate_column(a,0).
validate_column(b,1).
validate_column(c,2).
validate_column(d,3).
validate_column(e,4).
validate_column(f,5).
validate_column(g,6).
validate_column(h,7).

/*Caso não seja nenhum dos factos anteriores, o input da coluna não é validado e é pedido outra vez o input */
validate_column(_Column,NumberColumn):- 
    write('Column invalid! Please insert a column between a-h!\n\n'),
    read_column(Input),
    validate_column(Input, NumberColumn).

/* Factos que validam o input das filas */
validate_row(1,0).
validate_row(2,1).
validate_row(3,2).
validate_row(4,3).
validate_row(5,4).
validate_row(6,5).
validate_row(7,6).
validate_row(8,7).

/*Caso não seja nenhum dos factos anteriores, o input da fila não é validado e é pedido outra vez o input */
validate_row(_Row,NumberRow):- 
    write('Row invalid! Please insert a row between 1-8!\n\n'),
    read_row(Input),
    validate_row(Input,NumberRow).

/* Predicado que verifica se a peça que se quer movimentar é uma das peças do jogador atual,
no caso de ser, analisa se a nova posição tem uma das peças do jogador adversário */
validate_move(Row,NewRow,Column,NewColumn,Player,Board,BotPlayer):-
        get_value_from_matrix(Board,Row,Column,Value),
        player_piece(Player,Piece),
        Value == Piece,
        get_value_from_matrix(Board,NewRow,NewColumn,Value1),
        next_player(Player,NextPlayer),
        player_piece(NextPlayer,NextPiece),
        Value1 == NextPiece.

/* Predicado que vai verificar se a posição atual do jogador e a nova posição pretendida
são adjacentes. Valida a jogada chamando o predicado validate_move e, no caso deste suceder, o replace_in_matrix*/
move(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,Bot,BotPlayer,Difficulty):-
        Row == NewRow,
        NewColumn =:= Column +1,
        validate_move(Row,NewRow,Column,NewColumn,Player,Board,BotPlayer),
        player_piece(Player,Piece),
        replace_in_matrix(Board,NewRow,NewColumn,Piece,NewBoard),
        replace_in_matrix(NewBoard,Row,Column,'empty',NewBoard2),
        show_positions(Row,NewRow,Column,NewColumn).
move(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,Bot,BotPlayer,Difficulty):-
       
        Row==NewRow,
        NewColumn =:= Column - 1,
        validate_move(Row,NewRow,Column,NewColumn,Player,Board,BotPlayer),
         player_piece(Player,Piece),
        replace_in_matrix(Board,NewRow,NewColumn,Piece,NewBoard),
        replace_in_matrix(NewBoard,Row,Column,'empty',NewBoard2),
        show_positions(Row,NewRow,Column,NewColumn).
move(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,Bot,BotPlayer,Difficulty):-
        
        Column==NewColumn,
         NewRow =:= Row -1,
        validate_move(Row,NewRow,Column,NewColumn,Player,Board,BotPlayer),
        player_piece(Player,Piece),
        replace_in_matrix(Board,NewRow,NewColumn,Piece,NewBoard),
        replace_in_matrix(NewBoard,Row,Column,'empty',NewBoard2),
        show_positions(Row,NewRow,Column,NewColumn).
move(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,Bot,BotPlayer,Difficulty):-
        Column==NewColumn,
        NewRow =:= Row + 1,
        validate_move(Row,NewRow,Column,NewColumn,Player,Board,BotPlayer),
        player_piece(Player,Piece),
        replace_in_matrix(Board,NewRow,NewColumn,Piece,NewBoard),
        replace_in_matrix(NewBoard,Row,Column,'empty',NewBoard2),
        show_positions(Row,NewRow,Column,NewColumn).

/* No caso das coordenadas não serem adjacentes, há uma mensagem de erro e é pedida novamente
a jogada ao jogador */
move(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,Bot,BotPlayer,0) :-
    write('Your new coordinates must be adjacent with actual position and you only can move your pieces!!\n'),
    ask_new_position(Player,Board,NewBoard2,Bot,BotPlayer).

/* Predicado que pede o input ao jogador da posição da peça que este quer mover e a posição
para onde quer ir, sendo chamado então depois o predicado move que vai validar a jogada*/
ask_new_position(Player,Board,NewBoard2,Bot,BotPlayer):-
        insert_row(Row),
        insert_column(Column),
        insert_row(NewRow),
        insert_column(NewColumn),
        show_positions(Row,NewRow,Column,NewColumn),
        move(Row,NewRow,Column,NewColumn,Player,Board,NewBoard2,Bot,BotPlayer,0).

/* Vai mostrar o movimento que foi executado, depois de ter sido validado */
show_positions(Row,NewRow,Column,NewColumn):-
                         validate_row(Row1,Row),
                         validate_row(Row2,NewRow),
                         validate_column(Column1,Column),
                         validate_column(Column2,NewColumn),
                         write('MOVEMENT'),nl,
                         write('['), write(Row1), write(','),write(Column1),write(']'),nl,
                         write('['), write(Row2), write(','),write(Column2),write(']'),nl.

                                        