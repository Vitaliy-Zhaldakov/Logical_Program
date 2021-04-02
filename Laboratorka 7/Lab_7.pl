%Ïðîâåðêà, ñîäåðæèòñÿ ëè ýëåìåíò â ñïèñêå
contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).

%Âûâîä ñòðîêè (put(X) - ïåðåâîä êîäà â ñèìâîë)
write_str([]):-!.
write_str([H|Tail]):- put(H),write_str(Tail).

%×òåíèå ñòðîêè (get0(X) - ïåðåâîä ñèìâîëà â êîä)
read_str(A,N,Flag):- get0(X),r_str(X,A,[],N,0,Flag).
r_str(-1,A,A,N,N,1):-!.
r_str(10,A,A,N,N,0):-!.
r_str(X,A,B,N,K,Flag):- K1 is K+1,append(B,[X],B1),get0(X1),
r_str(X1,A,B1,N,K1,Flag).

read_str(A,N):- get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):- K1 is K+1 ,append(B,[X],B1),get0(X1), r_str(X1,A,B1,N,K1).

%Óäàëåíèå ýëåìåíòà èç ñïèñêà in_list_exclude(+List, +El, -List1)
in_list_exlude([El|T],El,T).
in_list_exlude([H|T],El,[H|Tail]):- in_list_exlude(T,El,Tail).

%Ïåðåâîðîò ñïèñêà reverse_list(+List, -Reverse)
reverse_list(A,Z) :- reverse_list(A,Z,[]).
reverse_list([],Z,Z).
reverse_list([H|T],Z,Acc):- reverse_list(T,Z,[H|Acc]).


%Task 1 Äàíà ñòðîêà. Âûâåñòè 3 ðàçà ÷åðåç çàïÿòóþ è ïîñ÷èòàòü ñèìâîëû
three_times :- write("Insert string: "),nl, read_str(Str,Number), write_str(Str),
write(', '),write_str(Str), write(', '), write_str(Str), nl,
write("Number of symbols: "), write(Number).

%Task 2 Äàíà ñòðîêà. Íàéòè êîëè÷åñòâî ñëîâ
count_words :- write("Insert string: "), nl, number_words(Words),
	write("Number of words: "), write(Words).
number_words(Words):- get0(X), n_words(X,Words,1).
n_words(10,Words,Words):-!.
n_words(32,Words,N):- N1 is N + 1, get0(X1), n_words(X1,Words,N1),!.
n_words(_,Words,N):- get0(X1), n_words(X1,Words,N).


%Task 3 Äàíà ñòðîêà. Îïðåäåëèòü ñàìîå ÷àñòîå ñëîâî
frequent_word :- read_str(A,_), get_words(A,Words,_), unique_elems(Words,U_words),
counts(U_words,C,Words), indOfMax(C,Ind), el_by_number(U_words,Ind,El),
	write_str(El).

%Âûâîä ïåðâîãî ñëîâà è îñòàëüíîé ñòðîêè get_word(+List, -Word, -List1)
get_word([],[],[]):-!.
get_word(A,Word,A2):- get_word(A,[],Word,A2).

get_word([],Word,Word,[]).
get_word([32|T],Word,Word,T):-!.
get_word([H|T],W,Word,A2):- append(W,[H],W1), get_word(T,W1,Word,A2).

%Âûâîä âñåõ ñëîâ è èõ êîëè÷åñòâà get_words(+List, -Words, -K)
get_words(A,Words,K):- get_words(A,[],Words,0,K).

get_words([],B,B,K,K):-!.
get_words(A,Temp_words,B,I,K):- skip_space(A,A1),get_word(A1,Word,A2),Word \=[],
	I1 is I+1,append(Temp_words,[Word],T_w),get_words(A2,T_w,B,I1,K),!.
get_words(_,B,B,K,K).

%Ïðîïóñê ïðîáåëà
skip_space([32|Tail],New_Str):- skip_space(Tail,New_Str),!.
skip_space(New_Str,New_Str).

