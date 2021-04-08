
out=`echo $1 | cut -f1 -d. `

out=$out.csv

cat $1 | grep "B[0-9]-S[0-9]" | tee -a $out
cat $1 | grep "Cost" | cut -f2 -d: | tee -a $out

echo adb pull `pwd`/$out .
echo "Results appended to the $out file."
