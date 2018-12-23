:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).

class([1,1,1,2,2,2,3,3,3],9).
class([1,1,2,2,4,4,5,5,1,2,3,4],12).
class([1,1,1,3,2,2,4,2,3,4,3,4,3,4],14).
class([1,3,4,3,4,1,2,2,1,1,2,2,3,3,4],15).
class([1,1,1,1,2,2,2,2,3,4,3,4,3,4,3,4],16).
class([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18],18).

class([1,2,1,2,2,2,3,1,1,3,3,4,4,4,3,4,5,5,5,5],20).

class([1,2,1,2,2,2,3,1,1,3,3,4,4,4,3,4,5,5,6,5,5,6,6,6],24).


grades([15,11,13,13,14,13,14,15,16],9). % 9 alunos
grades([12,16,17,13,12,13,18,16,12,18,12,19],12).%12 alunos
grades([14,11,10,12,17,13,12,18,12,15,18,19,18,11],14). % 14 alunos
grades([13,12,18,18,11,14,11,10,12,15,12,19,18,19,17],15). %15 alunos
grades([12,11,10,12,17,11,12,18,12,15,18,10,18,11,17,12],16). % 16 alunos
grades([15,17,17,19,15,10,12,17,11,15,11,19,15,16,18,13,14,10],18). %18 alunos
grades([13,11,13,19,15,12,15,13,14,11,18,14,11,17,14,18,11,18,19,20],20). %20 alunos
grades([10,13,16,15,10,12,18,13,19,14,14,10,17,14,12,19,11,19,19,12,13,13,14,15],24). %24alunos

generate_grades(0,FinalList,FinalList):- write(FinalList).
generate_grades(Index,CurrList,FinalList):-
                  Index > 0,
                  Index1 is Index-1,
                  random(10,20,H),
                  append(CurrList,[H],CurrList1),
                  generate_grades(Index1,CurrList1,FinalList),!.

output(ListGrades,X,Groups1,AverageGrades,Groups2,AverageGrades1,Time):-
                                        write('Grades > ') , write(ListGrades),nl,
                                        write('Other class groups > ') , write(X),nl,
                                        write('First work groups > '),write(Groups1),nl,
                                        write('First work groups average grades > '), write(AverageGrades),nl,
                                        write('Second work groups > ' ), write(Groups2),nl,
                                        write('Second work groups average grades > '), write(AverageGrades1),nl,
                                        format(' > Duration: ~3d s~n', [Time]),nl.
                                       

groups(NumberStudents,NumberThemes):- write('Processing...'),nl, 
                        class(X,NumberStudents),
                        grades(ListGrades,NumberStudents),
                        statistics(walltime, [Start,_]),
                        length(Groups1,NumberStudents),
                        calculate_number_groups(NumberStudents,Groups4,Groups3,NumberThemes), 
                        NumberGroups #= Groups3+Groups4,
                        domain(Groups1,1,NumberGroups),
                        list_global(0,Groups3,3,[],List,[],CurrentGroups),
                        list_global(Groups3,NumberGroups,4,List,FinalList,CurrentGroups,FinalGroups),
                        global_cardinality(Groups1,FinalList),
                        count_repetitions(Groups1,Acc,X),length(AverageGrades,NumberGroups),
                        calculate_average_grades(Groups1,ListGrades,FinalGroups,1,NumberGroups,AverageGrades),
                        general_distance_between_grades(AverageGrades,[],DiffGrades),
                        maximum(Max,DiffGrades),
                        Metric #= 3*Max / 4 + Acc /4,
                        length(Groups2,NumberStudents),
                        domain(Groups2,1,NumberGroups),
                        global_cardinality(Groups2,FinalList),
                        count_repetitions(Groups2,0,Groups1),length(AverageGrades1,NumberGroups),
                        count_repetitions(Groups2,Acc1,X),
                        calculate_average_grades(Groups2,ListGrades,FinalGroups,1,NumberGroups,AverageGrades1),
                        general_distance_between_grades(AverageGrades1,[],DiffGrades1),
                        maximum(Max1,DiffGrades1),
                        Metric1 #= 3* Max1 / 4 + Acc1 / 4,
                        TotalMetrics #= Metric1+Metric,
                        append(Groups1,Groups2,TotalGroups),
                        labeling([minimize(TotalMetrics),time_out(70000,_)],TotalGroups),write('Repetions > '), write(Acc1),nl,write('Repetions > '), write(Acc),nl,
                        statistics(walltime, [End,_]),
	                      Time is End - Start,
                        fd_statistics,
                        output(ListGrades,X,Groups1,AverageGrades,Groups2,AverageGrades1,Time).

distance_between_grades([A,B],CurrList,FinalList):- Diff #= abs(B-A),
                                                   append(CurrList,[Diff],CurrList1),
                                                   FinalList = CurrList1.
distance_between_grades([A,B,C|T],CurrList,FinalList):- 
                                                          Diff #= abs(B-A),
                                                          append(CurrList,[Diff],CurrList1),
                                                          distance_between_grades([A,C|T],CurrList1,FinalList).

general_distance_between_grades([_],FinalList,FinalList).

general_distance_between_grades([H|T],CurrList,FinalList):- distance_between_grades([H|T],[],FinalList1),
                                                            append(CurrList,FinalList1,CurrList1),
                                                            general_distance_between_grades(T,CurrList1,FinalList).


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
                                         Acc #= Acc1 + Bin.



calculate_number_groups(Students,NumberGroups4,NumberGroups3,NumberThemes):- 
                  Values=[NumberGroups4,NumberGroups3],
                  NumberGroups3 in 0..Students,
                  NumberGroups4 in 0..Students,
                  Students #= NumberGroups3 * 3 + NumberGroups4 * 4,
                  NumberThemes #= NumberGroups3+NumberGroups4,
                  labeling([],Values).