%Cïèñîê áåç ïîâòîðîâ unique_elems(+List, -Result)
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

%Ñêîëüêî ðàç ýëåìåíò âñòðå÷àëñÿ â ñïèñêå count(+Elem, +List, -K)
count(_, [], 0):-!.
count(Elem, List, X):- count(Elem, List, 0, X).
count(_, [], Count, Count):- !.
count(Elem, [Elem|T], Count, X):- Count1 is Count + 1,
	count(Elem, T, Count1, X), !.
count(Elem, [_|T], Count, X):- count(Elem, T, Count, X).

%Íîìåð ìèíèìàëüíîãî ýëåìåíòà ñïèñêà
indOfMax(X,Y):-indexOfMin(X,Y).
indexOfMin([], -1):- !.
indexOfMin([H|T], X):-indexOfMin(T, 1, 1, X, H).
indexOfMin([], _, MinInd, MinInd, _):-!.
indexOfMin([H|T], CurInd, _, X, CurMin):-
 H > CurMin, NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, NewCurInd, X, H),!.
indexOfMin([_|T], CurInd, MinInd, X, CurMin):-
	NewCurInd is CurInd + 1, indexOfMin(T, NewCurInd, MinInd, X, CurMin).

%Âûâîä ýëåìåíòà íà äàííîé ïîçèöèè el_by_number(+List, +Number, -Elem)
el_by_number(A,Ind,El):- el_by_number(A,1,Ind,El).
el_by_number([],_,_,nil):-!.
el_by_number([El|_],Ind,Ind,El):-!.
el_by_number([_|T],I,Ind,El):-I1 is I+1, el_by_number(T,I1,Ind,El).

%Task 4. Äàíà ñòðîêà. Âûâåñòè ïåðâûå òðè ñèìâîëà è ïîñëåäíèå òðè
%ñèìâîëà, åñëè äëèíà ñòðîêè áîëüøå 5. Èíà÷å âûâåñòè ïåðâûé ñèìâîë
%ñòîëüêî ðàç, êàêîâà äëèíà ñòðîêè.
saint_three :- read_str(Str,N), (N > 5 -> three(Str) ; first(Str,N)).

three(Str):- three(Str,0).
three(_,7):-!.
three(Str,3):- reverse_list(Str,Str1), three(Str1,4),!.
three([H|T],I):- put(H), I1 is I + 1, three(T,I1).

first([H|_], N) :- first(H,N,0).
first(_,N,N):- !.
first(H,N,I):- put(H), I1 is I + 1, first(H,N,I1).

%Task 5. Äàíà ñòðîêà. Ïîêàçàòü íîìåðà ñèìâîëîâ, ñîâïàäàþùèõ ñ ïîñëåäíèì
%ñèìâîëîì ñòðîêè.
numbers_of_last :- read_str(Str,_),last_symbol(Str,El), list_el_numb(Str,El,0).
%Âûâîä íîìåðîâ ñèìâîëîâ, ñîâïàäàþùèõ ñ äàííûì
list_el_numb([],_,_):- !.
list_el_numb([H|_],H,Number):- write(Number),write(" "),fail.
list_el_numb([_|T],Elem,Number):- N1 is Number + 1, list_el_numb(T,Elem,N1).

%Ïîëó÷åíèå ïîñëåäíåãî ñèìâîëà ñòðîêè
last_symbol(Str,El):- reverse_list(Str,Str1), last_symbol(Str1,El,0).
last_symbol([H|_],H,0):- !.

%Task 6. Äàíà ñòðîêà. Ïîêàçàòü òðåòèé, øåñòîé, äåâÿòûé è òàê äàëåå ñèìâîëû.
plus_three :- read_str(Str,_), list_el_three(Str,0).

list_el_three([],_):- !.
list_el_three([_|T],0):- list_el_three(T,1),!.
list_el_three([H|T],Number):- (0 is Number mod 3 -> (put(H), write(" "),
N1 is Number + 1, list_el_three(T,N1)) ; (N1 is Number + 1, list_el_three(T,N1))).

