nat(0).
nat(N):- nat(N1), N is N1+1. 

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):- 
    unPaso( EstadoActual, EstSiguiente ), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
    nat(N),
    camino([0,0,0,0,0,0],[1,1,1,1,1,S],[[0,0,0,0,0,0]],C),
    S == N,
    write(C), 
    nl,
    fail.

% [P1,P2,P5,P8,L,S]
% Pi persona que tarda i en cruzar el puente
% L linterna que esta en el lado izquierdo(0) o derecho(1) del puente
% S suma del tiempo


unPaso([1,P2,P5,P8,1,S],[0,P2,P5,P8,0,S1]):- S1 is S+1.
unPaso([P1,1,P5,P8,1,S],[P1,0,P5,P8,0,S1]):- S1 is S+2.
unPaso([P1,P2,1,P8,1,S],[P1,P2,0,P8,0,S1]):- S1 is S+5.
unPaso([P1,P2,P5,1,1,S],[P1,P2,P5,0,0,S1]):- S1 is S+8.

unPaso([0,0,P5,P8,0,S],[1,1,P5,P8,1,S1]):- S1 is S+2.

unPaso([0,P2,0,P8,0,S],[1,P2,1,P8,1,S1]):- S1 is S+5.
unPaso([P1,0,0,P8,0,S],[P1,1,1,P8,1,S1]):- S1 is S+5.
    
unPaso([0,P2,P5,0,0,S],[1,P2,P5,1,1,S1]):- S1 is S+8.
unPaso([P1,0,P5,0,0,S],[P1,1,P5,1,1,S1]):- S1 is S+8.
unPaso([P1,P2,0,0,0,S],[P1,P2,1,1,1,S1]):- S1 is S+8.









