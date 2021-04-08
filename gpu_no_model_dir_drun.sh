echo 4 > /sys/class/mpgpu/max_freq
echo 4 > /sys/class/mpgpu/min_freq
echo "Current min freq:"
cat /sys/class/mpgpu/min_freq
echo "Current ferq:"
cat /sys/class/mpgpu/cur_freq



echo $1 
echo $2
echo $3
echo $4

export LD_LIBRARY_PATH=/data/local/Work/ARMCL/lib/

sleep 5
#/bin/time ./$1 --target=$2 --image=/data/local/Work/ARMCL/$4 --labels=/data/local/Work/ARMCL/$3/labels.txt
/bin/time ./$1 --target=$2 
