concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).

concat2(L,[],L).
concat2(L1,[X|L2],[X|L3]):- concat2(L1,L2,L3).

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

%-------Ej 1 -------------------------------------------------------------------



%-------Ej 2 -------------------------------------------------------------------
prod([],1).
prod([X|L],P):- prod(L,P1), P is P1*X.

%-------Ej 3 -------------------------------------------------------------------
pescalar([],[],0).
pescalar([X|L1],[Y|L2],P):- pescalar(L1,L2,P1), P is X*Y+P1.

%-------Ej 4 -------------------------------------------------------------------

interseccion([],_,[]).
interseccion([X|C1],C2,[X|C3]):- member(X,C2),!, interseccion(C1,C2,C3).
interseccion([_|C1],C2,C3):- interseccion(C1,C2,C3).

union([],C2,C2).
union([X|C1],C2,C3):- member(X,C2),! , union(C1,C2,C3).
union([X|C1],C2,[X|C3]):- union(C1,C2,C3).

%-------Ej 5 -------------------------------------------------------------------

% Sin Concat
ultimoS([X],X).
ultimoS([_|L],U):- ultimoS(L,U).

% Con Concat
%Porque el caso base de este concat tiene la lista vacia en el lado izquierdo
ultimo(L,X):- concat(_,[X],L). 
% concat 2
ultimo2(L,X):- concat2([X],_,L).

%-------Ej 6 -------------------------------------------------------------------
fib(0,1):-!.
fib(1,1):-!.
fib(N,F):- N1 is N-1, N2 is N-2,
           fib(N1,F1), fib(N2,F2), 
           F is F1 + F2.

%-------Ej 7 -------------------------------------------------------------------
dados(0,0,[]):-!.
dados(P,N,L):- between(1,6,D), P1 is P-D, P1>=0, 
               N1 is N-1, dados(P1,N1,L1), concat(L1,[D],L).

%-------Ej 8 -------------------------------------------------------------------
suma([],0).
suma([X|L],S):- suma(L,S1), S is S1+X.

suma_demas(L):- pert_con_resto(X,L,Demas), suma(Demas,X),!.

%-------Ej 9 -------------------------------------------------------------------

suma_ants(L):- suma(L1,R)


















