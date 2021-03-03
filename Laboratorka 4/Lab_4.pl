read_list(0,[]):-!.
read_list(N,[H|T]):- read(H),N1 is N - 1, read_list(N1,T).
write_list([]):-!.
write_list([H|T]):- write(H), write(", "), write_list(T).

sum_list_down(List,Sum):- sum_list_down(List,0,Sum).
sum_list_down([],Sum,Sum):-!.
sum_list_down([H|T],S,Sum):- S1 is S + H, sum_list_down(T,S1,Sum).
proga_summ :- write("Введите число элементов: "), read(N), read_list(N,List),
    sum_list_down(List,Sum), write("Сумма элементов: "), write(Sum).

sum_list_up([],0):-!.
sum_list_up([H|T],Sum):- sum_list_up(T,S1), Sum is H + S1.

list_el_numb(List,Elem,Number):- list_el_numb(List,Elem,0,Number).
list_el_numb([H|_],H,Number,Number):-!.
list_el_numb([_|T],Elem,I,Number):- I1 is I + 1, list_el_numb(T,Elem,I1,Number).
proga_elem :- write("Введите число элементов: "), read(N), read_list(N,List),
    write("Введите элемент: "), read(Elem), nl, list_el_numb(List,Elem,Number),
    write("Позиция элемента: "), write(Number),!.
proga_elem :- write("Такого элемента нет").

proga_num_elem :- write("Введите число элементов: "), read(N), read_list(N,List),
    write("Введите позицию элемента: "), read(Number), nl,
    list_el_numb(List,Elem,Number), write("Элемент: "), write(Elem),!.
proga_num_elem :- write("Такого номера нет").

min_list_up([],-1):-!.
min_list_up([H|T],Min):- min_list_up(T,Min1),(Min1 = -1 -> Min = H ; (H < Min1
     -> Min = H ; Min = Min1)).

min_list_down(List,Min):- min_list_down(List,-1,Min).
min_list_down([],Min,Min):-!.
min_list_down([H|T],M,Min):- (M = -1 -> M1 = H ; (H < M -> M1 = H ; M1 = M)),
    min_list_down(T,M1,Min).

proga_min :- write("Введите число элементов: "), read(N), read_list(N,List),
    min_list_up(List,Min), write("Минимальный элемент: "), write(Min).

in_list([El|_],El):-!.
in_list([_|T],El):- in_list(T,El).
