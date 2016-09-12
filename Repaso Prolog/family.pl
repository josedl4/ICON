%Genero de nuestros sujetos
es_mujer(ana).
es_mujer(elena).
es_mujer(marta).
es_mujer(teresa).
es_hombre(carlos).
es_hombre(juan).
es_hombre(paco).
es_hombre(raul).

%Realaciones entre los sujetos
es_padre_de(carlos,juan).
es_padre_de(carlos,elena).
es_madre_de(ana,juan).
es_madre_de(ana,elena).

es_padre_de(juan,teresa).
es_madre_de(marta,teresa).

es_padre_de(paco,raul).
es_madre_de(elena,raul).

%Reglas que definen los lazos entre los sujetos
es_hijo_de(X,Y):-es_padre_de(Y,X),es_hombre(X).
es_hijo_de(X,Y):-es_madre_de(Y,X),es_hombre(X).

es_hija_de(X,Y):-es_padre_de(Y,X),es_mujer(X).
es_hija_de(X,Y):-es_madre_de(Y,X),es_mujer(X).

es_nieto_de(X,Z):-es_hijo_de(X,Y),es_hijo_de(Y,Z),es_hombre(X).
es_nieto_de(X,Z):-es_hijo_de(X,Y),es_hija_de(Y,Z),es_hombre(X).

es_nieta_de(X,Z):-es_hija_de(X,Y),es_hijo_de(Y,Z),es_mujer(X).
es_nieta_de(X,Z):-es_hija_de(X,Y),es_hija_de(Y,Z),es_mujer(X).

es_primo_de(P,X):-es_nieto_de(P,Y), es_nieta_de(X,Y), es_hombre(P), P\=X.
es_primo_de(P,X):-es_nieto_de(P,Y), es_nieto_de(X,Y), es_hombre(P), P\=X.

es_prima_de(P,X):-es_nieta_de(P,Y), es_nieto_de(X,Y), es_mujer(P), P\=X.
es_prima_de(P,X):-es_nieta_de(P,Y), es_nieta_de(X,Y), es_mujer(P), P\=X.
