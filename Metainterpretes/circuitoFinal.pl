%%% Añadimos nuevos operadores a nuesto meta-interprete %%%
:-op(40, xfy, &).
:-op(50, xfy, --->).

builtin(A is B).
builtin(A > B).
builtin(A < B).
builtin(A = B).
builtin(A =:= B).
builtin(A =/= B).
builtin(A =< B).
builtin(A >= B).
builtin(functor(T, F, N)).
builtin(read(X)).
builtin(write(X)).
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

solve_traza(true):-!.
solve_traza((A & B)) :-!, solve_traza(A), solve_traza(B).
solve_traza(A):-
  write('Call: '), write(A), nl,
  clause((B ---> A), Body), solve_traza(B),
  write('Exit: '), write(A), nl.

solve_traza_nivel(true, L):-!.
solve_traza_nivel((A & B), L) :-!, solve_traza_nivel(A, L), solve_traza_nivel(B, L).
solve_traza_nivel(A, Level):-
  tab(Level), write(Level), write(' Call: '), write(A), nl,
  clause((B ---> A), Body), Level2 is Level + 1,
  B =/= true, solve_traza_nivel(B, Level2),
  tab(Level), write(Level), write(' Exit: '), write(A), nl.
