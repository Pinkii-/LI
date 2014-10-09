cd random3SAT/

echo "  ARCHIVO          PICOSAT      O2     O3"

for f in *
do
	echo "$f" "$(../picosat -n --time < $f)" "$(../satSolverSimple4O2 < $f)" "$(../satSolverSimple4O3 < $f)"
done
