cd random3SAT/

echo "  ARCHIVO                     PICOSAT           MASHIT   Decisiones Propagaciones/s"

for f in *
do
	echo "$f" "$(../picosat -n --time < $f)" "$(../satSolverSimple4O3 < $f)"
done
