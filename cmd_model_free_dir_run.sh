
echo $1 
echo $2
echo $3
echo $4
echo $5
sleep 5
/bin/time $1 --target=$2 --threads=$4 --image=/data/local/Work/ARMCL/$6 --labels=/data/local/Work/ARMCL/$5/labels.txt
