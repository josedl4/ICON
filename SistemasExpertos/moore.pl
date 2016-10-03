%%%% Implementación de una maquina de Moore a traves de un diagrama de estados dado %%%%

% Definimos las transiciones %
transition(q0,a,q2).
transition(q0,b,q1).

transition(q1,a,q0).
transition(q1,b,q3).

transition(q2,a,q2).
transition(q2,b,q3).

transition(q3,a,q0).
transition(q3,b,q3).

% Definimos una función que dado un nodo incial y la secuencia de operaciones nos %
% retorne el nodo fin. %
sequence(I,[],I):-!.
sequence(I,Chain,F):-transition(I,Chain,F).
sequence(I,[A|B],F):-transition(I,A,M), sequence(M,B,F),!.
