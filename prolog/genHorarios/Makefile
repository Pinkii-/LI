file = sHorario

all: clean $(file)

$(file): $(file).pl
	swipl -O -g main --stand_alone=true -o $(file) -c $(file).pl

clean:
	rm sHorario *~ clauses infile.cnf model header
