builtin(A =/= B).
% Base de conocimiento
ave(canario).
ave(pinguino).

%vuela(X):- ave(X), X =/= pinguino.

% meta-interprete
solve(true, In, In) :-!.
solve((A,B), In, Exit) :-!, solve(A, In, TMP), solve(B, TMP, Exit).
solve(A, (A:-builtin)):- builtin(A), !, A.
solve(A, In, X) :- clause(A, B), append(In, [A], In2), solve(B, In2, X).