%Task 7. Äàíà ñòðîêà. Îïðåäåëèòå îáùåå êîëè÷åñòâî ñèìâîëîâ '+' è '-' â íåé. À
%òàêæå ñêîëüêî òàêèõ ñèìâîëîâ, ïîñëå êîòîðûõ ñëåäóåò öèôðà íîëü.
plus_minus :- read_str(Str,_), symbols(Str,0,S1), after_null(Str,0,S2),
      write("Plus or minus: "), write(S1), nl, write("Plus or minus then null: "),
      write(S2).

%Ïîäñ÷¸ò ñèìâîëîâ "+" è "-"
symbols([],S1,S1):- !.
symbols([H|T],N1,S1):- ((H = 43 ; H = 45) -> (N is N1 + 1, symbols(T,N,S1)) ;
	symbols(T,N1,S1)).

%Ïîäñ÷¸ò ñèòóàöèé, êîãäà ïîñëå ñèìâîëà èä¸ò íóëü
after_null([H1,H2|T],N2,S2):- (((H1 = 43 ; H1 = 45), H2 = 48) -> (N is N2 + 1,
	after_null(T,N,S2)) ; after_null([H2|T],N2,S2)),!.
after_null([_|[]],S2,S2):- !.

%Task 8. Äàíà ñòðîêà. Îïðåäåëèòå, êàêîé ñèìâîë â íåé âñòðå÷àåòñÿ ðàíüøå: 'x'
% èëè 'w'. Åñëè êàêîãî-òî èç ñèìâîëîâ íåò, âûâåñòè ñîîáùåíèå îá ýòîì.
x_or_w :- read_str(Str,_), check(Str,0,0,X,W), (X = 0 -> (write("'x' is out"),!) ;
    (W = 0 -> (write("'w' is out"),!) ; earlier(Str))).

%Ïðîâåðêà, èìåþòñÿ ëè äàííûå ñèìâîëû â ñòðîêå
check([],X,W,X,W):- !.
check([H|T],X,W,N1,N2):- (H = 120 -> (X1 is X + 1, check(T,X1,W,N1,N2))) ;
		   (H = 119 -> (W1 is W + 1, check(T,X,W1,N1,N2)) ;
		   check(T,X,W,N1,N2)).

%Îïðåäåëåíèå ïåðâîãî âõîæäåíèÿ îäíîãî èç äàííûõ ñèìâîëîâ
earlier([H|T]):- (H = 120 -> (write("'x' is earlier"),!) ; (H = 119 ->
			     (write("'w' is earlier"),!)) ; earlier(T)).

%Task 9. Äàíû äâå ñòðîêè. Âûâåñòè áîëüøóþ ïî äëèíå ñòðîêó ñòîëüêî ðàç, íà
%ñêîëüêî ñèìâîëîâ îòëè÷àþòñÿ ñòðîêè.
long_length :- write("Insert first string: "), read_str(Str1,L1),
	write("Insert second string: "), read_str(Str2,L2), longer(L1,L2,R,S),
	(   S = -1 -> writed(Str1,R) ; writed(Str2,R)).

%Îïðåäåëåíèå ðàçíèöû ìåæäó äëèíàìè ñòðîê
longer(L1,L2,R,S):- L1 > L2, R is L1 - L2, S = -1,!.
longer(L1,L2,R,S):- R is L2 - L1, S = -2,!.

%Âûâîä ñòðîêè çàäàííîå êîëè÷åñòâî ðàç
writed(_,0):-!.
writed(Str,R):- write_str(Str), nl, R1 is R - 1, writed(Str,R1).

%Task 10. Äàíà ñòðîêà. Åñëè îíà íà÷èíàåòñÿ íà 'abc', òî çàìåíèòü èõ íà 'www',
%èíà÷å äîáàâèòü â êîíåö ñòðîêè 'zzz'.
zamena :- read_str(Str,_), replace(Str).

