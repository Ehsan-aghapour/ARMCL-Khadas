
echo 4 > /sys/class/mpgpu/max_freq
echo 4 > /sys/class/mpgpu/min_freq
echo "Current min freq:"
cat /sys/class/mpgpu/min_freq
echo "Current ferq:"
cat /sys/class/mpgpu/cur_freq

sleep 2

export LD_LIBRARY_PATH=/data/local/Work/ARMCL/lib/
path=/data/local/Work/ARMCL
graphs=("graph_alexnet" "graph_googlenet" "graph_mobilenet" "graph_squeezenet" "graph_resnet50")

res=$path/gpu_res.log
mv $res "$res".old

for graph in ${graphs[@]}
do


	#res=$path/gpu_"$graph"_res.log
	#res_csv=`echo $res | cut -f1 -d. `
	#res_csv="$res_csv".csv
	#mv $res "$res".old

	#$path/$1 $path/examples/$graph CL $2 $3 | tee -a $res
	g=`echo $graph | cut -f2 -d_ `
	#examples/$graph --target=CL --threads=$1 --image=/data/local/Work/ARMCL/assets/assets_"$g"/ppm_images/ --labels=/data/local/Work/ARMCL/assets/assets_"$g"/labels.txt | tee -a $res
        examples/$graph --target=CL | tee -a $res                                                                                                                                               
	echo "Current ferq:"
	cat /sys/class/mpgpu/cur_freq
	sleep 20
	echo 4 > /sys/class/mpgpu/max_freq
	echo 4 > /sys/class/mpgpu/min_freq	
done
