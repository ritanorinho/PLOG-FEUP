initialBoard([[black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black],
              [black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black],
              [black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black],
              [black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black]
]).
intermediateBoard([[empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,black,white,empty,empty,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,white,black],
                   [empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,black,white,black,white,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,empty]
]).
finalBoard([[empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,empty,black,empty,empty,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,white],
                   [empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,white,empty,empty,black,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,empty],
                   [empty,empty,empty,empty,empty,empty,empty,empty]
]).
translate(empty,'.').
translate(black,'B').
translate(white,'W').
display_board([H|T]):-  
                    nl,
                    write(' | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |\n'),
                    write(' |   |   |   |   |   |   |   |   |\n'),
                    print_tab([H|T]),
                    write(' |   |   |   |   |   |   |   |   |\n').
print_tab([]).
print_tab([H|T]):- 
                write(' '),
                write('|'),
                write(' '),
                print_line(H),
                nl,
                print_tab(T).

print_line([]).
print_line([C|L]):-
                 print_cel(C),
                 write(' '),
                 write('|'),
                 write(' '),
                 print_line(L).
print_cel(C):-
               translate(C,V),
                write(V).
display_game(L):-  print_tab(L).

