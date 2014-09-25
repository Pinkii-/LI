cd random3SAT/
for f in *
do
	echo "$f" "` ../SatSolver < $f`"
done
