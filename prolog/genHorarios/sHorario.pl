:-include(entradaHoraris1).
:-dynamic(varNumber/3).
symbolicOutput(0). % set to 1 to see symbolic output only; 0 otherwise.

exactlyOne(Lits):- alo(Lits), amo(Lits).
alo(Lits):- writeClause(Lits).
amo(Lits):-  append( _, [X|Lits1], Lits ),  append( _, [Y|_], Lits1 ), negate(X,NX), negate(Y,NY), writeClause( [ NX, NY ] ), fail.
amo(_).

negate(\+X,X):-!.
negate(X,\+X).

% DONE Por cada asignatura y dia , AMO hora. ----Maximo una hora al dia de un asignatura
% DONE Por cada asignatura , exactlyOne aula
% DONE Por cada asignatura , exactlyOne profesor
% DONE Por profesor y hora, AMO clase
% DONE Por aula y hora, AMO clase
% DONE Los cursos no pueden tener horas libres entre medio
% DONE Los cursos no pueden tener mas de 6 horas al dia
% DONE Los cursos no pueden tener horas solapadas

% DONE Una asignatura solo puede tener profesores que impartan esa asignatura
% DONE Una asignatura solo puede tener aulas donde se imparte esa asignatura
% DONE Un profesor no puede trabajar en una hora que tiene prohibida

% ah = "asignatura a en hora h"
% au = "asignatura a en aula u"
% ad = "asignatura a en dia d"
% ap = "asignatura a con profesor p"
% ch = "curso c en hora h"

% Sintaxi: assig(curs,assignatura,hores,llistaAules,llistaProfessors).

numHores(60).
numDies(5).

asig(A):- numAssignatures(NA), between(1,NA,A).
aula(AU):- numAules(NA),       between(1,NA,AU).
prof(P):- numProfes(NP),       between(1,NP,P).
curso(C):- numCursos(NC),      between(1,NC,C).
hora(H):- numHores(NH),        between(1,NH,H).
dia(D):- numDies(ND),          between(1,ND,D).
diaToH(D,H):- between(1, 12, Aux), H is (D-1)*12 + Aux.

writeClauses:-
        amoHoraPerAsigAndDia,                   % Como maximo una hora al dia por asignatura
        exactlyKHoraPerAsig,                    % Exactamente k dias a la semana por cada asignatura
        exactlyOneAulaPerAsigAndAulaPossible,   % Todas las sesiones de una misma asignatura deben impartirse en la misma aula
        exactlyOneProfPerAsigAndProfPossible,   % y por el mismo profesor
        horasProhibidasPorProf,                 % Un profesor no da clase en una hora prohibida
        noCoincidenProf,                        % No hay dos asignaturas a la misma hora que sean impartidas por el mismo profesor
        noCoincidenAulas,                       % No hay dos asignaturas en el mismo aula a la misma hora
        noHorasLibres,                          % Un curso no tiene horas libres entre horas utilizadas en un dia
        noHorasSolapadas,                       % Un curso no puede tener horas solapadas
        amo6HorasDia,                           % Un curso como maximo puede tener 6 horas al dia
        asignarHorasDias,
        asignarAsigCurso
        . 

amoHoraPerAsigAndDia:- asig(A), dia(D), findall( ah-A-H, diaToH(D,H), Lits), amo(Lits), fail.
amoHoraPerAsigAndDia. 

exactlyKHoraPerAsig:- asig(A), assig(_,A,H,_,_), amKHoraPerAsig(A,H), alKHoraPerAsig(A,H), fail. 
exactlyKHoraPerAsig. 

amKHoraPerAsig(A,1):- findall(ad-A-D, dia(D), Lits), amo(Lits), fail.
amKHoraPerAsig(A,2):- dia(D1), dia(D2), D1 < D2, dia(D3), D2 < D3, 
                      writeClause([\+ad-A-D1,\+ad-A-D2,\+ad-A-D3]), fail.
amKHoraPerAsig(A,3):- dia(D1), dia(D2), D1 < D2, dia(D3), D2 < D3, dia(D4), D3 < D4, 
                      writeClause([\+ad-A-D1,\+ad-A-D2,\+ad-A-D3,\+ad-A-D4]), fail.
amKHoraPerAsig(A,4):- dia(D1), dia(D2), D1 < D2, dia(D3), D2 < D3, dia(D4), D3 < D4, dia(D5), D4 < D5, 
                      writeClause([\+ad-A-D1,\+ad-A-D2,\+ad-A-D3,\+ad-A-D4,\+ad-A-D5]), fail.
