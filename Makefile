all: satSolver

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

clean:

	rm satSolver resultado miSatSolver satSolverSimple satSolverSimple2
