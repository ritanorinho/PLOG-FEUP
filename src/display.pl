initialBoard([[black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black],
              [black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black],
              [black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black],
              [black,white,black,white,black,white,black,white],
              [white,black,white,black,white,black,white,black]
]).
translate(empty,'.').
translate(black,'O').
translate(white,'W').
incr(X, X1) :-
                X1 is X+1.
display_board([H|T]):-  
                    nl,
                    write('  | A | B | C | D | E | F | G | H |\n'),
                    write('  |---|---|---|---|---|---|---|---|\n'),
                    print_tab([H|T],1).
print_tab([],_).
print_tab([H|T],X):- 
                write(X),
                write(' '),
                write('|'),
                write(' '),
                print_line(H),
                 
                nl,
                write('  |---|---|---|---|---|---|---|---|\n'),
                incr(X,X1),
                print_tab(T,X1).

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


