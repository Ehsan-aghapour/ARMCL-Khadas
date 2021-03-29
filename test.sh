
echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor

echo 4 > /sys/class/mpgpu/max_freq
echo 4 > /sys/class/mpgpu/min_freq
echo "Current GPU min freq:"
cat /sys/class/mpgpu/min_freq
echo "Current GPU ferq:"
cat /sys/class/mpgpu/cur_freq


sleep 2


export LD_LIBRARY_PATH=/data/data/com.termux/files/home/ARMCL-Khadas/lib/

chmod +x $1

p="/data/data/com.termux/files/home/ARMCL-Khadas"
#p=".."

_dt="$p/compute_library_alexnet/"
#_dt="/data/data/com.termux/files/home/ARMCL-Khadas/assets/Save/Alexnet_Save/"
#_img="$p/one_image/"
#_img="$p/assets/assets_alexnet/ppm_images/"
_img="/data/data/com.termux/files/home/ARMCL-Khadas/assets/assets_resnet50/ppm_images/"
_lbl="$p/compute_library_alexnet/labels.txt"


lbl=""
img=""
dt=""

if [ "$3" -eq 1 ]; then
    lbl="--labels=$_lbl";
fi

if [ "$4" -eq 1 ]; then
    #img="--image=$_img"
    dt="--data=$_dt"
fi


if [ "$5" -eq 1 ]; then
    img="--image=$_img"
fi




echo $img
echo $dt
echo $lbl


$1 --threads=4  --target=$2 $dt $img $lbl --partition_point=$6 
