
B=(500000 667000 1000000 1200000 1398000 1512000 1608000 1704000 1800000 1908000 2016000 2100000 2208000)
L=(500000 667000 1000000 1200000 1398000 1512000 1608000 1704000 1800000)

echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor

echo ${B[${10}]} > /sys/devices/system/cpu/cpufreq/policy2/scaling_max_freq

cat /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq

echo 4 > /sys/class/mpgpu/max_freq
echo 4 > /sys/class/mpgpu/min_freq
##echo "Current GPU min freq:"
##cat /sys/class/mpgpu/min_freq
##echo "Current GPU ferq:"
##cat /sys/class/mpgpu/cur_freq


sleep 2


export LD_LIBRARY_PATH=/data/data/com.termux/files/home/ARMCL-Khadas/lib/

chmod +x $1

p="/data/data/com.termux/files/home/ARMCL-Khadas"
#p=".."

#_dt="$p/compute_library_alexnet/"
_dt1="$p/assets/Save/alexnet/"
_dt2="$p/assets/Save/googlenet/"
_dt3="$p/assets/Save/mobilenet/"
_dt4="$p/assets/Save/resnet50/"
_dt5="$p/assets/Save/squeezenet/"

#_img="$p/one_image/"
#_img="$p/assets/assets_alexnet/ppm_images/"
#_img="/data/data/com.termux/files/home/ARMCL-Khadas/assets/assets_resnet50/ppm_images/"

_img1="$p/assets/Save/ppm_images_227/"
_img2="$p/assets/Save/ppm_images_224/"


_lbl="$p/assets/Save/labels.txt"


lbl=""
img=""
dt=""

if [ "$5" -eq 1 ]; then
    lbl="--labels=$_lbl";
fi

if [ "$4" -eq 1 ]; then
    #img="--image=$_img"
    dt="--data=$_dt1"
fi


if [ "$4" -eq 2 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt2"     
fi 

if [ "$4" -eq 3 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt3"     
fi 

if [ "$4" -eq 4 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt4"     
fi 

if [ "$4" -eq 5 ]; then                                                                
    #img="--image=$_img"                    
    dt="--data=$_dt5"     
fi 

if [ "$3" -eq 1 ]; then
    img="--image=$_img1"
fi

if [ "$3" -gt 1 ]; then
    img="--image=$_img2"
fi

n=""
if [ "$6" ]; then
    n="--n=$6"
fi

#echo $img
#echo $dt
#echo $lbl


$1 --threads=4  --target=$2 $dt $img $lbl $n --save=$7 --annotate=$8 --partition_point=$9 
