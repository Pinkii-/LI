nat(0).
nat(N):- nat(N1), N is N1+1. 

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):- 
    unPaso( EstadoActual, EstSiguiente ), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

barco(6).
numberM(3).
numberC(3).


solucionOptima:-
    nat(N),
    camino([3,3,0],[0,0,_],[[3,3,0]],C),
    length(C,N),
    write(C).

unPaso([M,C,0],[M1,C1,1]):- pasan(Mp,Cp), 
                            M1 is M - Mp, M1 >= 0,
                            C1 is C - Cp, C1 >= 0,
                            safe(M1,C1).
unPaso([M1,C1,1],[M,C,0]):- numberM(Mt), numberC(Ct), pasan(PM,PC), 
                            M is M1 + PM, M =< Mt,
                            C is C1 + PC, C =< Ct,
                            safe(M,C).



pasan(M,C):- barco(B), 
             maximoEstosMisioneros(MB), between(0,MB,M), 
             maximoEstosCanibales(CB),  between(0,CB,C),
             M+C > 0, M+C =< B, safeB(M,C).

maximoEstosMisioneros(B):- barco(B), numberM(M), B =< M,!.
maximoEstosMisioneros(M):- numberM(M).

maximoEstosCanibales(B):- barco(B), numberC(C), B =< C,!.
maximoEstosCanibales(C):- numberM(C).

safe(0,_).
safe(M,_):- numberM(M).
safe(M,C):- M >= C, numberM(Mt), numberC(Ct), Mt-M >= Ct-C.

safeB(0,_).
safeB(M,C):- M >= C.


/* hardcodeada buena
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
