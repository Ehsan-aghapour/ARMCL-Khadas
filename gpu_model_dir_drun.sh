
echo $1 
echo $2
echo $3
echo $4

sleep 5
/bin/time $1 --target=$2 --data=/data/local/Work/ARMCL/$3 --image=/data/local/Work/ARMCL/$4 --labels=/data/local/Work/ARMCL/$3/labels.txt
