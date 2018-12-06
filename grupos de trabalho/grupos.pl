:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(list)).
:-use_module(library(samsort)).

class1([2,1,2,3,1,2,3,3,1]).
class2([[2,3,4],[1,3,4],[1,2,5],[1,2,5],[3,4,6],[5]]).


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



groups:-  length(Groups,16),
          domain(Groups,1,4),
          global_cardinality(Groups,[1-4,2-4,3-4,4-4]),
          labeling([],Groups),write(Groups).






