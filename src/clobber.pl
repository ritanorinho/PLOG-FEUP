:- consult('input.pl').
:- consult('display.pl').


clobber:-  insertRow(Y),
           insertColumn(Z),
           initialBoard(X),
           display_board(X).