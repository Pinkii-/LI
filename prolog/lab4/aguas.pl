nat(0).
nat(N):- nat(N1), N is N1+1. 

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):- 
    unPaso( EstadoActual, EstSiguiente ), \+member(EstSiguiente, CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
    nat(N),
    camino([0,0],[0,4],[[0,0]],C),
    length(C,N),
    write(C).

% Podando y para botellas arbitrarias

bot1(5).
bot2(8). 

unPaso([B1,B2],[L1,B2]):-  bot1(L1), B1 \= L1.
unPaso([B1,B2],[0,B2]):-   B1 \= 0.
unPaso([B1,B2],[B1,L2]):-  bot2(L2), B2 \= L2.
unPaso([B1,B2],[B1,0]):-   B2 \= 0.
unPaso([B1,B2],[BB1,L2]):- B1 \= 0, bot2(L2), B2 \= L2, B1 + B2 >  L2 , BB1 is B1 + B2 - L2. % paso del B1 al B2 y sobra
unPaso([B1,B2],[0,BB2]):-  B1 \= 0, bot2(L2), B2 \= L2, B1 + B2 =< L2 , BB2 is B1 + B2.      % paso del B1 al B2 y falta
unPaso([B1,B2],[L1,BB2]):- bot1(L1), B1 \= L1, B2 \= 0, B1 + B2 >  L1 , BB2 is B1 + B2 - L1. % paso del B2 al B1 y sobra
unPaso([B1,B2],[BB1,0]):-  bot1(L1), B1 \= L1, B2 \= 0, B1 + B2 =< L1 , BB1 is B1 + B2.      % paso del B2 al B1 y falta

% Sin Podar y para botellas de 5 y 8 litros

%unPaso([_,B2],[5,B2]).
%unPaso([_,B2],[0,B2]).
%unPaso([B1,_],[B1,8]).
%unPaso([B1,_],[B1,0]).
%unPaso([B1,B2],[BB1,8]):- B1 + B2 > 8, BB1 is B1 + B2 - 8. % paso del B1 al B2 y sobra
%unPaso([B1,B2],[0,BB2]):- B1 + B2 =< 8, BB2 is B1 + B2. % paso del B1 al B2 y falta
%unPaso([B1,B2],[5,BB2]):- B1 + B2 >  5, BB2 is B1 + B2 - 5. % paso del B2 al B1 y sobra
%unPaso([B1,B2],[BB1,0]):- B1 + B2 =<  5, BB1 is B1 + B2. % paso del B2 al B1 y falta