amKHoraPerAsig(_,_).

alKHoraPerAsig(A,1):- findall(ad-A-D, dia(D), Lits), alo(Lits), fail. 
alKHoraPerAsig(A,2):- dia(D1), dia(D2), D1 < D2, dia(D3), D2 < D3, dia(D4), D3 < D4, 
                      writeClause([ad-A-D1,ad-A-D2,ad-A-D3,ad-A-D4]), fail.
alKHoraPerAsig(A,3):- dia(D1), dia(D2), D1 < D2, dia(D3), D2 < D3, 
                      writeClause([ad-A-D1,ad-A-D2,ad-A-D3]), fail.
alKHoraPerAsig(A,4):- dia(D1), dia(D2), D1 < D2, writeClause([ad-A-D1,ad-A-D2]), fail.
alKHoraPerAsig(A,5):- dia(D), writeClause([ad-A-D]), fail.
alKHoraPerAsig(_,_). 

exactlyOneAulaPerAsigAndAulaPossible:- asig(A), assig(_,A,_,Us,_), findall( au-A-U,member(U,Us), Lits), exactlyOne(Lits), fail.
exactlyOneAulaPerAsigAndAulaPossible.

exactlyOneProfPerAsigAndProfPossible:- asig(A), assig(_,A,_,_,Ps), findall( ap-A-P,member(P,Ps), Lits), exactlyOne(Lits), fail.
exactlyOneProfPerAsigAndProfPossible.

horasProhibidasPorProf:- horesProhibides(P,Hs), assig(_,A,_,_,Ps), member(P,Ps), member(H,Hs), 
                         writeClause( [\+ap-A-P,\+ah-A-H] ), fail.
horasProhibidasPorProf.

noCoincidenProf:- asig(A1), asig(A2), A1<A2, hora(H), prof(P), 
                   assig(_,A1,_,_,Ps1), member(P,Ps1),
                   assig(_,A2,_,_,Ps2), member(P,Ps2),  
                   writeClause( [\+ah-A1-H, \+ah-A2-H, \+ap-A1-P, \+ap-A2-P] ), fail.
noCoincidenProf.

noCoincidenAulas:- asig(A1), asig(A2), A1<A2, hora(H), aula(U), 
                   assig(_,A1,_,Us1,_), member(U,Us1),
                   assig(_,A2,_,Us2,_), member(U,Us2),  
                   writeClause( [\+ah-A1-H, \+ah-A2-H, \+au-A1-U, \+au-A2-U] ), fail.
noCoincidenAulas.

noHorasLibres:- curso(C), dia(D), diaToH(D,H1), diaToH(D,H2), H2 is H1+1, diaToH(D,H3), H3 > H2,
                writeClause( [\+ch-C-H1, ch-C-H2, \+ch-C-H3] ), fail.
noHorasLibres.

noHorasSolapadas:- curso(C), hora(H), assig(C,A1,_,_,_), assig(C,A2,_,_,_), A1 < A2, 
                   writeClause( [ \+ah-A1-H, \+ah-A2-H] ), fail.
noHorasSolapadas.

