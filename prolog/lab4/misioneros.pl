nat(0).
nat(N):- nat(N1), N is N1+1. 

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):- 
    unPaso( EstadoActual, EstSiguiente ), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

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

unPaso([3,3,0,0,0],[3,1,0,2,1]). %Canivales ->
unPaso([3,3,0,0,0],[3,2,0,1,1]).
unPaso([3,2,0,1,0],[3,0,0,3,1]).
unPaso([3,2,0,1,0],[3,1,0,2,1]).
unPaso([3,1,0,2,0],[3,0,0,3,1]).

unPaso([0,3,3,0,0],[0,1,3,2,1]). %Canivales ->
unPaso([0,3,3,0,0],[0,2,3,1,1]).
unPaso([0,2,3,1,0],[0,0,3,3,1]).
unPaso([0,2,3,1,0],[0,1,3,2,1]).
unPaso([0,1,3,2,0],[0,0,3,3,1]).

unPaso([3,1,0,2,1],[3,3,0,0,0]). %Canivales <-
unPaso([3,2,0,1,1],[3,3,0,0,0]).
unPaso([3,0,0,3,1],[3,2,0,1,0]).
unPaso([3,1,0,2,1],[3,2,0,1,0]).
unPaso([3,0,0,3,1],[3,1,0,2,0]).

unPaso([0,1,3,2,1],[0,3,3,0,0]). %Canivales <-
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


