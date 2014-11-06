:-include(sud77).
%:-dynamic(varNumber/3).
symbolicOutput(1). % set to 1 to see symbolic output only; 0 otherwise.

%writeClauses:- atleastOneColorPerNode, atmostOneColorPerNode, differentColors.

%atleastOneColorPerNode:- numNodes(N), numColors(K), between(1,N,I),
%	findall( x-I-J, between(1,K,J), C ), writeClause(C), fail.
%atleastOneColorPerNode.

%atmostOneColorPerNode:- numNodes(N), numColors(K), 
%	between(1,N,I), between(1,K,J1), between(1,K,J2), J1<J2,
%	writeClause( [ \+x-I-J1, \+x-I-J2 ] ), fail.
%atmostOneColorPerNode.

% differentColors:- edge(I1,I2), numColors(K), between(1,K,J),
%	writeClause( [ \+x-I1-J, \+x-I2-J ] ), fail.
% differentColors.

% displaySol([]).
% displaySol([Nv|S]):- num2var(Nv,x-I-J), write(I), write(': color '), write(J), nl, displaySol(S).


writeClauses:- exactlyOneValuePerSquare, exactlyOneColPerValAndRow, exactlyOneRowPerValAndCol.

exactlyOne(Lits):- alo(Lits), amo(Lits).
alo(Lits):- writeClause(Lits).
amo(Lits):-  append( _, [X|Lits1], Lits ),  append( _, [Y|_], Lits1 ), negate(X,NX), negate(Y,NY), writeClause( [ NX, NY ] ), fail.
amo(_).

negate(\+X,X):-!.
negate(X,\+X).


exactlyOneValuePerSquare:-  row(I), col(J), findall( x-I-J-K, val(K), Lits ), exactlyOne(Lits), fail.
exactlyOneValuePerSquare.

exactlyOneColPerValAndRow:- row(I), val(K), findall( x-I-J-K, col(J), Lits ), exactlyOne(Lits), fail.
exactlyOneColPerValAndRow.

exactlyOneRowPerValAndCol:- val(K), col(J), findall( x-I-J-K, row(I), Lits ), exactlyOne(Lits), fail.
exactlyOneRowPerValAndCol.

exactlyOneValPerBlock:- between(0,8,B), block(I,J,B), findall( x-I-J-K, val(K), Lits ), exactyOne(Lits), fail.
exactlyOneValPerBlock.

square(I,J):- row(I), col(J).
row(I):- between(1,9,I).
col(J):- between(1,9,J).
val(K):- between(1,9,K).
block(I,J,B):- I is B // 3, J is B mod 3. 


sameRow(I,J1,I,J2):- square(I,J1), square(I,J2).

sameCol(I1,J,I2,J):- square(I1,J), square(I2,J).

sameBlock(I1,J1,I2,J2) :-
    square(I1,J1),
    square(I2,J2),
    I is (I1-1)/3,
    I is (I2-1)/3,
    J is (J1-1)/3,
    J is (J2-1)/3.


%displaySol([Nv|S]):- num2var(Nv,x-I-J-K),
%                between(1,9,I),
%                nl, between(1,9,J),
%e                member(x-I-J-K,Ms), write(K), write(' '), fail.

%displaySol(M):- symbolic(M,Ms),
%                between(1,9,I),
%                nl, between(1,9,J),
%                member(x-I-J-K,Ms), write(K), write(' '), fail.







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
