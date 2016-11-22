ave(X):- ave(X).
ave(canario).
ave(pinguino).

% meta-interprete
solve(true, _) :- !.
solve((A,B), N) :-!, solve(A, N), solve(B, N).
solve(_, N) :- N == 1, !, fail.
solve(A, N) :- clause(A, B), N1 is N - 1, N1 >= 0, solve(B, N1).
