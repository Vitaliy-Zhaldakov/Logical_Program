%Ввод строки
read_str(A,N,Flag):-get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),
    r_str(X1,A,B1,N,K1,Flag).

read_str(A,Length):- get0(X), r_str(X,A,[],Length,0).
r_str(-1,A,A,Length,Length):-!.
r_str(10,A,A,Length,Length):-!.
r_str(X,A,B,Length,N):- N1 is N + 1, append(B,[X],B1), get0(X1),
	r_str(X1,A,B1,Length,N1).

%Вывод строки
write_str([]):-!.
write_str([H|T]):- put(H), write_str(T).

%Ввод списка строк
read_list_str(List):- read_str(A,_,Flag),read_list_str([A],List,Flag).
read_list_str(List,List,1):-!.
read_list_str(Cur_list,List,0):-
	read_str(A,_,Flag),append(Cur_list,[A],C_l),read_list_str(C_l,List,Flag).

%Ввод списка строк и формирование списка длин строк
read_list_str(List, LengthList):- read_str(A,N,Flag),
    read_list_str([A],List,[N],LengthList,Flag).
read_list_str(List,List,LengthList, LengthList,1):-!.
read_list_str(Cur_list,List,CurLengthList,LengthList,0):- read_str(A,N,Flag),
    append(Cur_list,[A],C_l), append(CurLengthList, [N], NewLengthList),
        read_list_str(C_l,List,NewLengthList,LengthList,Flag).

%Вывод списка строк
write_list_str([]):-!.
write_list_str([H|T]):- write_str(H),nl,write_list_str(T).

%Чтение из файла и запись в файл
files:-	see('x:/Stroki_read.txt'),read_list_str(List),seen,
            tell('x:/Stroki_write.txt'), write_list_str(List),told.

%Task 1.1 Дан файл. Прочитать из файла строки и вывести длину наибольшей
%строки.
maxLength:- see('x:/Stroki_read.txt'), read_list_str(_, LengthList), seen,
    max(LengthList, Max), write(Max).

max(List, MaxEl):- max(List, 0, MaxEl).
max([],CurMax, CurMax):- !.
max([H|T], CurMax, X):- H > CurMax, NewMax is H, max(T,NewMax,X), !.
max([_|T], CurMax, X):- max(T, CurMax, X).

%Task 1.2 Дан файл. Определить, сколько в файле строк, не содержащих
%пробелы.
without_space :- see('x:/Stroki_read.txt'), read_list_str(List),seen,
    w_space(List,0,N), write(N).

w_space([],N,N):-!.
w_space([H|T],N,R):- w_space(H,F), (F = 0 -> w_space(T,N,R) ; (N1 is N + 1,
            w_space(T,N1,R))).
w_space([],1):-!.
w_space([H|T],N):- (H = 32 -> (N is 0, !) ; w_space(T,N)).

%Task 1.3 Дан файл, найти и вывести на экран только те строки, в которых букв
%А больше, чем в среднем на строку.
a_letter :- see('x:/Stroki_read.txt'), read_list_str(List), seen,
    count_string(List,0,C), count_a(List,0,A), Average is A / C,
    more_a(List,Average).

%Подсчёт числа строк в файле
count_string([],C,C):-!.
count_string([_|T],C,R):- C1 is C + 1, count_string(T,C1,R).

%Подсчёт букв А в файле
count_a([],A,A):-!.
count_a([H|T],A,C):- count_Astr(H,0,Astr), A1 is A + Astr, count_a(T,A1,C).

%Подсчёт букв А в строке
count_Astr([],Astr,Astr):-!.
count_Astr([H|T],A,Astr):- (H = 65 -> (A1 is A + 1, count_Astr(T,A1,Astr)) ;
                           count_Astr(T,A,Astr)).

more_a([],_):-!.
more_a([H|T],Av):- count_Astr(H,0,A), (A > Av -> (write_str(H), nl, more_a(T,Av));       more_a(T,Av)).

%Task 1.4 Дан файл, вывести самое частое слово.
frequent :- see('x:/Stroki_read.txt'),read_list_str(List), seen,
   all_words(List,[],List_words), unique_elems(List_words,Unique_words),
     counts(Unique_words,C,List_words),	indOfMax(C,Ind),
       el_by_number(Unique_words,Ind,Word),name(Word1,Word), write(Word1).

%Формирование список всех слов файла
all_words([],List_words,List_words):-!.
all_words([H|T],I,List_words):- get_words(H,Words),
	append(I,Words,I1), all_words(T,I1,List_words).

