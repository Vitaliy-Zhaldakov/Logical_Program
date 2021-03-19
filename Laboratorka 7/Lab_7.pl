contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

write_str([]):-!.
write_str([H|Tail]):- put(H),write_str(Tail).

read_str(A,N,Flag):- get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):- K1 is K+1,append(B,[X],B1),get0(X1),
r_str(X1,A,B1,N,K1,Flag).

read_str(A,N):- get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):- K1 is K+1 ,append(B,[X],B1),get0(X1), r_str(X1,A,B1,N,K1).

in_list([El|_],El).
in_list([_|T],El):- in_list(T,El).

in_list_exсlude([El|T],El,T).
in_list_exсlude([H|T],El,[H|Tail]):- in_list_exсlude(T,El,Tail).


reverse_list(A,Z) :- reverse_list(A,Z,[]).
reverse_list([],Z,Z).
reverse_list([H|T],Z,Acc):- reverse_list(T,Z,[H|Acc]).

remove_from_list(List, Elem, Result) :-
	remove_from_list(List, Elem, [], Result).

remove_from_list([IH|IT], Elem, TempLeft, Result) :-
	IH = Elem,
	reverse(TempLeft, TempLeftReverse),

	append(TempLeftReverse, IT, Result), !.

remove_from_list([IH|IT], Elem, TempLeft, Result) :-
	not(IH = Elem),
	remove_from_list(IT, Elem, [IH|TempLeft], Result).


%Task 1 Дана строка. Вывести 3 раза через запятую и посчитать символы
three_times :- write("Введите строку:"),nl, read_str(Str,Number), write_str(Str),
write(', '),write_str(Str), write(', '), write_str(Str), nl,
write("Число символов: "), write(Number).
