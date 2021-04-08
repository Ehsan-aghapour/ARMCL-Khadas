
graph=graph_alexnet
path=/data/local/Work/ARMCL
res=$path/"$graph"_res.log
res_csv=`echo $res | cut -f1 -d. `
res_csv="$res_csv".csv
mv $res "$res".old
sleep 2
echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor

echo "little governor: "| tee -a $res
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor | tee -a $res
echo "\nbig governor: " | tee -a $res
cat /sys/devices/system/cpu/cpufreq/policy2/scaling_governor | tee -a $res



echo '\n'B4-S2'\n' | tee -a $res
sleep 5

$path/drun.sh $path/examples/$graph Neon 3F 6 | tee -a $res
sleep 40

echo B4-S1'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 3E 5 | tee -a $res
sleep 40

echo B4-S0'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 3C 4 | tee -a $res
sleep 40

echo B3-S0'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 38 3 | tee -a $res
sleep 40

echo B2-S0'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 30 2 | tee -a $res
sleep 40

echo B1-S0'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 20 1 | tee -a $res
sleep 80

#####littles

echo B3-S2'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 2F 5 | tee -a $res
sleep 60

echo B2-S2'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 0F 4 | tee -a $res
sleep 40

echo B1-S2'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 0B 3 | tee -a $res
sleep 40

echo B0-S2'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 03 2 | tee -a $res
sleep 40

echo B0-S1'\n' | tee -a $res
$path/drun.sh $path/examples/$graph Neon 02 1 | tee -a $res



grep "COST" $res

res_csv=`echo $res | cut -f1 -d. `
res_csv="$res_csv".csv

awk -F'[ :,\/]' '/B[0-9]-S[0-9]/{k=$1} /examples\/graph_/{graph=$NF}  /Cost/{z[graph][k]=z[graph][k] OFS $2} END{ for(gr in z){print OFS gr;for(cnf in z[gr]) {print cnf z[gr][cnf]} }} ' OFS=, $res > $res_csv



