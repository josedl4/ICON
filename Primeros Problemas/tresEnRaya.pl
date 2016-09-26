%%% Juego TIC TAC TOE implementado en prolog %%%

% Lineas posibles para formar una jugada ganadora %
enlinea([1, 2, 3]).
enlinea([4, 5, 6]).
enlinea([7, 8, 9]).
enlinea([1, 4, 7]).
enlinea([2, 5, 8]).
enlinea([3, 6, 9]).
enlinea([1, 5, 9]).
enlinea([3, 5, 7]).

% Funcion que nos da el elemeto de una lista %
argumento(Posicion, Lista, X):- Posicion=1, arg(1, Lista, X).
argumento(Posicion, Lista, X):- Posicion>1, arg(2, Lista, Y), Pos is Posicion-1,
argumento(Pos, Y, X).

% Estas tres funciones con comprueban los 3 posibles valores que una %
% posicion puede contener en cada momento
vacio(Casilla, Tablero):- argumento(Casilla, Tablero, Valor), Valor="".

cruz(Casilla, Tablero):- argumento(Casilla, Tablero, Valor), Valor=x.

cara(Casilla, Tablero):- argumento(Casilla, Tablero, Valor), Valor=o.

% Comprueba en una linea en que posicion esta la amenaza %
amenaza([X, Y, Z], B, X):- vacio(X, B), cruz(Y, B), cruz(Z, B).
amenaza([X, Y, Z], B, Y):- cruz(X, B), vacio(Y, B), cruz(Z, B).
amenaza([X, Y, Z], B, Z):- cruz(X, B), cruz(Y, B), vacio(Z, B).

% Analiza si existe un movimiento_forzoso a realizar para no perder la jugada %
% para las caras                                                              %
movimiento_forzoso(Tablero, Casilla) :- enlinea(Linea),
amenaza(Linea, Tablero, Casilla), !.
caso1(X):- movimiento_forzoso([x, v, o,
                               v, v, x,
                               x, o, v], X).
