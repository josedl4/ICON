% Instancia especifica
value(outside, 1).
cBreaker(cb1).
cBreaker(cb2).
ok(_).
connected(w5, outside).

switch1(s3).
switch2(s1).
switch2(s2).
up(s2).
up(s3).
down(s1).

ligth(l1).
ligth(l2).
powerOutlet(p1).
powerOutlet(p2).

connected(l1, w0).
connected(l2, w4).
connected(p1, w3).
connected(p2, w6).

connected(w0, w1):- up(s2).
connected(w0, w2):- down(s2).
connected(w1, w3):- up(s1).
connected(w2, w3):- down(s1).
connected(w4, w3):- up(s3).

connected(w3, w5):- ok(cb1).
connected(w3, w6):- ok(cb2).

% Base de conocimiento
lit(X):- ligth(X), value(X, 1).
value(X, Value):- connected(X, Y), value(Y, Value).

% meta-interprete
solve(true, 'true'):- !.
solve((A,B), ProofResult) :- !, solve(A, ProofA), solve(B, ProofB) , append([ProofA], [ProofB], ProofResult).
solve(A, ( A:- BProof)) :- clause(A, B), solve(B, BProof).
