:- consult('input.pl').
:- consult('display.pl').
:- consult('logic.pl').


clobber:-  initialBoard(X),
            display_board(X),
            loop_game(X,1,NextPlayer).