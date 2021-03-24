%Проверка, содержится ли элемент в списке
contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

%Вывод строки (put(X) - перевод кода в символ)
write_str([]):-!.
write_str([H|Tail]):- put(H),write_str(Tail).

%Чтение строки (get0(X) - перевод символа в код)
read_str(A,N,Flag):- get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):- K1 is K+1,append(B,[X],B1),get0(X1),
r_str(X1,A,B1,N,K1,Flag).

read_str(A,N):- get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):- K1 is K+1 ,append(B,[X],B1),get0(X1), r_str(X1,A,B1,N,K1).

%Удаление элемента из списка in_list_exclude(+List, +El, -List1)
in_list_exсlude([El|T],El,T).
in_list_exсlude([H|T],El,[H|Tail]):- in_list_exсlude(T,El,Tail).

%Переворот списка reverse_list(+List, -Reverse)
reverse_list(A,Z) :- reverse_list(A,Z,[]).
reverse_list([],Z,Z).
reverse_list([H|T],Z,Acc):- reverse_list(T,Z,[H|Acc]).


%Task 1 Дана строка. Вывести 3 раза через запятую и посчитать символы
three_times :- write("Insert string: "),nl, read_str(Str,Number), write_str(Str),
write(', '),write_str(Str), write(', '), write_str(Str), nl,
write("Number of symbols: "), write(Number).

%Task 2 Дана строка. Найти количество слов
count_words :- write("Insert string: "), nl, number_words(Words),
	write("Number of words: "), write(Words).
number_words(Words):- get0(X), n_words(X,Words,1).
n_words(10,Words,Words):-!.
n_words(32,Words,N):- N1 is N + 1, get0(X1), n_words(X1,Words,N1),!.
n_words(_,Words,N):- get0(X1), n_words(X1,Words,N).


%Task 3 Дана строка. Определить самое частое слово
frequent_word :- read_str(A,_), get_words(A,Words,_), unique_elems(Words,U_words),
counts(U_words,C,Words), indOfMax(C,Ind), el_by_number(U_words,Ind,El),
	write_str(El).

%Вывод первого слова и остальной строки get_word(+List, -Word, -List1)
get_word([],[],[]):-!.
get_word(A,Word,A2):- get_word(A,[],Word,A2).

get_word([],Word,Word,[]).
get_word([32|T],Word,Word,T):-!.
get_word([H|T],W,Word,A2):- append(W,[H],W1), get_word(T,W1,Word,A2).

%Вывод всех слов и их количества get_words(+List, -Words, -K)
get_words(A,Words,K):- get_words(A,[],Words,0,K).

get_words([],B,B,K,K):-!.
get_words(A,Temp_words,B,I,K):- skip_space(A,A1),get_word(A1,Word,A2),Word \=[],
	I1 is I+1,append(Temp_words,[Word],T_w),get_words(A2,T_w,B,I1,K),!.
get_words(_,B,B,K,K).

%Пропуск пробела
skip_space([32|Tail],New_Str):- skip_space(Tail,New_Str),!.
skip_space(New_Str,New_Str).

%Cписок без повторов unique_elems(+List, -Result)
unique_elems([], []):- !.
unique_elems([H|T], List2):- unique_elems([H|T], List2, []).
unique_elems([], CurList, CurList):- !.
unique_elems([H|T], List, []):- unique_elems(T, List, [H]), !.
unique_elems([H|T], List, CurList):- not(contains(CurList, H)),
       append(CurList, [H], NewList), unique_elems(T, List, NewList), !.
unique_elems([_|T], List, CurList):- unique_elems(T, List, CurList).

counts([],[],_):-!.
counts([Word|T_words],[Count|T_counts],Words):-
	count(Word,Words,Count), counts(T_words,T_counts,Words).

%Сколько раз элемент встречался в списке count(+Elem, +List, -K)
count(_, [], 0):-!.
count(Elem, List, X):- count(Elem, List, 0, X).
count(_, [], Count, Count):- !.
count(Elem, [Elem|T], Count, X):- Count1 is Count + 1,
	count(Elem, T, Count1, X), !.
count(Elem, [_|T], Count, X):- count(Elem, T, Count, X).

%Номер минимального элемента списка
indOfMax(X,Y):-indexOfMin(X,Y).
indexOfMin([], -1):- !.
indexOfMin([H|T], X):-indexOfMin(T, 1, 1, X, H).
indexOfMin([], _, MinInd, MinInd, _):-!.
indexOfMin([H|T], CurInd, _, X, CurMin):-
 H > CurMin, NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, NewCurInd, X, H),!.
indexOfMin([_|T], CurInd, MinInd, X, CurMin):-
	NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, MinInd, X, CurMin).

%Вывод элемента на данной позиции el_by_number(+List, +Number, -Elem)
el_by_number(A,Ind,El):- el_by_number(A,1,Ind,El).
el_by_number([],_,_,nil):-!.
el_by_number([El|_],Ind,Ind,El):-!.
el_by_number([_|T],I,Ind,El):-I1 is I+1, el_by_number(T,I1,Ind,El).

%Task 4. Дана строка. Вывести первые три символа и последние три
%символа, если длина строки больше 5. Иначе вывести первый символ
%столько раз, какова длина строки.
saint_three :- read_str(Str,N), (N > 5 -> three(Str) ; first(Str,N)).

three(Str):- three(Str,0).
three(_,7):-!.
three(Str,3):- reverse_list(Str,Str1), three(Str1,4),!.
three([H|T],I):- put(H), I1 is I + 1, three(T,I1).

first([H|_], N) :- first(H,N,0).
first(_,N,N):- !.
first(H,N,I):- put(H), I1 is I + 1, first(H,N,I1).
