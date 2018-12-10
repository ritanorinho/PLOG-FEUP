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
                        calculate_number_groups(NumberStudents,Groups4,Groups3), 
                        NumberGroups #= Groups3+Groups4,
                        domain(Groups1,1,NumberGroups),
                        list_global(0,Groups3,3,[],List),
                        list_global(Groups3,NumberGroups,4,List,FinalList),
                        global_cardinality(Groups1,FinalList),
                        duos(Groups1,1,X,Y),
                        labeling([],Groups1),write(Groups1),
                        length(Groups2,NumberStudents),
                        domain(Groups2,1,NumberGroups),
                        global_cardinality(Groups2,FinalList),
                        duos(Groups2,1,Groups1,Y),
                        labeling([],Groups2),write('\n'),write(Groups2). 



list_global(CurrPosition,NumberGroups,NumberElements,FinalList,FinalList):- CurrPosition >= NumberGroups.
list_global(CurrPosition,NumberGroups,NumberElements,CurrList,FinalList):-
                                                           CurrPosition < NumberGroups,                                          
                                                           CurrPosition1 is CurrPosition+1,
                                                           append(CurrList,[CurrPosition1-NumberElements],CurrList1),
                                                           list_global(CurrPosition1,NumberGroups,NumberElements,CurrList1,FinalList).


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



calculate_number_groups(Students,NumberGroups4,NumberGroups3):- 
                  Values=[NumberGroups4,NumberGroups3],
                  NumberGroups3 in 0..Students,
                  NumberGroups4 in 0..Students,
                  Students #= NumberGroups3 * 3 + NumberGroups4 * 4,
                  NumberGroups3 #=< NumberGroups4,
                  labeling([],Values).

                                          
                                           
