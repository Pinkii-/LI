cd random3SAT/
for f in *
do
	echo "$f" "` ../satSolver < $f`"
done
