% Мужчины:
man(vladimir).
man(oleg).
man(yuri).
man(vladislav).
man(ilya).
man(denis).
man(alexey).
man(alexandr).

% Женщины:
woman(ann).
woman(angelina).
woman(sofia).
woman(victoria).
woman(margaret).
woman(natalya).
woman(maria).
woman(julia).

% Семьи:
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

% Task 1 Предикаты вывода всех мужчин и женщин
man():-man(X),write(X),nl,fail.
woman() :-woman(X),write(X),nl,fail.

% Task 2 Предикат вывода всех детей 'X'
children(X) :- parent(X,Y),write(Y),nl,fail.

% Task 3 Предикаты проверки матери и вывод матери 'X'
mother(X,Y) :- parent(X,Y),woman(X).
mother(X) :- mother(Y,X),write(Y).

% Task 4 Предикаты проверки сына и вывод сына 'X'
son(X,Y) :- parent(Y,X),man(X).
son(X) :- son(Y,X),write(Y).

% Task 5 Предикаты проверки брата и вывод всех братьев 'X'
brother(X,Y) :- mother(Z,X),mother(Z,Y),man(X),X\=Y.
brothers(X) :- brother(Y,X),write(Y),nl,fail.

% Task 6 Предикаты проверки мужа и вывод мужа 'X'
husband(X,Y) :- parent(X,Z),parent(Y,Z),man(X),X\=Y.
husband(X) :- husband(Y,X),write(Y).

% Task 7 Предикаты проверки братьев и сестёр и вывод всех братьев и сестёр 'X'
b_s(X,Y) :- mother(Z,X),mother(Z,Y),X\=Y.
b_s(X) :- b_s(Y,X),write(Y),nl,fail.

% Task 8 Предикаты проверки дедушки и вывод всех дедушек 'X'
grand_pa(X,Y) :- parent(Z,Y),parent(X,Z),man(X).
grand_pas(X) :- grand_pa(Y,X),write(Y),nl,fail.

% Task 9 Предикаты проверки внука и вывод всех внуков 'X'
grand_so(X,Y) :- parent(Z,X),parent(Y,Z),man(X).
grand_sons(X) :- grand_so(Y,X),write(Y),nl,fail.

% Task 10 Предикаты проверки дедушки и внука
grand_pa_and_son(X,Y) :- grand_pa(X,Y),grand_so(Y,X).
grand_pa_and_son(X,Y) :- grand_pa(Y,X),grand_so(X,Y).

% Task 11 Предикаты проверки дедушки и внучки
grand_pa_and_da(X,Y) :- grand_pa(X,Y),parent(Z,Y),parent(X,Z),woman(Y).
grand_pa_and_da(X,Y) :- grand_pa(Y,X),parent(Z,X),parent(Y,Z),woman(X).

% Task 12 Предикаты проверки дяди и вывод всех дядей 'X'
uncle(X,Y) :- parent(Z,Y),brother(X,Z).
uncles(X) :- uncle(Y,X),write(Y),nl,fail.

% Task 13 Предикаты проверки племянницы и вывод всех племянниц 'X'
niece(X,Y) :- uncle(Y,X),woman(X).
nieces(X) :- niece(Y,X),write(Y),nl,fail.
