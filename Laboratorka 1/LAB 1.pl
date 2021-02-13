man(vladimir).
man(oleg).
man(yuri).
man(vladislav).
man(ilya).
man(denis).
man(alexey).
man(alexandr).

woman(ann).
woman(angelina).
woman(sofia).
woman(victoria).
woman(margaret).
woman(natalya).
woman(maria).
woman(julia).

parent(vladimir,angelina).
parent(vladimir,yuri).
parent(vladimir,vladislav).
parent(ann,angelina).
parent(ann,yuri).
parent(ann,vladislav).

parent(oleg,ilya).
parent(oleg,denis).
parent(oleg,margaret).
parent(angelina,ilya).
parent(angelina,denis).
parent(angelina,margaret).

parent(yuri,natalya).
parent(yuri,alexey).
parent(sofia,natalya).
parent(sofia,alexey).

parent(vladislav,maria).
parent(vladislav,alexander).
parent(vladislav,julia).
parent(victoria,maria).
parent(victoria,alexander).
parent(victoria,julia).

man():-man(X),write(X),nl,fail.
woman() :-woman(X),write(X),nl,fail.
children(X) :- parent(X,Y),write(Y),nl,fail.

mother(X,Y) :- parent(X,Y),woman(X).
mother(X) :- mother(Y,X),write(Y).

son(X,Y) :- parent(Y,X),man(X).
son(X) :- son(Y,X),write(Y).

brother(X,Y) :- mother(Z,X),mother(Z,Y),man(X),X\=Y.
brothers(X) :- brother(Y,X),write(Y),nl,fail.

husband(X,Y) :- parent(X,Z),parent(Y,Z),man(X),X\=Y.
husband(X) :- husband(Y,X),write(Y).

b_s(X,Y) :- mother(Z,X),mother(Z,Y),X\=Y.
b_s(X) :- b_s(Y,X),write(Y),nl,fail.

grand_pa(X,Y) :- parent(Z,Y),parent(X,Z),man(X).
grand_pas(X) :- grand_pa(Y,X),write(Y),nl,fail.

grand_so(X,Y) :- parent(Z,X),parent(Y,Z),man(X).
grand_sons(X) :- grand_so(Y,X),write(Y),nl,fail.

grand_pa_and_son(X,Y) :- grand_pa(X,Y),grand_so(Y,X).
grand_pa_and_son(X,Y) :- grand_pa(Y,X),grand_so(X,Y).

grand_pa_and_da(X,Y) :- grand_pa(X,Y),parent(Z,Y),parent(X,Z),woman(Y).
grand_pa_and_da(X,Y) :- grand_pa(Y,X),parent(Z,X),parent(Y,Z),woman(X).

uncle(X,Y) :- parent(Z,Y),brother(X,Z).
uncles(X) :- uncle(Y,X),write(Y),nl,fail.

niece(X,Y) :- uncle(Y,X),woman(X).
nieces(X) :- niece(Y,X),write(Y),nl,fail.
