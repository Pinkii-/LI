all: satSolver

satSolver: satSolver.cpp

	g++ satSolver.cpp -o satSolver

clean:

	rm satSolver resultado
