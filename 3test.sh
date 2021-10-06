



######## for Khadas AOSP(CPU) ##############
#echo performance > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
#echo performance > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor

######## for Google AOSP(CPU) ##############
echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo userspace > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor
echo 1800000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
echo 2208000 > /sys/devices/system/cpu/cpufreq/policy2/scaling_setspeed


######## for Khadas AOSP(GPU) ##############
#echo 4 > /sys/class/mpgpu/max_freq
#echo 4 > /sys/class/mpgpu/min_freq

######## for Google AOSP(GPU) #########
echo userspace > /sys/class/devfreq/ffe40000.gpu/governor
cat /sys/class/devfreq/ffe40000.gpu/governor
echo 799999987 > /sys/class/devfreq/ffe40000.gpu/userspace/set_freq
cat /sys/class/devfreq/ffe40000.gpu/cur_freq

##echo "Current GPU min freq:"
##cat /sys/class/mpgpu/min_freq
##echo "Current GPU ferq:"
##cat /sys/class/mpgpu/cur_freq


sleep 2


export LD_LIBRARY_PATH=/data/data/com.termux/files/home/ARMCL-Khadas/lib64/

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

#gdbserver :539 
echo "$1 --threads=4  --threads2=2  --target=$2 $dt $img $lbl $n --save=$7 --annotate=$8 --partition_point=$9 --partition_point2=${10} --order=${11} --layer_time=${12} ${13} ${14} ${15} ${16} ${17}"


$1 --threads=4  --threads2=2  --target=$2 $dt $img $lbl $n --save=$7 --annotate=$8 --partition_point=$9 --partition_point2=${10} --order=${11} --layer_time=${12} ${13} ${14} ${15} ${16} ${17} 
