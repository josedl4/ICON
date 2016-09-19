%%%% Definimos una función y su serie.

% Definimos fn como f(n) = 3·f(n-1) + 2·f(n-2), con los casos base de
% f(0) = 0
% f(1) = 1
fn(0, 0):-!.
fn(1, 1):-!.
fn(N, R):- N1 is N-1, N2 is N-2, fn(N1, R1), fn(N2, R2),
  R is ((R2*2)+(R1*3)).

% Definimos la serie para la función fn anteriormente descrita.
serie(0,0).
serie(1,1).
serie(N,RT):-N1 is N-1, serie(N1, R1), fn(N,R), RT is R + R1,!.