replace([H1,H2,H3|T]):- ((H1 = 97, H2 = 98, H3 = 99) ->
       (   append([119,119,119],T,New_str), write_str(New_str)) ;
       (   append([H1,H2,H3|T],[122,122,122],New_str), write_str(New_str))).

%Task 11. Äàíà ñòðîêà. Åñëè åå äëèíà áîëüøå 10, òî îñòàâèòü â ñòðîêå òîëüêî
%ïåðâûå 6 ñèìâîëîâ, èíà÷å äîïîëíèòü ñòðîêó ñèìâîëàìè 'o' äî äëèíû 12.
dozen :- read_str(Str,L), (L > 10 -> first_six(Str,0,[]) ; up_to_dozen(Str,L)).

%Îñòàâëÿåò â ñòðîêå ïåðâûå 6 ñèìâîëîâ
first_six([H|T],N,Str):- append(Str,[H],Rstr), N1 is N + 1,first_six(T,N1,Rstr),!.
first_six(_,6,Str):- write_str(Str),!.

%Äîïîëíÿåò ñòðîêó 'o' äî äëèíû 12
up_to_dozen(Rstr,12):- write_str(Rstr),!.
up_to_dozen(Str,L):- append(Str, [111], Rstr), L1 is L + 1, up_to_dozen(Rstr,L1).

%Task 12. Äàíà ñòðîêà. Ðàçäåëèòü ñòðîêó íà ôðàãìåíòû ïî òðè ïîäðÿä èäóùèõ
%ñèìâîëà. Â êàæäîì ôðàãìåíòå ñðåäíèé ñèìâîë çàìåíèòü íà ñëó÷àéíûé
%ñèìâîë, íå ñîâïàäàþùèé íè ñ îäíèì èç ñèìâîëîâ ýòîãî ôðàãìåíòà.
%Ïîêàçàòü ôðàãìåíòû, óïîðÿäî÷åííûå ïî àëôàâèòó.
fragments :- read_str(Str,N), N1 is N div 3, create_frags(Str,N1,Frags),
	zam_middle(Frags,RFrags), order_frags(RFrags).

%Ðàçäåëåíèå ñòðîêè íà ôðàãìåíòû çàäàííîé äëèíû create_frags(+Str,+N,-List)
create_frags(_,0,[]):- !.
create_frags([H1,H2,H3|T1],N1,[H|T]):- N is N1 - 1,create_frags(T1,N,T),
	H = [H1,H2,H3],!.

%Çàìåíà ñðåäíåãî ñèìâîëà íà ñëó÷àéíûé
zam_middle([],[]):- !.
zam_middle([H|T],[H1|T1]):- zam_middle(T,T1), zam_middle(H,3,R), H1 = R.
zam_middle([],0,[]):- !.
zam_middle([H|T],N,[H1|T1]):- N1 is N - 1, zam_middle(T,N1,T1), (N = 2 ->
	   H1 is random(256) ; H1 = H).

%Íàõîæäåíèå ìèíèìàëüíîãî ýëåìåíòà ñïèñêà
min_list_up([],0):-!.
min_list_up([H|T],Min):- min_list_up(T,Min1),(Min1 = 0 -> Min = H ; (H < Min1
     -> Min = H ; Min = Min1)).

%Âûâîä ôðàãìåíòîâ ïî àëôàâèòó
order_frags([]):- !.
order_frags([H|T]):- order(H), order_frags(T).
order([]):- write(" "),!.
order(List):- min_list_up(List,Min), put(Min), in_list_exlude(List,Min,List1),
	order(List1),!.

%Task 13. Äàíà ñòðîêà. Çàìåíèòü êàæäûé ÷åòíûé ñèìâîë èëè íà 'a', åñëè ñèìâîë
%íå ðàâåí 'a' èëè 'b', èëè íà 'c' â ïðîòèâíîì ñëó÷àå.
zamena_chet :- read_str(Str,_),replace_chet(Str,0,[],Rstr), write_str(Rstr).

