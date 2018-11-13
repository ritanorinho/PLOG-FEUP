/* JOGADOR VS JOGADOR*/
start_game(1):-
                initialBoard(Board),
                display_board(Board),
                loop_game(Board,1,NextPlayer,'n',0,0,0).
/*JOGADOR VS COMPUTADOR NIVEL 1*/
start_game(2):-initialBoard(Board),
                display_board(Board),
                choose_bot_player(BotPlayer),
                loop_game(Board,1,NextPlayer,'y',BotPlayer,0,1).
/*JOGADOR VS COMPUTADOR NIVEL 2*/
start_game(3):-initialBoard(Board),
                display_board(Board),
                choose_bot_player(BotPlayer),
                loop_game(Board,1,NextPlayer,'y',1,0,2).

/*COMPUTADOR VS COMPUTADOR*/
start_game(4):-
                initialBoard(Board),
                display_board(Board),
                loop_game(Board,1,NextPlayer,'y',1,2,1).


main_menu:- /*write('1- JOGADOR VS JOGADOR'),nl,
            write('2- JOGADOR VS COMPUTADOR NIVEL 1'),nl,
            write('3- JOGADOR VS COMPUTADOR NIVEL 2'),nl,
            write('4- COMPUTADOR VS COMPUTADOR'),nl,
            write('INSERT YOUR OPTION: '),
            read(Option),
            start_game(3).*/
            start_game(3).


