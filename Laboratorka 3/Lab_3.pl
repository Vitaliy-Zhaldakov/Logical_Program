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
sum_up(N,X):- N1 is N div 10, sum(N1,X1), X is X1 + N mod 10.
