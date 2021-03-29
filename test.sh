
export LD_LIBRARY_PATH=/data/data/com.termux/files/home/ARMCL-Khadas/lib/

chmod +x $1

p="/data/data/com.termux/files/home/ARMCL-Khadas"

_dt="$p/compute_library_alexnet"
_img="$p/one_image/"
_lbl="$p/compute_library_alexnet/labels.txt"


lbl=""
img=""
dt=""

if [ "$3" ]; then
    lbl="--labels=$_lbl";
fi

if [ "$4" ]; then
    img="--image=$_img"
    dt="--data=$_dt"
fi

echo $img
echo $dt
echo $lbl


$1 --target=$2 $dt $img $lbl  
