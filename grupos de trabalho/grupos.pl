:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(list)).
:-use_module(library(samsort)).

class1([1,1,1,1,2,2,1,2,3,4,3,4,3,4,3,4]).
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
                        class2(Y),
                        length(Groups1,NumberStudents),
                        NumberGroups #= NumberStudents / 4, 
                        domain(Groups1,1,NumberGroups),
                        Number #= NumberGroups + 1,
                        list_global(1,Number,[],FinalList),
                        global_cardinality(Groups1,FinalList),
                        duos(Groups1,1,X,Y),
                        labeling([],Groups1),write(Groups1),
                        length(Groups2,NumberStudents),
                        domain(Groups2,1,NumberGroups),
                        global_cardinality(Groups2,FinalList),
                        duos(Groups2,1,Groups1,Y),
                        labeling([],Groups2),write('\n'),write(Groups2).



list_global(NumberGroups,NumberGroups,FinalList,FinalList).
list_global(CurrPosition,NumberGroups,CurrList,FinalList):-
                                                           CurrPosition < NumberGroups,                                          
                                                           CurrPosition1 is CurrPosition+1,
                                                           X in 3..4,
                                                           append(CurrList,[CurrPosition-X],CurrList1),
                                                           list_global(CurrPosition1,NumberGroups,CurrList1,FinalList).

calculate_number_groups(Students,Number4,Number3):- NumberGroups is Students mod 4,
                                                    N3 is NumberGroups mod 3,
                                                    N3 == 0,
                                                    Number3 is floor(NumberGroups / 3),
                                                    Number4 is floor(Students / 4).

duos([_,_],Index,_,_).
duos([A,B|T],Index,X,Y):- 
                      element(Index,X,Val1),
                      element(Index,Y,ValY1),
                      Index1 #= Index + 1,
                      element(Index1,X,Val2),
                      element(Index1,Y,ValY2),
                      Index2 #= Index1 + 1,
                      (A #\= B #\/ ((A #\= Val1 #/\ A #\=ValY1) #/\(B #\= Val2 #/\ B #\= ValY2))),
                      duos(T,Index2,X,Y).