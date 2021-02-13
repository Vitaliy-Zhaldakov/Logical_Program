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


man():-man(X),write(X),nl,fail.
woman() :-woman(X),write(X),nl,fail.
