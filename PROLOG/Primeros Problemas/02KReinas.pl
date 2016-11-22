%%% Problema para calcular los posibles tableros del juego de las K-Reinas %%%

% Comprobamos en una casilla con una reina, sus diagonales completas. %
comprobar(P,Rep,Lista,Next):-Next >= Rep.
comprobar(P,Rep,Lista,Next):-PNext is P+Next, nth1(PNext,Lista,C), nth1(P,Lista,E),
 C =\= (E+Next), C=\= E-Next, Next1 is Next + 1, comprobar(P, Rep, Lista, Next1).

% Comprobamos las K reinas que cada una cumpla la condición llamando a comprobar %
comprobarDiagonal([A|B],Length):-B=[].
comprobarDiagonal([A|B],Length):-comprobar(1, Length, [A|B], 1),
  NewLength is Length - 1, comprobarDiagonal(B, NewLength).

% Calculamos las posibles permutaciones que componene todos los posibles tableros %
%  en este juego %
diagReina(N, Sol):- numlist(1, N, L), permutation(L, Sol), comprobarDiagonal(Sol, N).
