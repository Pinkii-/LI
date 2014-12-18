nat(0).
nat(N):- nat(N1), N is N1+1.

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

pert_con_resto(' ',[],[]).
pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

primer(' ',[]).
primer(X,[X|_]).

datosEjemplo( [[1,2,6],[1,6,7],[2,3,8],[6,7,9],[6,8,9],[1,2,4],[3,5,6],[3,5,7],
               [5,6,8],[1,6,8],[4,7,9],[4,6,9],[1,4,6],[3,6,9],[2,3,5],[1,4,5],
               [1,6,7],[6,7,8],[1,2,4],[1,5,7],[2,5,6],[2,3,5],[5,7,9],[1,6,8]] ).



solucionOptima:- datosEjemplo([[X,Y,Z]|L]), nat(N), solucion(N,L,[[X],[Y],[Z]], S), nl, writeSolution(S), nl, halt.

solucion(_,[],S,S).
solucion(N,[[X,Y,Z]|L], S1, S2):- possible([X,Y,Z], S1, S3), cost(S3,K), K =< N, solucion(N,L,S3,S2).

possible([X,Y,Z],[S1,S2,S3],[S4,S5,S6]):-
    permutation([X,Y,Z],[A,B,C]),
    add(A,S1,S4),
    add(B,S2,S5),
    add(C,S3,S6).

add(X,L,L):- member(X,L),!.
add(X,L,L2):- append(L,[X],L2).

cost([],0).
cost([L1|L],C):- cost(L,C1), length(L1,C2), C is C1 + C2. 

writeSolution([[],[],[]]).
writeSolution([L1,L2,L3]):- nl, pert_con_resto(X,L1,L11), primer(X,L1), write('- '), write(X), 
                            pert_con_resto(Y,L2,L22), primer(Y,L2), write(' '), write(Y), 
                            pert_con_resto(Z,L3,L33), primer(Z,L3), write(' '), write(Z), 
                            writeSolution([L11,L22,L33]).
