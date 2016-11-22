%%% Arbol que describe los Componentes de una bicicleta %%%

% Piezas basicas
pieza_basica(llanta).
pieza_basica(radios).
pieza_basica(eje).
pieza_basica(manillar).
pieza_basica(sillin).
pieza_basica(plato).
pieza_basica(pedales).
pieza_basica(cadena).
pieza_basica(pinones).

ensamblaje(bicicleta, [rueda_delantera,cuadro,rueda_trasera]).
ensamblaje(rueda_delantera, [llanta,radios,eje]).
ensamblaje(cuadro, [manillar,sillin,traccion]).
ensamblaje(traccion, [eje, plato, pedales, cadena]).
ensamblaje(rueda_trasera, [llanta,radios,eje,pinones]).

pieza_de([], []).
pieza_de(X, [X]) :- pieza_basica(X).
pieza_de(X,Y) :- ensamblaje(X,Subpiezas),lista_de_piezas(Subpiezas,Y).

lista_de_piezas([],[]).
lista_de_piezas([Cabeza|Cola], Total) :- pieza_de(Cabeza, PiezasCabeza),
lista_de_piezas(Cola,PiezasCola), append(PiezasCabeza,PiezasCola,Total).
