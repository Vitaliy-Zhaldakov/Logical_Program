read_list(0,[]):-!.
read_list(N,[H|T]):- read(H),N1 is N - 1, read_list(N1,T).
write_list([]):-!.
write_list([H|T]):- write(H), write(", "), write_list(T).

sum_list_down(List,Sum):- sum_list_down(List,0,Sum).
sum_list_down([],Sum,Sum):-!.
sum_list_down([H|T],S,Sum):- S1 is S + H, sum_list_down(T,S1,Sum).
proga_summ :- write("Введите число элементов: "), read(N), read_list(N,List),
    sum_list_down(List,Sum), write("Сумма элементов: "), write(Sum).