replace_chet([],_,Rstr,Rstr):-!.
replace_chet([H|T],N,Rstr,R):- (0 is N mod 2 -> ((H \= 97, H \= 98) ->
       (   append(Rstr,[97],Rstr1), N1 is N + 1, replace_chet(T,N1,Rstr1,R)) ;
       (   append(Rstr,[99],Rstr1), N1 is N + 1, replace_chet(T,N1,Rstr1,R)));
	   append(Rstr,[H],Rstr1), N1 is N + 1, replace_chet(T,N1,Rstr1,R)).

%Task 14. Â äàííîé ñòðîêå íàéòè êîëè÷åñòâî öèôð.
number_numbers :- read_str(Str,_), cifra(Str,0,N), write(N).

cifra([],R,R):- !.
cifra([H|T],N,R):- (contains([48,49,50,51,52,53,54,55,56,57],H) -> (N1 is N + 1,
		  cifra(T,N1,R)); cifra(T,N,R)).

%Task 15. Äàíà ñòðîêà. Îïðåäåëèòü, ñîäåðæèò ëè ñòðîêà òîëüêî ñèìâîëû 'a', 'b',
%'c' èëè íåò.
a_b_c :- read_str(Str,_), contains(Str).

contains([]):-!.
contains([H|T]):- contains([97,98,99],H), contains(T).

%Task 16. Çàìåíèòå â ñòðîêå âñå âõîæäåíèÿ 'word' íà 'letter'.
letter :- read_str(Str,_), zamena(Str,[],Rstr), write_str(Rstr).

zamena([H2],Rstr,R) :- append(Rstr,[H2],R),!.
zamena([H2,H3],Rstr,R):- append(Rstr,[H2,H3],R),!.
zamena([H2,H3,H4],Rstr,R) :- append(Rstr,[H2,H3,H4],R),!.
zamena([],R,R):-!.
zamena([H1,H2,H3,H4|T],Rstr,R):- ((H1 = 119, H2 = 111, H3 = 114, H4 = 100) ->
      (	  append(Rstr,[108,101,116,116,101,114],Rstr1), zamena(T,Rstr1,R)) ;
      (   append(Rstr,[H1],Rstr1), zamena([H2,H3,H4|T],Rstr1,R))).

%Task 17. Óäàëèòå â ñòðîêå âñå áóêâû 'x'. çà êîòîðûìè ñëåäóåò 'abc'.
delete_x :- read_str(Str,_), delete_x(Str,[],R), write_str(R).

delete_x([H4],Str,R):- append(Str,[H4],R),!.
delete_x([H3,H4],Str,R):- append(Str,[H3,H4],R),!.
delete_x([H2,H3,H4],Str,R):- append(Str,[H2,H3,H4],R),!.
delete_x([],R,R):-!.
delete_x([H1,H2,H3,H4|T],Str,R):- ((H1 = 120, H2 = 97, H3 = 98, H4 = 99) ->
	 (   append(Str,[97,98,99],Rstr), delete_x(T,Rstr,R));
	 (   append(Str,[H1],Rstr), delete_x([H2,H3,H4|T],Rstr,R))).

%Task 18. Óäàëèòå â ñòðîêå âñå 'abc', çà êîòîðûìè ñëåäóåò öèôðà.
delete_abc :- read_str(Str,_), delete_abc(Str,[],R), write_str(R).

delete_abc([H4],Str,R):- append(Str,[H4],R),!.
delete_abc([H3,H4],Str,R):- append(Str,[H3,H4],R),!.
delete_abc([H2,H3,H4],Str,R):- append(Str,[H2,H3,H4],R),!.
delete_abc([],R,R):-!.
delete_abc([H1,H2,H3,H4|T],Str,R):- ((H1 = 97, H2 = 98, H3 = 99, H4 > 47, H4 < 58) ->(   append(Str,[H4],Rstr), delete_abc(T,Rstr,R));
	 (   append(Str,[H1],Rstr), delete_abc([H2,H3,H4|T],Rstr,R))).

