fact(X,R):- X=1, R is 1.
fact(X,R):- X2 is X-1, fact(X2,R2), R is X *R2.

comb(M,N,R):- M>N, fact(M,FM), fact(N,FN), DIFMN is M - N, fact(DIFMN,
  F_DIF), R is (FM/(F_DIF*FN)).
