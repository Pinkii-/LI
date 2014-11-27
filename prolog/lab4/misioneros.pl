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

unPaso([M1,C1,M2,C2,B],[NM1,NC1,NM2,NC2,V):- V is 1-B,  
