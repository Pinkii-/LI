cd random3SAT/
for f in *
do
	echo "$f" "` ../satSolverSimple2 < $f`"
done
