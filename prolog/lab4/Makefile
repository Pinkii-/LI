file = satViajes

all: $(file)

$(file): $(file).pl viaje.pl
	swipl -O -g main --stand_alone=true -o $(file) -c $(file).pl

clean:
	rm $(file) *~ clauses infile.cnf model header
