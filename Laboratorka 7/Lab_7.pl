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

in_list_ex�lude([El|T],El,T).
in_list_ex�lude([H|T],El,[H|Tail]):- in_list_ex�lude(T,El,Tail).


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


%Task 1 ���� ������. ������� 3 ���� ����� ������� � ��������� �������
three_times :- write("������� ������:"),nl, read_str(Str,Number), write_str(Str),
write(', '),write_str(Str), write(', '), write_str(Str), nl,
write("����� ��������: "), write(Number).

%Task 2 ���� ������. ����� ���������� ����
number_words(Words):- get0(X), n_words(X,Words,1).
n_words(10,Words,Words):-!.
n_words(32,Words,N):- N1 is N + 1, get0(X1), n_words(X1,Words,N1),!.
n_words(_,Words,N):- get0(X1), n_words(X1,Words,N).
