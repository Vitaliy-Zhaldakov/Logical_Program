max(X,Y,X):- X > Y,!.
max(_,Y,Y).

max(X,Y,U,Z):- max(X,Y,C), max(U,C,Z).

fact(0,1):-!.
fact(N,X):- N1 is N - 1,fact(N1,X1),X is X1*N.

fact_down(N,X):- fact_down(0,1,N,X).
fact_down(N,X,N,X):-!.
fact_down(I,C,N,X):- I1 is I + 1, C1 is C * I1, fact_down(I1,C1,N,X).
