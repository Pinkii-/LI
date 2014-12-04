nat(0).
nat(N):- nat(N1), N is N1+1. 

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):- 
    unPaso( EstadoActual, EstSiguiente ), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

/*
solucionOptima:-
    nat(N),
    camino([3,3,0,0,0],[0,0,3,3,_],[[3,3,0,0,0]],C),
    length(C,N),
    write(C).


unPaso([3,1,0,2,0],[1,1,2,2,1]). %Misioneros -> 
unPaso([3,2,0,1,0],[2,2,1,1,1]).
unPaso([2,2,1,1,0],[0,2,3,1,1]).
unPaso([1,1,2,2,0],[0,1,3,2,1]).

unPaso([1,1,2,2,1],[3,1,0,2,0]). %Misioneros <- 
unPaso([2,2,1,1,1],[3,2,0,1,0]).
unPaso([0,2,3,1,1],[2,2,1,1,0]).
unPaso([0,1,3,2,1],[1,1,2,2,0]).

unPaso([3,3,0,0,0],[3,1,0,2,1]). %Canibales ->
unPaso([3,3,0,0,0],[3,2,0,1,1]).
unPaso([3,2,0,1,0],[3,0,0,3,1]).
unPaso([3,2,0,1,0],[3,1,0,2,1]).
unPaso([3,1,0,2,0],[3,0,0,3,1]).

unPaso([0,3,3,0,0],[0,1,3,2,1]). %Canibales ->
unPaso([0,3,3,0,0],[0,2,3,1,1]).
unPaso([0,2,3,1,0],[0,0,3,3,1]).
unPaso([0,2,3,1,0],[0,1,3,2,1]).
unPaso([0,1,3,2,0],[0,0,3,3,1]).

unPaso([3,1,0,2,1],[3,3,0,0,0]). %Canibales <-
unPaso([3,2,0,1,1],[3,3,0,0,0]).
unPaso([3,0,0,3,1],[3,2,0,1,0]).
unPaso([3,1,0,2,1],[3,2,0,1,0]).
unPaso([3,0,0,3,1],[3,1,0,2,0]).

unPaso([0,1,3,2,1],[0,3,3,0,0]). %Canibales <-
unPaso([0,2,3,1,1],[0,3,3,0,0]).
unPaso([0,0,3,3,1],[0,2,3,1,0]).
unPaso([0,1,3,2,1],[0,2,3,1,0]).
unPaso([0,0,3,3,1],[0,1,3,2,0]).

unPaso([3,3,0,0,0],[2,2,1,1,1]).
unPaso([2,2,1,1,0],[1,1,2,2,1]).
unPaso([1,1,2,2,0],[0,0,3,3,1]).

unPaso([2,2,1,1,1],[3,3,0,0,0]).
unPaso([1,1,2,2,1],[2,2,1,1,0]).
unPaso([0,0,3,3,1],[1,1,2,2,0]).
*/


barco(2).
numberM(3).
numberC(3).


solucionOptima:-
    nat(N),
    camino([3,3,0],[0,0,_],[[3,3,0]],C),
    length(C,N),
    write(C).

numberM(3).
numberC(3).
capacityB(2).

unPaso([M,C,0],[M1,C1,1]):- pasan(PM,PC), M1 is M - PM, C1 is C - PC, safe(M1,C1).
unPaso([M1,C1,1],[M,C,0]):- pasan(PM,PC), M is M1 + PM, C is C1 + PC, safe(M1,C1).



pasan:- barco(B), between(0,B,M), between(0,B,C), M+C >= 0, M+C =< B, safe(M,C).




safe(0,_).
safe(E,E).
safe(M,_):- numberM(M).



