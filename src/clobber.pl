:- consult('input.pl').
:- consult('display.pl').
:- consult('logic.pl').
:- consult('bot.pl').
:- use_module(library(random)).


clobber:-   finalBoard(X),
            %display_board(X),
            loop_game(X,1,NextPlayer).