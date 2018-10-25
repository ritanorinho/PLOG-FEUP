:- consult('input.pl').
:- consult('display.pl').
:- consult('logic.pl').


clobber:-  initialBoard(X),
            ask_new_play(X, Player,ActualRow,ActualColumn,NewRow, NewColumn, NewBoard).