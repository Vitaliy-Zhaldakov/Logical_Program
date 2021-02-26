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

