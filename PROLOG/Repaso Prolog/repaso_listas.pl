% Ejemplo que comprueba cual de las dos palabras es menor que la otra alfabeticamente hablando.
amenor(X, Y) :- name(X, L), name(Y, M), amenorx(L, M).
amenorx([], [_|_]).
amenorx([X|_], [Y|_]) :- X<Y.
amenorx([A|X], [B|Y]) :- A=B, amenorx(X, Y).
