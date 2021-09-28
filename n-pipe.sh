export LD_LIBRARY_PATH=/data/data/com.termux/files/home/ARMCL-Khadas/lib/
chmod +x test_graph/graph_alexnet_n_pipe
./test_graph/graph_alexnet_n_pipe --target=CL --threads=4  --threads2=2 --n=10 --total_cores=6 --partition_point=2 --partition_point2=3 --order=GGLBBBBB
