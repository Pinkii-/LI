all: satSolver

satSolver: satSolver.cpp

	g++ satSolver.cpp -o satSolver

SAT-alumnes: SAT-alumnes.cpp

	g++ SAT-alumnes.cpp -o satSolver

clean:

	rm satSolver resultado
