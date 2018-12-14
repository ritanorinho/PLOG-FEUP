:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).
:-use_module(library(samsort)).

class1([1,1,1,1,2,2,2,2,3,4,3,4,3,4,3,4]).
class2([1,2,1,2,2,2,3,1,1,3,3,4,4,4,3,4]).


generate_grades([],0,FinalList,SortedList,Minimum,Maximum):- samsort(FinalList,SortedList).
generate_grades([H|T],Index,FinalList,SortedList,Minimum,Maximum):-
                  Index > 0,
                  Index1 is Index-1,
                  random(Minimum,Maximum,H),
                  append(FinalList,[H],FinalList1),
                  generate_list(T,Index1,FinalList1,SortedList,Minimum,Maximum).
generate_groups([],0,_,Minimum,Maximum).
generate_groups([H|T],Index,FinalList,Minimum,Maximum):-
                  Index > 0,
                  Index1 is Index-1,
                  random(Minimum,Maximum,H),
                  append(FinalList,[H],FinalList1),
                  generate_groups(T,Index1,FinalList1,Minimum,Maximum).

analyze_groups(Groups,Grades,NumberGroups).


groups(NumberStudents):-class1(X),
                        length(Groups1,NumberStudents),
                        calculate_number_groups(NumberStudents,Groups4,Groups3), 
                        NumberGroups #= Groups3+Groups4,
                        domain(Groups1,1,NumberGroups),
                        list_global(0,Groups3,3,[],List),
                        list_global(Groups3,NumberGroups,4,List,FinalList),
                        global_cardinality(Groups1,FinalList),
                        count_repetitions(Groups1,Acc,X),
                        labeling([minimize(Acc)],Groups1),write(X),nl,write(Groups1),nl,
                        length(Groups2,NumberStudents),
                        domain(Groups2,1,NumberGroups),
                        global_cardinality(Groups2,FinalList),
                        count_repetitions(Groups2,Acc1,X),
                        go_through_class(Groups2,Groups1),
                        labeling([minimize(Acc1)],Groups2),write(Groups2). 



list_global(CurrPosition,NumberGroups,NumberElements,FinalList,FinalList):- CurrPosition >= NumberGroups.
list_global(CurrPosition,NumberGroups,NumberElements,CurrList,FinalList):-
                                                           CurrPosition < NumberGroups,                                          
                                                           CurrPosition1 is CurrPosition+1,
                                                           append(CurrList,[CurrPosition1-NumberElements],CurrList1),
                                                           list_global(CurrPosition1,NumberGroups,NumberElements,CurrList1,FinalList).


go_through_class([_],_).
go_through_class([H|T],X):-duos([H|T],2,X),
                           go_through_class(T,X).

duos([_,_],Index,_).
duos([A,B,C|T],Index,X):- 
                      element(1,X,Val1),
                      element(Index,X,Val2),
                      Index1 #= Index + 1,
                      ((A #\= B) #\/ Val1 #\= Val2),
                      duos([A,C|T],Index1,X).


count_repetitions([_],0,X).

count_repetitions([H|T],Acc,X):- repetitions([H|T],X,Acc1,1),
                                 count_repetitions(T,Acc2,X),
                                 Acc #= Acc2+Acc1.
repetitions([_,_],_,0,_).
repetitions([A,B,C|T],X,Acc,Index):-     Index1 #= Index + 1,                                         
                                         repetitions([A,C|T],X,Acc1,Index1),
                                         element(1,X,Val1),
                                         element(Index1,X,Val2),
                                         (Val1 #= Val2 #/\ A #=B)#<=>Bin,
                                         Acc #= Acc1 + Bin.



calculate_number_groups(Students,NumberGroups4,NumberGroups3):- 
                  Values=[NumberGroups4,NumberGroups3],
                  NumberGroups3 in 0..Students,
                  NumberGroups4 in 0..Students,
                  Students #= NumberGroups3 * 3 + NumberGroups4 * 4,
                  NumberGroups3 #=< NumberGroups4,
                  labeling([],Values).

                                          
                                           
