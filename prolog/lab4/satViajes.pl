:-include(viaje).
:-dynamic(varNumber/3).
symbolicOutput(0). % set to 1 to see symbolic output only; 0 otherwise.


exactlyOne(Lits):- alo(Lits), amo(Lits).
alo(Lits):- writeClause(Lits).
amo(Lits):-  append( _, [X|Lits1], Lits ),  append( _, [Y|_], Lits1 ), negate(X,NX), negate(Y,NY), writeClause( [ NX, NY ] ), fail.
amo(_).

amo(K, Lits):- lits(K,Lits,S), negateAll(S, Ss), amo(Ss), fail.
amo(_,_).

lits(0,[],[]).
lits(N,[X|L],[X|S]):- N1 is N-1, lits(N1,L,S).
lits(N,[_|L],S):- lits(N,L,S).

negateAll([],[]).
negateAll([X|L],[Y,L1]):- negate(X,Y), negateAll(L,L1).

negate(\+X,X):-!.
negate(X,\+X).

writeClauses:- maxCiudades(N), ciutats(C), amo(N,C), aloCityPerInterest.
writeClauses.

aloCityPerInterest:- interessos(Ints), member(Int, Ints), findall(C, ( atractius(C,A), member(Int,A) ), Lits), exactlyOne(Lits), fail.
aloCityPerInterest.              



displaySol(M):- unix('clear'), nums2vars(M,Ms),
                member(Ciudad, Ms), write(Ciudad), nl, fail.
displaySol(_).

nums2vars([], []).
nums2vars([Nv|S],[X|R]):- num2var(Nv,X), nums2vars(S, R).


% ========== No need to change the following: =====================================

main:- symbolicOutput(1), !, writeClauses, halt. % escribir bonito, no ejecutar
main:- assert(primero), mai2.
mai2:-  checkfirst, retractall(numClauses(_)),
    assert(numClauses(0)),    
    unix('rm header clauses infile.cnf'),
    tell(clauses), writeClauses, told,
    tell(header),  writeHeader,  told,
    unix('cat header clauses > infile.cnf'),
    unix('picosat -v -o model infile.cnf'),
    unix('cat model'),
    see(model), readModel(M), seen, displaySol(M),
    check(M),
    halt.
   
checkfirst:- primero, retract(primero), assert(numVars(0)), assert(maxCiudades(1)).
checkfirst.
 
check(_):- maxCiudades(M), ciutats(C), length(C,LC), M>LC, halt.
check([]):- maxCiudades(M), M1 is M+1, retract(maxCiudades(M)), assert(maxCiudades(M1)), mai2, !.
check(_):- halt.

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
