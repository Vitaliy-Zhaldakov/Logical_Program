%Task 1 Чтение списка с клавиатуры
read_list(0,[]):-!.
read_list(N,[H|T]):- read(H),N1 is N - 1, read_list(N1,T).

%Вывод списка на экран
write_list([]):-!.
write_list([H|T]):- write(H), write(", "), write_list(T).

%Task 2 Проверка, является ли Sum суммой элементов списка или записывает в переменную сумму
% sum_list_down(+List, ?Sum), рекурсия вниз
sum_list_down(List,Sum):- sum_list_down(List,0,Sum).
sum_list_down([],Sum,Sum):-!.
sum_list_down([H|T],S,Sum):- S1 is S + H, sum_list_down(T,S1,Sum).

% Программа читает список, считает сумму элементов и выводит её на экран
proga_summ :- write("Введите число элементов: "), read(N),
    write("Вводите элементы списка: "), nl, read_list(N,List),
    sum_list_down(List,Sum), write("Сумма элементов: "), write(Sum).

%Task 3 Проверка, является ли Sum суммой элементов списка или записывает в переменную сумму
% sum_list_up(+List, ?Sum), рекурсия вверх
sum_list_up([],0):-!.
sum_list_up([H|T],Sum):- sum_list_up(T,S1), Sum is H + S1.

% Task 4 Если задано значение Elem, то предикат записывает в Number номер
% первого вхождения Elem. Если задано значение Number, то предикат
% записывает в Elem значение, находящееся в списке под номером Number.
% Если заданы оба значения, то предикат проверяет, находится ли элемент
% Elem в списке под номером Number. list_el_numb(+List, ?Elem, ?Number)
list_el_numb(List,Elem,Number):- list_el_numb(List,Elem,0,Number).
list_el_numb([H|_],H,Number,Number):-!.
list_el_numb([_|T],Elem,I,Number):- I1 is I + 1, list_el_numb(T,Elem,I1,Number).

%Программа читает список, читает элемент и находит номер первого вхождения элемента в список.
proga_elem :- write("Введите число элементов: "), read(N), read_list(N,List),
    write("Введите элемент: "), read(Elem), nl, list_el_numb(List,Elem,Number),
    write("Позиция элемента: "), write(Number),!.
proga_elem :- write("Такого элемента нет").

% Task 5 Программа читает список, читает номер элемента и находит
% соответствующий элемент.
proga_num_elem :- write("Введите число элементов: "), read(N), read_list(N,List),
    write("Введите позицию элемента: "), read(Number), nl,
    list_el_numb(List,Elem,Number), write("Элемент: "), write(Elem),!.
proga_num_elem :- write("Такого номера нет").

%Task 6 Поиск минимального элемента в списке рекурсией вверх;
%min_list_up(+List, ?Min)
min_list_up([],0):-!.
min_list_up([H|T],Min):- min_list_up(T,Min1),(Min1 = 0 -> Min = H ; (H < Min1
     -> Min = H ; Min = Min1)).

%Task 7 Поиск минимального элемента в списке рекурсией вниз;
%min_list_down(+List, ?Min)
min_list_down(List,Min):- min_list_down(List,0,Min).
min_list_down([],Min,Min):-!.
min_list_down([H|T],M,Min):- (M = 0 -> M1 = H ; (H < M -> M1 = H ; M1 = M)),
    min_list_down(T,M1,Min).

%Task 8 Программа читает список, находит и выводит на экран его минимальный
%элемент
proga_min :- write("Введите число элементов: "), read(N), read_list(N,List),
    min_list_up(List,Min), write("Минимальный элемент: "), write(Min).

%Task 9 Проверка, есть ли элемент в списке; in_list(+List, ?El)
in_list([El|_],El):-!.
in_list([_|T],El):- in_list(T,El).

%Task 10 Переворот списка; reverse_list(+List, -Revl)
reverse_list(List,Revl):- reverse_list(List,[],Revl).
reverse_list([],Revl,Revl):-!.
reverse_list([H|T],T1,Revl):- reverse_list(T,[H|T1],Revl).

%Task 11 Проверка, содержит ли список данный подсписок; p(+Sublist,+List)
p([],_):-!.
p([SubH|SubT],[H|T]):- H = SubH -> p(SubT,T) ; p([SubH|SubT],T).

%Task 12 Удаление элемента с заданным номером;
%delete_elem(+List, +Number, -Result)
delete_elem(List,Number,Result):- delete_elem(List,Number,0,Result).
delete_elem([_|T],Number,Number, T):-!.
delete_elem([H|T],Number, I,[H|T1]):- I1 is I + 1, delete_elem(T,Number,I1,T1).

%Task 13 Удаление всех элементов, равных данному;
%delete_all(+List, +Elem, -Result)
delete_all([], _, []):-!.
delete_all([Elem|T], Elem, List):- delete_all(T, Elem, List),!.
delete_all([H|T], Elem,[H|List]):- delete_all(T, Elem, List).

%Task 14 Проверка, встречаются ли все элементы в списке 1 раз; check_elem(+List)
check_elem([H|T]):- check_elem(H,T), check_elem(T).
check_elem([]):-!.
check_elem(_,[]):-!.
check_elem(Elem,[H|T]):- Elem \= H, check_elem(Elem,T).

%Task 15 Построение нового списка без повторяющихся элементов;
%unique_elem(+List, -Out)
unique_elem([],[]):-!.
unique_elem([H|T],[H|List]):- delete_all(T,H,List1), unique_elem(List1,List).

%Task 16 Количество раз, которое элемент встречается в списке;
%count_elem(+List, +Elem, -Count)
count_elem([], _, 0):-!.
count_elem([H|T], H, Count) :- count_elem(T, H, Count1), Count is Count1 + 1,!.
count_elem([_|T], Elem, Count) :-count_elem(T, Elem, Count1), Count is Count1 + 0.

%Task 17 Вычисление длины списка; length_list(+List, ?Length)
length_list([],0):-!.
length_list([_|T],Length):- length_list(T,Length1),Length is Length1 + 1.
