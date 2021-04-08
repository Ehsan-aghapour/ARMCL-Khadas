
graphs=("graph_alexnet" "graph_googlenet" "graph_mobilenet" "graph_squeezenet" "graph_resnet50")
path=/data/local/Work/ARMCL
res=$path/cpu_res.log
rm $res
sleep 2
echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor

echo "little governor: "| tee -a $res
cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor | tee -a $res
echo "\nbig governor: " | tee -a $res
cat /sys/devices/system/cpu/cpufreq/policy2/scaling_governor | tee -a $res


cores=("B4-S2" "B4-S1" "B4-S0" "B3-S0" "B2-S0" "B1-S0")
ncores=(6 5 4 3 2 1)
for graph in ${graphs[@]}
   do
   echo "examination_graph:$graph" | tee -a $res
   i=0
   for c in ${cores[@]}
      do
         echo '\n'$c'\n' | tee -a $res
	 echo 'number of cores:'${ncores[$i]}'\n' | tee -a $res
	 g=`echo $graph | cut -f2 -d_ `
	 g=assets_"$g"
	 $path/examples/$graph --target=Neon --threads=${ncores[$i]} --image=/data/local/Work/ARMCL/assets/"$g"/ppm_images/ --labels=/data/local/Work/ARMCL/assets/"$g"/labels.txt | tee -a $res
	 ((i=i+1))
	 sleep 30
      done	
 
   done




