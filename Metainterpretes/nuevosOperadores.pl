%%% Añadimos nuevos operadores a nuesto meta-interprete %%%
:-op(40, xfy, &).
:-op(50, xfy, --->).

builtin(A is B).
builtin(A > B).
builtin(A < B).
builtin(A = B).
builtin(A =:= B).
builtin(A =< B).
builtin(A >= B).
% builtin(A ---> B).
% builtin(A & B).
builtin(functor(T, F, N)).
builtin(read(X)).
builtin(write(X)).

% valor(w1, 1).
% conectado(w2, w1).
% conectado(w3, w2).
% valor(W,X):-conectado(W,V), valor(V, X).

true ---> valor(w1, 1).
true ---> conectado(w2, w1).
true ---> conectado(w3, w2).
conectado(W,V) & valor(V,X) ---> valor(W,X).

% solve(true):- !.
% solve((A,B)):- !, solve(A), solve(B).
% solve(A):- !, clause(A,B), solve(B).

solve(true):- !.
solve((A & B)):- !, solve(A), solve(B).
solve(A):- !, clause((B ---> A), Body), solve(B).
