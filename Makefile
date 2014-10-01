all: satSolver

satSolver: satSolver.cpp

	g++ satSolver.cpp -o satSolver

SAT-alumnes: SAT-alumnes.cpp

	g++ SAT-alumnes.cpp -o satSolver

miSatSolver: miSatSolver.cpp

	g++ -O2 miSatSolver.cpp -o miSatSolver

clean:

	rm satSolver resultado