%Получение списка слов в строке
get_words(A,Words):- get_words(A,[],Words).
get_words([],List_words,List_words):-!.
get_words(Str,Words,List_words):- skip_space(Str,New_Str),
    get_word(New_Str,Word,New_Str_after_word), Word \=[],
      append(Words,[Word],New_list_word),
        get_words(New_Str_after_word,New_list_word,List_words),!.
get_words(_,List_words,List_words).

counts([],[],_):-!.
counts([Word|T_words],[Count|T_counts],Words):-
	count(Word,Words,Count),counts(T_words,T_counts,Words).

%Сколько раз элемент встречался в списке count(+Elem, +List, -K)
count(_,[],0):-!.
count(Elem,List,X):- count(Elem,List,0,X).
count(_,[],Count,Count):- !.
count(Elem,[Elem|T],Count,X):- Count1 is Count + 1, count(Elem,T,Count1,X), !.
count(Elem,[_|T],Count,X):- count(Elem,T,Count,X).

%Вывод элемента на данной позиции el_by_number(+List, +Number, -Elem)
el_by_number(A,Ind,El):-el_by_number(A,0,Ind,El).
el_by_number([],_,_,nil):-!.
el_by_number([El|_],Ind,Ind,El):-!.
el_by_number([_|T],I,Ind,El):-I1 is I+1,el_by_number(T,I1,Ind,El).

%Cписок без повторов unique_elems(+List, -Result)
unique_elems([], []):- !.
unique_elems([H|T], List2):- unique_elems([H|T], List2, []).
unique_elems([], CurList, CurList):- !.
unique_elems([H|T], List, []):- unique_elems(T, List, [H]), !.
unique_elems([H|T], List, CurList):-
	not(contains(CurList, H)), append(CurList, [H], NewList),
	unique_elems(T, List, NewList), !.
unique_elems([_|T], List, CurList):- unique_elems(T, List, CurList).

%Проверка, есть ли в списке данный элемент
contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

%Номер максимального элемента списка
indOfMax(X,Y):-indexOfMin(X,Y).
indexOfMin([], -1):- !.
indexOfMin([H|T], X):-indexOfMin(T, 0, 1, X, H).
indexOfMin([], _, MinInd, MinInd, _):-!.
indexOfMin([H|T], CurInd, _, X, CurMin):-
	H > CurMin, NewCurInd is CurInd + 1,
	  indexOfMin(T, NewCurInd, NewCurInd, X, H), !.
indexOfMin([_|T], CurInd, MinInd, X, CurMin):-
	NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, MinInd, X, CurMin).

%Пропуск пробела
skip_space([32|Tail],New_Str):- skip_space(Tail,New_Str),!.
skip_space(New_Str,New_Str).

%Вывод первого слова и остальной строки get_word(+List, -Word, -List1)
get_word([],[],[]):-!.
get_word(Str,Word,New_Str_after_word):-get_word(Str,[],Word,New_Str_after_word).

get_word([],Word,Word,[]).
get_word([32|T],Word,Word,T):-!.
get_word([H|T],W,Word,New_Str_after_word):- append(W,[H],W1),
	get_word(T,W1,Word,New_Str_after_word).

%Task 1.5 Дан файл, вывести в отдельный файл строки, состоящие из слов, не
%повторяющихся в исходном файле.
unique_strings :- see('x:/Stroki_read.txt'),read_list_str(List), seen,
     all_words(List,[],All_words), unique_w(All_words,Unique_words),
	tell('x:/Stroki_write.txt'), unique_str(List,Unique_words),told.

%Вывод строки с неповторяющимися словами
unique_str([],_):-!.
unique_str([H|T],Unique_words):- get_words(H,Words_H),
	 (   check_str(Words_H,Unique_words) -> (write_str(H), nl,
	     unique_str(T,Unique_words)) ; unique_str(T,Unique_words)).

%Проверка, все ли слова строки являются уникальными
check_str([],_):-!.
check_str([H|T],Unique_words):- in_list(Unique_words,H),check_str(T,Unique_words).

in_list([El|_],El):-!.
in_list([_|T],El):- in_list(T,El).

%Удаление элемента из списка
del_elem(_,[],[]):-!.
del_elem(H,[H|T],R) :- del_elem(H,T,R),!.
del_elem(H,[H1|T],[H1|R]) :- H \= H1, del_elem(H,T,R).

%Формирование списка неповторяющихся элементов
unique_w([],[]):-!.
unique_w([H|T],[H|R]) :- not(in_list(T,H)), unique_w(T,R),!.
unique_w([H|T],R) :- del_elem(H,T,H1), unique_w(H1,R).