%amo6HorasDia:- curso(C), dia(D), assig(C,A1,_,_,_), assig(C,A2,_,_,_), A1 < A2, 
%               assig(C,A3,_,_,_), A2 < A3, assig(C,A4,_,_,_), A3 < A4, assig(C,A5,_,_,_),
%               A4 < A5, assig(C,A6,_,_,_), A5 < A6, assig(C,A7,_,_,_), A6 < A7,
%      writeClause([\+ad-A1-D, \+ad-A2-D, \+ad-A3-D, \+ad-A4-D, \+ad-A5-D, \+ad-A6-D, \+ad-A7-D ]), fail.
%amo6HorasDia. :((((( hes mui infisienthe

amo6HorasDia:- curso(C), dia(D), diaToH(D,H1), diaToH(D,H2), H2 is H1 + 6,
                writeClause( [\+ch-C-H1,\+ch-C-H2]),fail.
amo6HorasDia.

asignarHorasDias:- asig(A), dia(D), findall( ah-A-H, diaToH(D,H), Lits ), writeClause([\+ad-A-D|Lits]),
                   member(L,Lits), writeClause( [\+L, ad-A-D] ), fail.
asignarHorasDias.


asignarAsigCurso:- hora(H), curso(C), findall( ah-A-H, assig(C,A,_,_,_), Lits ), writeClause([\+ch-C-H|Lits]),
                   member(L,Lits), writeClause( [\+L, ch-C-H] ), fail. 
asignarAsigCurso.

displaySol(M):- unix('clear'), nums2vars(M,Ms), 
    curso(C), nl, write('          Curs '), write(C),
    assig(C,A,_,_,_), nl, write('Assig '), write(A), 
    member(ap-A-P, Ms), write(' professor '), write(P), 
    member(au-A-U, Ms), write(', aula '), write(U), write(': '),
    write(' hora - '), member(ad-A-D, Ms), member(ah-A-H, Ms), diaToH(D, H), write(H), write(' '), fail. 
displaySol(N):- nl, nl, nums2vars(N,Ms),
    dia(D), nl, write('          Dia '), write(D),
    curso(C), nl, write('Curs '), write(C), write(': '),
    diaToH(D,H), assig(C,A,_,_,_), member(ah-A-H, Ms), write(A), write(' '), fail.  
displaySol(_):- nl.

nums2vars([], []).
nums2vars([Nv|S],[X|R]):- num2var(Nv,X), nums2vars(S, R).

  
% ========= Dani

displaySol(M):- unix('clear'), nums2vars(M,Ms), numCursos(NC),
	between(1,NC,C), nl, write('Curs '), write(C), write(':'), assig(C,I,_,_,_),
	nl, write('Assignatura '), write(I), write(': '), member(p-I-P, Ms),
	write('professor '), write(P), member(a-I-A, Ms), write(', aula '),
	write(A), write('.'), fail.
displaySol(N):- nums2vars(N,Ms), numCursos(NC), between(1,NC,C), nl,
	write('-----------------------------------------------------------'), nl,
	nl, write('Curs '), write(C), write(':'), nl,
	write('-----------------------------------------------------------'), nl,
	write('|        |  Dia 1  |  Dia 2  |  Dia 3  |  Dia 4  |  Dia5  |'), nl,
	between(1,12,Hor), Hora is Hor+7, nl,
	write('-----------------------------------------------------------'), nl,
	write('|Hora '), write(Hora), write('  |'), numDies(ND), between(1,ND,D),
	H is Hor+(12*(D-1)), writeCondicional(C,H,Ms), fail.
displaySol(_):- nl.
writeCondicional(C,H,Ms):- assig(C,I,_,_,_), member(h-I-H, Ms), !,
	write('    '), write(I), write('    |').
writeCondicional(_,_,_):- write('         |').
nums2vars([], []).
nums2vars([Nv|S],[X|R]):- num2var(Nv,X), nums2vars(S, R)

% ===========


% ========== No need to change the following: =====================================

main:- symbolicOutput(1), !, writeClauses, halt. % escribir bonito, no ejecutar
main:-  assert(numClauses(0)), assert(numVars(0)),
	tell(clauses), writeClauses, told,
	tell(header),  writeHeader,  told,
	unix('cat header clauses > infile.cnf'),
	unix('picosat -v -o model infile.cnf'),
	unix('cat model'),
	see(model), readModel(M), seen, displaySol(M),
	halt.

var2num(T,N):- hash_term(T,Key), varNumber(Key,T,N),!.
var2num(T,N):- retract(numVars(N0)), N is N0+1, assert(numVars(N)), hash_term(T,Key),
	assert(varNumber(Key,T,N)), assert( num2var(N,T) ), !.

writeHeader:- numVars(N),numClauses(C),write('p cnf '),write(N), write(' '),write(C),nl.

countClause:-  retract(numClauses(N)), N1 is N+1, assert(numClauses(N1)),!.
writeClause([]):- symbolicOutput(1),!, nl.
writeClause([]):- countClause, write(0), nl.
writeClause([Lit|C]):- w(Lit), writeClause(C),!.
w( Lit ):- symbolicOutput(1), write(Lit), write(' '),!.
w(\+Var):- var2num(Var,N), write(-), write(N), write(' '),!.
w(  Var):- var2num(Var,N),           write(N), write(' '),!.
unix(Comando):-shell(Comando),!.
unix(_).

readModel(L):- get_code(Char), readWord(Char,W), readModel(L1), addIfPositiveInt(W,L1,L),!.
readModel([]).

addIfPositiveInt(W,L,[N|L]):- W = [C|_], between(48,57,C), number_codes(N,W), N>0, !.
addIfPositiveInt(_,L,L).

readWord(99,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!.
readWord(-1,_):-!, fail. %end of file
readWord(C,[]):- member(C,[10,32]), !. % newline or white space marks end of word
readWord(Char,[Char|W]):- get_code(Char1), readWord(Char1,W), !.
%========================================================================================
