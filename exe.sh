cd random3SAT/
for f in vars-1*
do
	echo "$f" "` ../miSatSolver < $f`"
done
