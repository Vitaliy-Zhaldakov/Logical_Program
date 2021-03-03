read_list(0,[]):-!.
read_list(N,[H|T]):- read(H),N1 is N - 1, read_list(N1,T).
write_list([]):-!.
write_list([H|T]):- write(H), write(", "), write_list(T).