%Task 19. Íàéäèòå êîëè÷åñòâî âõîæäåíèÿ 'aba' â ñòðîêó.
in_stroka :- read_str(Str,_), in_stroka(Str,0,N), write(N).

in_stroka([_],R,R):-!.
in_stroka([_,_],R,R):-!.
in_stroka([],R,R):-!.
in_stroka([H1,H2,H3|T],N,R):- ((H1 = 97, H2 = 98, H3 = 97) -> (N1 is N + 1,
	  in_stroka(T,N1,R)); in_stroka([H2,H3|T],N,R)).

%Task 20. Óäàëèòü â ñòðîêå âñå ëèøíèå ïðîáåëû, òî åñòü ñåðèè ïîäðÿä èäóùèõ
%ïðîáåëîâ çàìåíèòü íà îäèíî÷íûå ïðîáåëû. Êðàéíèå ïðîáåëû â ñòðîêå
%óäàëèòü.
delete_space :- read_str(Str,_), delete_space(Str,_,[],Rstr),
	delete_space(Rstr,[],R), write_str(R).

%Óäàëåíèå ëèøíåé ïîñëåäîâàòåëüíîñòè ïðîáåëîâ
delete_space([],_,R,R):-!.
delete_space([H|T],Last,Rstr,R):- (H = 32 -> (Last = 32 -> (Last1 = H,
       delete_space(T,Last1,Rstr,R)); (append(Rstr,[H],Rstr1), Last1 = H,
	delete_space(T,Last1,Rstr1,R))); (append(Rstr,[H],Rstr1), Last1 = H,
	  delete_space(T,Last1,Rstr1,R))).
%Óäàëåíèå êðàéíèõ ïðîáåëîâ â ñòðîêå.
delete_space([],R,R):-!.
delete_space([32],R,R):-!.
delete_space([H|T],Rstr,R):- ((Rstr = [],H = 32) -> delete_space(T,Rstr,R) ;
	     (	 append(Rstr,[H],Rstr1), delete_space(T,Rstr1,R))).

%Task 21. Äàíà ñòðîêà, ñîñòîÿùàÿ èç ñëîâ, ðàçäåëåííûõ ñèìâîëàìè, êîòîðûå
%ïåðå÷èñëåíû âî âòîðîé ñòðîêå. Ïîêàçàòü âñå ñëîâà
words :- write("Insert first string: "),read_str(Str1,_),
	write("Insert second string: "),read_str(Str2,_),words(Str1,Str2,[],Rstr),
	write("Words: "), nl, write_str(Rstr).

words([],_,R,R):-!.
words([H|T],Symbols,Rstr,R):- (contains(Symbols,H) -> (append(Rstr,[32],Rstr1),
    words(T,Symbols,Rstr1,R)); (append(Rstr,[H],Rstr1),words(T,Symbols,Rstr1,R))).

%Task 22. Äàíà ñòðîêà. Âûâåñòè ïåðâûé, ïîñëåäíèé è ñðåäíèé (åñëè îí åñòü)
%ñèìâîëû
symbols :- read_str(Str,N), N1 is N div 2,symbols(Str,0,0,First,Last),
	(0 is N mod 2 -> (write("First: "), put(First),nl, write("Last: "),
	 put(Last)); (middle(Str,N1,0,Middle), write("First: "), put(First),nl,
	   write("Last: "), put(Last), nl, write("Middle "), put(Middle))).

%Ïîèñê ïåðâîãî è ïîñëåäíåãî ñèìâîëà
symbols([],F,L,F,L):-!.
symbols([H],F,_,First,Last):- symbols([],F,H,First,Last),!.
symbols([H|T],0,L,First,Last):-	symbols(T,H,L,First,Last),!.
symbols([_|T],F,L,First,Last):- symbols(T,F,L,First,Last).
%Ïîèñê ñðåäíåãî ñèìâîëà
middle([H|_],N,N,H):-!.
middle([_|T],N,N1,Middle):- N2 is N1 + 1, middle(T,N,N2,Middle).
