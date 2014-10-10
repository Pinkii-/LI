rm -rf tmp/
echo "BORRO TMP"
mkdir tmp/
echo "CREO TMP"
cd returnPico/
for f in *
do
	echo "$(cat $f | grep time > ../tmp/$f.good)" "$(cat $f | grep propagations >> ../tmp/$f.good)" "$(cat $f | grep decisions >> ../tmp/$f.good)"
done

cd ../tmp/
echo "Estoy en tmp"
rm ../salidaPicoSat
cp ../miniparser.class .
echo "He copiado miniparser"
for f in *.good
do
	echo "PICOSAT Agregando $f a la salida" "$(java miniparser $f >> salidaPicoSat)"
done

mv salidaPicoSat ../.
