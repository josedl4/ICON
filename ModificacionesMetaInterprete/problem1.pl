% Base de conocimiento
ave(canario).
ave(pinguino).

% meta-interprete
solve(true) :-!.
solve((A,B)) :-!, solve(B), solve(A).
solve(A) :- clause(A, B), solve(B).

% Si realizamos una prueba de la ejecuccion del programa mediante el comando trace,
% y hacemos una pregunta tal que :-ave(canario), ave(pinguino). Podremos ver que
% primero se resuelve el primer liteal mas a la derecha.
