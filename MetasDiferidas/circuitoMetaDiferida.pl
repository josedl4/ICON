%%% Añadimos nuevos operadores a nuesto meta-interprete %%%
:-op(40, xfy, &).
:-op(50, xfy, --->).

builtin(A is B).
builtin(A > B).
builtin(A < B).
builtin(A = B).
builtin(A =:= B).
builtin(A =\= B).
builtin(A =< B).
builtin(A >= B).
builtin(functor(T, F, N)).
builtin(read(X)).
builtin(write(X)).
builtin(append(A, B, C)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% Enunciado del problema 1 %%
true ---> live(outside).
true ---> up(s1).
true ---> up(s2).
true ---> up(s3).
true ---> ok(_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Base de conocimiento %%%%
true ---> light(l1).
true ---> light(l2).

up(s2)&
ok(s2) ---> connected_to(w0, w1).

not(up(s2))&
ok(s2) ---> connected_to(w0, w2).

up(s1)&
ok(s1) ---> connected_to(w1, w3).

not(up(s1))&
ok(s1) ---> connected_to(w2, w3).

up(s3)&
ok(s3) ---> connected_to(w4, w3).


ok(cb1) ---> connected_to(w3,w5).
ok(cb2) ---> connected_to(w6,w5).

true ---> connected_to(w5, outside).
true ---> connected_to(l1, w0).
true ---> connected_to(l2, w4).
true ---> connected_to(p1, w3).
true ---> connected_to(p2, w6).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Reglas %%%%%%%%%%%%%
light(L)&
ok(L)&
live(L)
---> lit(L).

connected_to(W,W1)&
live(W1)
---> live(W).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solve(true):- !.
solve((A & B)):- !, solve(A), solve(B).
solve(A):- !, clause((B ---> A), Body), solve(B).

dsolve(true, D, D):-!.
dsolve((A & B), [], D) :- !, dsolve(A, [], DA), dsolve(B, [], DB), append(DA, DB, D).
dsolve(A, [], DA):- A \= ok(X), clause((B ---> A), Body), dsolve(B, [], DB), append(BD,[],DA).
dsolve(A, [], DA):- !, A = ok(X), append([A],[],DA).
