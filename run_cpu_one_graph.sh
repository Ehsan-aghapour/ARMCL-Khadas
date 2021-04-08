
graph=graph_googlenet
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

$path/$1 $path/examples/$graph Neon 3F 6 $2 $3 | tee -a $res
sleep 20

echo B4-S1'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 3F 5 $2 $3 | tee -a $res
sleep 20

echo B4-S0'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 3F 4 $2 $3 | tee -a $res
sleep 20

echo B3-S0'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 3F 3 $2 $3 | tee -a $res
sleep 20

echo B2-S0'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 3F 2 $2 $3 | tee -a $res
sleep 20

echo B1-S0'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 3F 1 $2 $3 | tee -a $res
sleep 20

#####littles
:'
echo B3-S2'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 2F 5 $2 $3 | tee -a $res
sleep 60

echo B2-S2'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 0F 4 $2 $3 | tee -a $res
sleep 40

echo B1-S2'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 0B 3 $2 $3 | tee -a $res
sleep 40

echo B0-S2'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 03 2 $2 $3 | tee -a $res
sleep 40

echo B0-S1'\n' | tee -a $res
$path/$1 $path/examples/$graph Neon 02 1 $2 $3 | tee -a $res

'

grep "COST" $res

res_csv=`echo $res | cut -f1 -d. `
res_csv="$res_csv".csv

awk -F'[ :,\/]' '/B[0-9]-S[0-9]/{k=$1} /examples\/graph_/{graph=$NF}  /Cost/{z[graph][k]=z[graph][k] OFS $2} END{ for(gr in z){print OFS gr;for(cnf in z[gr]) {print cnf z[gr][cnf]} }} ' OFS=, ${res} > ${res_csv}



