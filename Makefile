all: buenSat picosat

satSolver: satSolver.cpp

	g++ satSolver.cpp -o satSolver

SAT-alumnes: SAT-alumnes.cpp

	g++ SAT-alumnes.cpp -o satSolver

miSatSolver: miSatSolver.cpp

	g++ -O2 miSatSolver.cpp -o miSatSolver

satSolverSimple: satSolverSimple.cpp

	g++ -O2 satSolverSimple.cpp -o satSolverSimple

satSolverSimple2: satSolverSimple2.cpp

	g++ -O2 satSolverSimple2.cpp -o satSolverSimple2

satSolverSimple3: satSolverSimple3.cpp

	g++ -O2 satSolverSimple3.cpp -o satSolverSimple3

ohyeah: buenSat picosat parser execute parseamelotodaa 

buenSat: satSolverSimple4O3

satSolverSimple4O2: satSolverSimple4.cpp

	g++ -O2 satSolverSimple4.cpp -o satSolverSimple4O2

satSolverSimple4O3: satSolverSimple4.cpp

	g++ -O3 satSolverSimple4.cpp -o satSolverSimple4O3

picosat: picosat-959/configure
	./compPico.sh
	mv picosat-959/picosat .

parser: parser.java miniparser.java
	javac miniparser.java
	javac parser.java

execute: exe.sh
	sh exe.sh > salidaMiSat
	sh exePico.sh

parseamelotodaa: salidaMiSat picoParser.sh
	sh picoParser.sh
	java parser salidaMiSat salidaPicoSat > bonito

clean:

	rm -rf satSolver resultado miSatSolver satSolverSimple satSolverSimple2 satSolverSimple3 satSolverSimple4O2 satSolverSimple4O3 picosat parser.class miniparser.class salidaMiSat salidaPicoSat tmp/ *~
