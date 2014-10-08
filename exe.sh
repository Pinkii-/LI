cd random3SAT/
for f in *
do
	echo "$f" "` ../satSolverSimple4 < $f`"
done
