cd random3SAT/
for f in *
do
	echo "PICOSAT $f" "$(../picosat -v < $f > ../returnPico/$f)"
done
