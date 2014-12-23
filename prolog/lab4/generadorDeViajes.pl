:-include(viaje).

nat(0).
nat(N):- nat(N1), N is N1+1.

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).


/*
solucionOptima:- ciutats(C), interessos(I), nat(N), solucion(N,C,I,[],S), nl, write(S),nl.

solucion(_,_,[],S,S).
solucion(N,[C1|C],I,S1,S2):- atractius(C1,A), sirve(A,I,I2),
                             length(I,LI), length(I2,LI2), LI>LI2, !,
                             length([C1|S1], LS3), LS3 =< N, solucion(N,C,I2,[C1|S1],S2).
solucion(N,[_|C],I,S1,S2):- solucion(N,C,I,S1,S2).

sirve([],I,I).
sirve([X|A],I,I3):- member(X,I), pert_con_resto(X,I,I2), sirve(A,I2,I3), !.
sirve([_|A],I,I2):- sirve(A,I,I2).*/


solucionOptima:- interessos(I), nat(N), solucion(N,I,S), nl, write(S), nl.

solucion(_,[],[]).
solucion(N,[Int|Ints],[C|S]):- N>0, atractius(C,A), member(Int,A), removeAll(A,Ints,Ints1), 
                             N1 is N-1, solucion(N1,Ints1,S).

removeAll([],L,L).
removeAll([X|L1],L2,Resto):- member(X,L2), !, pert_con_resto(X,L2,L3), removeAll(L1,L3,Resto).
removeAll([_|L1],L2,Resto):- removeAll(L1,L2,Resto).





















