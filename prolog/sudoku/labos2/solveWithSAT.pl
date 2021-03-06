:-include(sud23).
:-dynamic(varNumber/3).
symbolicOutput(0). % set to 1 to see symbolic output only; 0 otherwise.

writeClauses:- exactlyOneValuePerSquare, exactlyOneColPerValAndRow, exactlyOneRowPerValAndCol, exactlyOneValPerBlock, fill.

fill:- filled(I,J,K), writeClause( [ x-I-J-K ] ), fail.
fill.

exactlyOne(Lits):- alo(Lits), amo(Lits).
alo(Lits):- writeClause(Lits).
amo(Lits):-  append( _, [X|Lits1], Lits ),  append( _, [Y|_], Lits1 ), negate(X,NX), negate(Y,NY), writeClause( [ NX, NY ] ), fail.
amo(_).

negate(\+X,X):-!.
negate(X,\+X). 


exactlyOneValuePerSquare:-  row(I), col(J), findall( x-I-J-K, val(K), Lits ), exactlyOne(Lits), fail.
exactlyOneValuePerSquare.

exactlyOneColPerValAndRow:- row(I), val(K), findall( x-I-J-K, col(J), Lits ), amo(Lits), fail.
exactlyOneColPerValAndRow.

exactlyOneRowPerValAndCol:- val(K), col(J), findall( x-I-J-K, row(I), Lits ),amo(Lits), fail.
exactlyOneRowPerValAndCol.

exactlyOneValPerBlock:- bck(B), val(K), findall( x-I-J-K, block(I,J,B), Lits ), amo(Lits), fail.
exactlyOneValPerBlock.

square(I,J):- row(I), col(J).
row(I):- between(1,9,I).
col(J):- between(1,9,J).
val(K):- between(1,9,K).
bck(B):- between(0,8,B).

block(I,J,B):- between(1,3,I1), between(1,3,J1), I is (B // 3)*3+I1, J is (B mod 3)*3+J1. 

displaySol(M):- unix('clear'),
                nums2vars(M,Ms),
                between(1,9,I),
                nl, between(1,9,J),
                member(x-I-J-K,Ms), write(K), write(' '), fail.
displaySol(_).

nums2vars([], []).
nums2vars([Nv|S],[X|R]):- num2var(Nv,X), nums2vars(S, R).



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
