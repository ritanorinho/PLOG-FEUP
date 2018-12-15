:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).
:-use_module(library(samsort)).

class1([1,1,1,1,2,2,2,2,3,4,3,4,3,4,3,4]).
class2([1,2,1,2,2,2,3,1,1,3,3,4,4,4,3,4]).
class3([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]).


generate_grades(0,FinalList,FinalList).
generate_grades(Index,CurrList,FinalList):-
                  Index > 0,
                  Index1 is Index-1,
                  random(10,20,H),
                  append(CurrList,[H],CurrList1),
                  generate_grades(Index1,CurrList1,FinalList),!.
generate_groups([],0,_,Minimum,Maximum).
generate_groups([H|T],Index,FinalList,Minimum,Maximum):-
                  Index > 0,
                  Index1 is Index-1,
                  random(Minimum,Maximum,H),
                  append(FinalList,[H],FinalList1),
                  generate_groups(T,Index1,FinalList1,Minimum,Maximum).

analyze_groups(Groups,Grades,NumberGroups).


groups(NumberStudents):-class1(X),
                        generate_grades(NumberStudents,CurrGrades,ListGrades),write(ListGrades),nl,
                        length(Groups1,NumberStudents),
                        calculate_number_groups(NumberStudents,Groups4,Groups3), 
                        NumberGroups #= Groups3+Groups4,
                        domain(Groups1,1,NumberGroups),
                        list_global(0,Groups3,3,[],List,[],CurrentGroups),
                        list_global(Groups3,NumberGroups,4,List,FinalList,CurrentGroups,FinalGroups),
                        global_cardinality(Groups1,FinalList),
                        count_repetitions(Groups1,Acc,X),length(AverageGrades,NumberGroups),
                        calculate_average_grades(Groups1,ListGrades,FinalGroups,1,NumberGroups,AverageGrades),
                        labeling([minimize(Acc)],Groups1),write(AverageGrades),nl,write(Acc),nl,write(X),nl,write(Groups1),nl,
                        length(Groups2,NumberStudents),
                        domain(Groups2,1,NumberGroups),
                        global_cardinality(Groups2,FinalList),
                        count_repetitions(Groups2,Acc1,X),
                        count_repetitions(Groups2,0,Groups1),length(AverageGrades1,NumberGroups),
                        calculate_average_grades(Groups2,ListGrades,FinalGroups,1,NumberGroups,AverageGrades1),
                        labeling([minimize(Acc1)],Groups2),write(AverageGrades1),nl,write(Acc1),nl,write(X),nl,write(Groups2). 



list_global(CurrPosition,NumberGroups,NumberElements,FinalList,FinalList,ListGroups,ListGroups):- CurrPosition >= NumberGroups.
list_global(CurrPosition,NumberGroups,NumberElements,CurrList,FinalList,CurrentGroups,FinalGroups):-
                                                           CurrPosition < NumberGroups,                                          
                                                           CurrPosition1 is CurrPosition+1,
                                                           append(CurrList,[CurrPosition1-NumberElements],CurrList1),
                                                           append(CurrentGroups,[NumberElements],CurrentGroups1),
                                                           list_global(CurrPosition1,NumberGroups,NumberElements,CurrList1,FinalList,CurrentGroups1,FinalGroups).



calculate_average_grades(List,Grades,GroupElements,CurrentGroup,NumberGroups,[]).
calculate_average_grades(List,Grades,[G1|G],CurrentGroup,NumberGroups,[H|T]):-    
                                                                            sum_grades(List,Grades,CurrentGroup,Sum),
                                                                            H #= Sum / G1,
                                                                            CurrentGroup1 #= CurrentGroup+1,
                                                                            calculate_average_grades(List,Grades,G,CurrentGroup1,NumberGroups,T).

sum_grades([A],[G1],Group,SumGrades):- (A #= Group) #<=> Bin,
                                       SumGrades #= G1 * Bin.

sum_grades([A,B|T],[G1,G2|G],Group,SumGrades):-       sum_grades([B|T],[G2|G],Group,Sum),
                                                      (A #= Group) #<=> Bin,
                                                      SumGrades #= Sum + G1 * Bin.


count_repetitions([_],0,[_]).

count_repetitions([H|T],Acc,[X1|X]):- count_repetitions(T,Acc2,X), 
                                      repetitions([H|T],[X1|X],Acc1),
                                      Acc #= Acc2+Acc1.

repetitions([A,B],[X1,X2],Acc):- (X1 #= X2 #/\ A #=B)#<=>Bin, Acc #= Bin.
repetitions([A,B,C|T],[X1,X2,X3|X],Acc):-                                             
                                         repetitions([A,C|T],[X1,X3|X],Acc1),
                                         (X1 #= X2 #/\ A #=B)#<=>Bin,
                                         %write('['),write(X1),write(','), write(X2),write(']'),nl,
                                         Acc #= Acc1 + Bin.



calculate_number_groups(Students,NumberGroups4,NumberGroups3):- 
                  Values=[NumberGroups4,NumberGroups3],
                  NumberGroups3 in 0..Students,
                  NumberGroups4 in 0..Students,
                  Students #= NumberGroups3 * 3 + NumberGroups4 * 4,
                  labeling([maximize(NumberGroups4)],Values).

