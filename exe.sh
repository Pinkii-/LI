cd random3SAT/
for f in *
do
	echo "$f" "` ../satSolverSimple3 < $f`"
done
