:- consult('input.pl').
:- consult('display.pl').
:- consult('logic.pl').
:- consult('bot.pl').
:- use_module(library(random)).


clobber:-   initialBoard(X),
            display_board(X),
            choose_bot_player(BotPlayer),
            loop_game(X,1,NextPlayer,'y',BotPlayer).