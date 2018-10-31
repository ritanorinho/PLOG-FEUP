:- consult('input.pl').
:- consult('display.pl').
:- consult('logic.pl').


clobber:-   finalBoard(X),
            display_board(X),
            loop_game(X,1,NextPlayer).