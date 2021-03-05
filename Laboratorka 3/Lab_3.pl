max(X,Y,X):- X > Y,!.
max(_,Y,Y).

max(X,Y,U,Z):- max(X,Y,C), max(U,C,Z).

fact(0,1):-!.
fact(N,X):- N1 is N - 1,fact(N1,X1),X is X1*N.

fact_down(N,X):- fact_down(0,1,N,X).
fact_down(N,X,N,X):-!.
fact_down(I,C,N,X):- I1 is I + 1, C1 is C * I1, fact_down(I1,C1,N,X).

fib(1,1):-!.
fib(2,1):-!.
fib(N,X):- N1 is N - 1, N2 is N - 2, fib(N1,X1),fib(N2,X2),X is X1 + X2.

fib_down(N,X):- fib_down(1,1,N,X).
fib_down(X,_,1,X):-!.
fib_down(I1,I2,N,X):- N1 is N-1, N2 is I1 + I2,fib_down(I2,N2,N1,X).

sum_up(0,0):-!.
sum_up(N,X):- N1 is N div 10, sum_up(N1,X1), X is X1 + N mod 10.

sum_down(N,X):- sum_down(N,0,X).
sum_down(0,X,X):-!.
sum_down(N,S,X):- N1 is N mod 10, N2 is N div 10, S1 is S + N1,
    sum_down(N2,S1,X).

max_num_up(0,0):-!.
max_num_up(N,Max):- N1 is N div 10, max_num_up(N1,Max1), N2 is N mod 10,
    (   N2 > Max1 -> Max = N2 ; Max = Max1).

max_num_down(N,Max):- max_num_down(N,0,Max).
max_num_down(0,Max,Max):-!.
max_num_down(N,Curr_max,Max):- N1 is N mod 10, N2 is N div 10,
    (   N1 > Curr_max -> Max1 = N1 ; Max1 = Curr_max), max_num_down(N2,Max1,Max).

min_nechet_up(0,10):-!.
min_nechet_up(N,X):- N1 is N div 10, min_nechet_up(N1,Min1),
    N2 is N mod 10, ((N2 < Min1, N3 is N2 mod 2, N3 \= 0) -> X = N2 ;
                  X = Min1).

min_nechet_down(N,X):- min_nechet_down(N,10,X).
min_nechet_down(0,10,_):-!.
min_nechet_down(0,X,X):-!.
min_nechet_down(N,Curr_min,X):- N1 is N mod 10, N2 is N div 10,
    (   (N1 < Curr_min, N3 is N1 mod 2, N3 \= 0) -> Min1 = N1 ; Min1 = Curr_min),
    min_nechet_down(N2,Min1,X).

nod(X,Y,Nod):- nod(X,Y,0,1,Nod).
nod(_,Y,Y,Nod,Nod):-!.
nod(X,_,X,Nod,Nod):-!.
nod(X,Y,I,Cur_nod,Nod):- I1 is I + 1,((0 is X mod I1, 0 is Y mod I1) ->
           Cur_nod1 = I1 ; Cur_nod1 = Cur_nod),nod(X,Y,I1,Cur_nod1,Nod).

is_simple(X):- is_simple(X,2).
is_simple(X,X):-!.
is_simple(X,I):- X1 is X mod I, X1 \= 0, I1 is I + 1, is_simple(X,I1).

kol_del(N,Count):- kol_del(N,N,Count).
kol_del(1,_,1):-!.
kol_del(I,N,Count):- I1 is I - 1, kol_del(I1,N,C),(0 is N mod I -> Count is C + 1 ;Count is C).

kolatc(Number):-kolatc(1,1,1,Number).
kolatc(1000000,I,_,I):-!.
kolatc(Number,I,Max_I,Max_N):- New_number is Number+1,
    kolatc_length(New_number,1,Lenght),(Lenght > Max_I ->
    kolatc(New_number,New_number,Lenght,Max_N);
    kolatc(New_number,I,Max_I,Max_N)).

kolatc_length(1,Result,Result):-!.
kolatc_length(Number,Lenght,Result):- Lenght1 is Lenght + 1,
    (Number mod 2 =:= 0 -> New_Number is Number / 2,
     kolatc_length(New_Number,Lenght1,Result) ; New_Number is (Number*3+1),
     kolatc_length(New_Number,Lenght1,Result)).


kolvo_del_up(N,X):- kolvo_del_up(N,N,X).
kolvo_del_up(_,1,1):-!.
kolvo_del_up(N,I,X):- I1 is I - 1, kolvo_del_up(N,I1,X1),
    (   (0 is N mod I, N1 is I mod 3, N1\=0) -> X is X1 + 1 ; X = X1).

kolvo_del_down(N,X):- kolvo_del_down(N,N,0,X).
kolvo_del_down(_,0,X,X):-!.
kolvo_del_down(N,I,P,X):- ((0 is N mod I, N1 is I mod 3, N1\=0)->
    P1 is P + 1 ; P1 = P),I1 is I - 1, kolvo_del_down(N,I1,P1,X).

mult_up(0,1):-!.
mult_up(N,Mult):- N1 is N div 10, mult_up(N1,Mult1), Mult is Mult1 * (N mod 10).

sum_del(N,sum):- sum_del(N,N,0,sum).
sum_del(_,0,sum,sum):-!.
sum_del(N,I,sum1,sum):- sum_down(N,S), mult_up(N,M),
    (0 is N mod I, nod(S,I,Nod1),Nod1 = 1, nod(M,I,Nod), Nod \= 1) ->
    (sum2 is sum1 + I, I1 is I - 1,sum_del(N,I1,sum2,sum)) ;
    (I1 is I - 1,sum_del(N,I1,sum1,sum)).
