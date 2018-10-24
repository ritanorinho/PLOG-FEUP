:- consult('display.pl').
:- consult('input.pl').

clobber:-  insertRow(Y),
           insertColumn(Z).
         