%Task 2.5  Дана строка. Необходимо перемешать все символы строки в случайном
%порядке.
mix_symbols:- see('x:/Stroki_read.txt'), read_str(Str,Length), seen,
	mix(Str,Length,[],Mix_str),write_str(Mix_str).

mix([],0,Rstr,Rstr):-!.
mix(Str,Length,Rstr,Mix_str):- random(0,Length,Ran),el_by_number(Str,Ran,Elem),
	append(Rstr,[Elem],R), delete_from_str(Str,Elem,New_str,0),
	 Length1 is Length - 1, mix(New_str,Length1,R,Mix_str).

delete_from_str([],_,[],_):-!.
delete_from_str([H|T],H,Rstr,0):- delete_from_str(T,H,Rstr,1),!.
delete_from_str([H1|T],H,[H1|Rstr],0):- H \= H1, delete_from_str(T,H,Rstr,0),!.
delete_from_str([H1|T],H,[H1|Rstr],1):- delete_from_str(T,H,Rstr,1),!.

%Task 2.7  Дана строка, состоящая из символов латиницы. Необходимо проверить,
%образуют ли прописные символы этой строки палиндром (зеркальное слово)
palindrom:- see('x:/Stroki_read.txt'), read_str(Str,_), seen,
	big_letters(Str,List), reverse_list(Str,Rstr), p(List,Rstr).

%Формирование списка прописных символов
big_letters([],[]):-!.
big_letters([H|T],[H|List]):- H > 64, H < 91, big_letters(T,List),!.
big_letters([_|T],List):- big_letters(T,List),!.

%Проверка, содержит ли список данный подсписок; p(+Sublist,+List)
p([],_):-!.
p([SubH|SubT],[H|T]):- H = SubH -> p(SubT,T) ; p([SubH|SubT],T).

%Переворот списка; reverse_list(+List, -Revl)
reverse_list(List,Revl):- reverse_list(List,[],Revl).
reverse_list([],Revl,Revl):-!.
reverse_list([H|T],T1,Revl):- reverse_list(T,[H|T1],Revl).

%Task 2.14 Дана строка в которой записаны слова через пробел. Необходимо
%упорядочить слова по количеству букв в каждом слове.
sort_words:- see('x:/Stroki_read.txt'), read_list_str_mod(Words,Lengths), seen,
	sorting(Words,Lengths,[],Sort_list), write_list_str_mod(Sort_list).

% Находим номер меньшей длины, находим меньшую длину, удаляем из списка
% длин, по номеру меньшей длины находим слово, кидаем в результирующий
% список, добавляем пробел
sorting([],[],Sort_list,Sort_list):-!.
sorting(Words,Lengths,List,R):- numOfMin(Lengths,Num),
	el_by_number(Lengths,Num,El), del_elem(El,Lengths,Rlength),
	 el_by_number(Words,Num,Word), append(List,[Word],Rlist),
	  del_elem(Word,Words,Rwords), sorting(Rwords,Rlength,Rlist,R).

%Ввод слова
read_str_mod(A,N,Flag):- get0(X),r_str_mod(X,A,[],N,0,Flag).
r_str_mod(-1,A,A,N,N,1):-!.
r_str_mod(32,A,A,N,N,0):-!.
r_str_mod(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),
    r_str_mod(X1,A,B1,N,K1,Flag).

%Ввод списка слов и списка длин слов
read_list_str_mod(List, LengthList):- read_str_mod(A,N,Flag),
    read_list_str_mod([A],List,[N],LengthList,Flag).
read_list_str_mod(List,List,LengthList, LengthList,1):-!.
read_list_str_mod(Cur_list,List,CurLengthList,LengthList,0):-
     read_str_mod(A,N,Flag), append(Cur_list,[A],C_l),
       append(CurLengthList, [N], NewLengthList),
        read_list_str_mod(C_l,List,NewLengthList,LengthList,Flag).

%Номер минимального элемента списка
numOfMin([], -1):- !.
numOfMin([H|T], X):-numOfMin(T, 0, 0, X, H).
numOfMin([], _, MinInd, MinInd, _):-!.
numOfMin([H|T], CurInd, _, X, CurMin):-
	H < CurMin, NewCurInd is CurInd + 1,
	  numOfMin(T, NewCurInd, NewCurInd, X, H), !.
numOfMin([_|T], CurInd, MinInd, X, CurMin):-
	NewCurInd is CurInd + 1, numOfMin(T, NewCurInd, MinInd, X, CurMin).

%Вывод слов
write_list_str_mod([]):-!.
write_list_str_mod([H|T]):- write_str_mod(H),put(32),write_list_str_mod(T).

%Вывод слова
write_str_mod([]):-!.
write_str_mod([H|T]):- put(H), write_str_mod(T).
