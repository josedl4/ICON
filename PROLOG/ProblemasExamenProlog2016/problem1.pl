% meta-interprete
solve(true, _):- !.
solve((A,B), Prf) :- !, solve(A, Prf), solve(B, Prf).
solve(A, Prf) :- clause(A, B), X is Prf -1, X >= 0, solve(B, X).

% Esta nueva modificación del meta-interprete lo que realiza es recorrer todo el posible
% arbol de exploriación y da todas las soluciones con un nivel maximo de profundidad del valor Prf
% al hacer esto puede haber respuestas iguales pero con disitintos niveles de profundidad segun
% la base de conocimiento que hemos tengamos implementada.
