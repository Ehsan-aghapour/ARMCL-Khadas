
graph=graph_googlenet
path=/data/local/Work/ARMCL
res=$path/gpu_"$graph"_res.log
res_csv=`echo $res | cut -f1 -d. `
res_csv="$res_csv".csv
mv $res "$res".old
sleep 2
#echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
#echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor

echo 4 > /sys/class/mpgpu/max_freq                                                                                                   
echo 4 > /sys/class/mpgpu/min_freq                                                                                                   
echo "Current min freq:"
cat /sys/class/mpgpu/min_freq 
echo "Current ferq:"
cat /sys/class/mpgpu/cur_freq


#echo "little governor: "| tee -a $res
#cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor | tee -a $res
#echo "\nbig governor: " | tee -a $res
#cat /sys/devices/system/cpu/cpufreq/policy2/scaling_governor | tee -a $res

export LD_LIBRARY_PATH=/data/local/Work/ARMCL/lib/

$path/$1 $path/examples/$graph CL $2 $3 | tee -a $res

grep "COST" $res

